// ignore_for_file: avoid_web_libraries_in_flutter
part of 'helpers.dart';

class HelperFiles {
  static Future<String> getImageBase64() async {
  final completer = Completer<String>();
  final html.InputElement input = html.document.createElement('input')as html.InputElement;
  input.type = 'file';
  input.accept = 'image/*';
  input.onChange.listen((e) {
    final files = input.files;
    if (files?.length == 1) {
      final file = files![0];
      final reader = html.FileReader();
      reader.onLoadEnd.listen((e) {
        completer.complete(reader.result as String);
      });
      reader.readAsDataUrl(file);
    }
  });
  input.click();
  return completer.future;
}
}