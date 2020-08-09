import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<File> getPdfFromAsset(String assetPath) async {
// To open from assets, you can copy them to the app storage folder, and then access them "locally"
  assert(assetPath.toLowerCase().endsWith('.pdf'),
      throw '($assetPath) should endsWith ".pdf".');
  final regexp = RegExp(r'[\w-]+\.(pdf|PDF)');
  final pdfName = regexp.stringMatch(assetPath);

  final dir = await getApplicationDocumentsDirectory();
  var file = File("${dir.path}/$pdfName");
  try {
    if (!await file.exists()) {
      var data = await rootBundle.load(assetPath);
      var bytes = data.buffer.asUint8List();
      file = await file.writeAsBytes(bytes);
    }
    return file;
  } catch (e) {
    throw Exception("Error opening asset file: " + e.toString());
  }
}
