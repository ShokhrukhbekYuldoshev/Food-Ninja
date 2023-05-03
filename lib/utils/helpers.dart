import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<File?> compressFile(File file, String targetPath) async {
  final result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: 70,
  );

  return result;
}

bool validatePhoneNumber(String value) {
  if (value.isEmpty) {
    return false;
  }
  const pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(value)) {
    return false;
  }
  return true;
}
