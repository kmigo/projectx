
// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart' show MultipartFile;

class MultiTypeFile {
  final String filename;
  final MultipartFile file;
  MultiTypeFile({
    required this.file,
    required this.filename
  });

}
