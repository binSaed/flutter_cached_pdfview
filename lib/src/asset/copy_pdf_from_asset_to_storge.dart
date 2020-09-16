import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<File> getPdfFromAsset(String assetPath) async {
// To open from assets, you can copy them to the app storage folder, and then access them "locally"
  assert(assetPath.toLowerCase().endsWith('.pdf'),
      throw '($assetPath) should endsWith ".pdf".');
  final RegExp regexp = RegExp(r'[\w-]+\.(pdf|PDF)');
  final String pdfName = regexp.stringMatch(assetPath);

  final Directory dir = await getApplicationDocumentsDirectory();
  File file = File('${dir.path}/$pdfName');
  try {
    if (!file.existsSync()) {
      //not exist
      final ByteData data = await rootBundle.load(assetPath);
      final Uint8List bytes = data.buffer.asUint8List();
      file = await file.writeAsBytes(bytes);
    }
    return file;
  } on Exception catch (e) {
    throw Exception('Error opening asset file: ' + e.toString());
  }
}
