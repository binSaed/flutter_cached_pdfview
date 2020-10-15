import 'dart:io';

import 'package:flutter/material.dart';

import '../../flutter_cached_pdfview.dart';
import '../pdf_view_wrapper.dart';
import '../utils/show_progress.dart';
import 'copy_pdf_from_asset_to_storge.dart';

typedef AssetErrorWidget = Widget Function(dynamic error);

class AssetPDFView extends StatelessWidget {
  const AssetPDFView(
      {Key key, this.assetPath, this.pdf, this.errorWidget, this.loadingWidget})
      : super(key: key);

  /// assetPath like 'asset/example.pdf'
  final String assetPath;

  /// Pdf Model
  final PDF pdf;

  /// Widget displayed while the target [assetPath] failed to get from asset.
  final AssetErrorWidget errorWidget;

  /// Widget displayed while [assetPath] copying to local storage
  final LoadingWidget loadingWidget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: getPdfFromAsset(assetPath),
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return PDFViewWrapper(pdf: pdf, path: snapshot.data.path);
        }

        if (snapshot.hasData && snapshot.data == null || snapshot.hasError) {
          return errorWidget(snapshot.error);
        }

        return loadingWidget();
      },
    );
  }
}
