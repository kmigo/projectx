// ignore_for_file: avoid_print, unnecessary_import

import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:micro_commons/src/services/http/service.dart';
import 'package:micro_core/micro_core.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';



import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';

import '../../domain/erros/failure.dart';
import '../../models/models.dart';


class HttpClientDio extends ClientHttp {
  late Dio _dio;
  final Future<String?> Function()? _getToken;

  HttpClientDio(
      {required String baseUrl,
      Future<String?> Function()? getToken,
      Future<dynamic> Function()? signOut,
      bool Function(String)? tokenIsExpired,
      Future<dynamic> Function()? refreshToken})
      : _getToken = getToken {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));
    _dio.interceptors.add(interceptorTokenExpired(
        refreshToken, signOut, tokenIsExpired, request));
  }

  @override
  Future<ClientResponse> delete(String url,
      {Map<String, dynamic>? queryString,
      Map<String, dynamic>? headers,
      json}) async {
    return request('DELETE', url,
        queryString: queryString, json: json, headers: headers);
  }

  @override
  Future<ClientResponse> get(String url,
      {Map<String, dynamic>? queryString,
      Map<String, dynamic>? headers}) async {
    return request('GET', url, queryString: queryString, headers: headers);
  }

  @override
  Future<ClientResponse> post(String url,
      {Map<String, dynamic>? queryString,
      Map<String, dynamic>? headers,
      json}) async {
    return request('POST', url,
        queryString: queryString, json: json, headers: headers);
  }

  @override
  Future<ClientResponse> put(String url,
      {Map<String, dynamic>? queryString,
      Map<String, dynamic>? headers,
      json}) async {
    return request('PUT', url,
        queryString: queryString, json: json, headers: headers);
  }

  @override
  Future<ClientResponse> request(String method, String url,
      {Map<String, dynamic>? queryString,
      Map<String, dynamic>? headers,
      json,
      bool retry = false}) async {
    headers = headers ?? {};
    final token = await _getToken?.call() ?? '';
    debugPrint(token);
    dev.log('token: $token');
    const  id =  Uuid();
    headers.addAll({
      'Authorization': 'Bearer $token',
      'Access-Control-Allow-Headers': '*',
      'Content-Type': 'application/json',
      'correlation-id': id.v4().toString()
    });
    dev.log("headers: $headers");
    Options options = Options(method: method, headers: headers);
    final newDio = retry == true
        ? Dio(BaseOptions(baseUrl: _dio.options.baseUrl + url))
        : _dio;
    final now = DateTime.now();
    try {
      _log(
          title: 'REQUEST',
          data: json,
          queryString: queryString,
          method: method,
          headers: headers,
          statusCode: '---',
          url: url);
      final result = await newDio.request(url.toString(),
          options: options, data: json, queryParameters: queryString);
      final status = result.statusCode ?? 500;
      _log(
          title: 'RESPONSE',
          method: method,
          data: result.data,
          queryString: queryString,
          headers: headers,
          statusCode: status,
          url: result.realUri,
          createAt: now);

      return ClientResponse(
          status: status,
          data: result.data,
          isSuccessfull: status >= 200 && status <= 299,
          response: result);
    } on DioException catch (e) {
      final status = e.response?.statusCode ?? 500;
      _log(
          title: 'DIOEXCEPTION',
          method: method,
          data: e.response?.data,
          queryString: queryString,
          headers: headers,
          statusCode: status,
          url: url,
          createAt: now);
      if (retry) {
        return ClientResponse(
            status: status, data: e.response?.data, isSuccessfull: false);
      }
      throw FailureRequest(
          fallBackMessage: genericError.message!,
          statusCode: status,
          data: e.response?.data,
          path: url);
    } catch (e) {
      _log(
          title: 'ERROR',
          data: json,
          queryString: queryString,
          method: method,
          headers: headers,
          statusCode: 500,
          url: _dio.options.baseUrl + url,
          createAt: now);
      if (retry) {
        return const ClientResponse(
            status: 500, data: {}, isSuccessfull: false);
      }
      throw Failure(message: genericError.message);
    }
  }

  _log(
      {required String title,
      dynamic data,
      dynamic headers,
      dynamic method,
      dynamic queryString,
      dynamic statusCode,
      dynamic url,
      DateTime? createAt}) {
    dev.log('#' * 60);

    dev.log('\n');
    final now = DateTime.now();
    String color = '\x1B[6;30;33m';
    if (['ERROR', 'DIOEXCEPTION'].contains(title)) {
      color = '\x1B[6;30;31m';
    }
    if (['RESPONSE'].contains(title)) {
      color = '\x1B[6;30;32m';
    }

    String ms = '';
    if (createAt != null) {
      ms = '[${now.difference(createAt).inMilliseconds} ms]';
    }

    debugPrint('$color-- $title($now) $ms ## -> PATH:\x1B[0m $url');
    debugPrint(
        "$color-- $title($now) $ms ## -> QUERYPARAMS: \x1B[0m ${ const JsonEncoder.withIndent('  ').convert(queryString)}");
    debugPrint(
        '$color-- $title($now) $ms ## -> STATUS CODE:\x1B[0m $statusCode');
    debugPrint('$color-- $title($now) $ms ## -> METHOD: \x1B[0m $method');
    if (data is FormData) {

      debugPrint('$color-- $title($now) $ms ## -> DATA:\x1B[0m ${data.fields}\n${data.files}');
      if(data.files.isNotEmpty){
        for(var file in data.files){
          debugPrint('$color-- $title($now) $ms ## -> DATA:\x1B[0m ${file.value.filename}');
        }
      }
    } else {
      debugPrint(
          '$color-- $title($now) $ms ## -> DATA:\x1B[0m ${const JsonEncoder.withIndent('  ').convert(data)}');
    }

    debugPrint(
        '$color-- $title($now) $ms ## -> HEADERS: \x1B[0m${const JsonEncoder.withIndent('  ').convert(headers)}');

   
  }
}

interceptorTokenExpired(
        Future<dynamic> Function()? refreshToken,
        Future<dynamic> Function()? signOut,
        bool Function(String)? tokenIsExpired,
        Future<ClientResponse> Function(String method, String url,
                {Map<String, dynamic>? queryString,
                Map<String, dynamic>? headers,
                dynamic json,
                bool retry})
            retryRequest) =>
    InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (e, handler) async {
      final headers = e.requestOptions.headers;
      String? token = headers["Authorization"];
      if (token?.isNotEmpty == true) {
        token = token!.split(" ")[1];
        if (tokenIsExpired?.call(token) == true) {
          dev.log('%%%%%%%%%%%%%% Token has expired %%%%%%%%%%%',
              name: 'TOKEN EXPIRED');
          await refreshToken?.call();
          dev.log("------ Retry Connection --------", name: 'RETRY CONNECTION');
          if (refreshToken == null) return handler.reject(e);
          final result = await retryRequest(
              e.requestOptions.path, e.requestOptions.method,
              headers: e.requestOptions.headers,
              json: e.requestOptions.data,
              queryString: e.requestOptions.queryParameters,
              retry: true);
          if (!result.isSuccessfull) {
            await signOut?.call();
            return handler.reject(e);
          }
          return handler.resolve(result.response);
        }
      }
      return handler.reject(e);
    });
// ignore_for_file: depend_on_referenced_packages

class CustomFormData {
  static FormData fromMap(Map<String, dynamic> data, {List<File>? files,List<MultiTypeFile>? bytes}) {
    FormData formData = FormData.fromMap(data);
    if (files != null && files.isNotEmpty) {
      for (var element in files) {
        formData.files.add(MapEntry(
            'files',
            CustomMultipartFile.fromFiles(
                fileName: element.path, imageData: element.readAsBytesSync())));
      }
    }
    if(bytes != null && bytes.isNotEmpty){
      for(var byte in bytes){
        formData.files.add(MapEntry(
            'files',
             byte.file));
      }
    }
    return formData;
  }
}



class CustomMultipartFile {
  static MultipartFile fromFiles(
      {required String fileName,
      required Uint8List imageData,
      String mediaType = 'image/png'}) {
    final imageTypeSplit = mediaType.split('/');
    MultipartFile file = MultipartFile.fromBytes(imageData,
        filename: fileName,
        contentType: MediaType(imageTypeSplit[0], imageTypeSplit[1]));
    return file;
  }

  static MultiTypeFile generateFile(String filename, Uint8List bytes){
    return MultiTypeFile(file:MultipartFile.fromBytes(bytes,filename: filename),filename: filename);
  }
}
