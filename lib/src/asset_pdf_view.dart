import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_cached_pdfview/src/copy_pdf_from_asset_to_storge.dart';
import 'package:flutter_cached_pdfview/src/pdf_view_wrapper.dart';
import 'package:flutter_cached_pdfview/src/show_progress.dart';

typedef Widget AssetErrorWidget(dynamic error);

class AssetPDFView extends StatelessWidget {
  /// assetPath like 'asset/example.pdf'
  final String assetPath;

  /// Pdf Model
  final PDF pdf;

  /// Widget displayed while the target [assetPath] failed to get from asset.
  final AssetErrorWidget errorWidget;

  const AssetPDFView({Key key, this.assetPath, this.pdf, this.errorWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: getPdfFromAsset(assetPath),
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.hasData && snapshot.data != null)
          return PDFViewWrapper(pdf: pdf, path: snapshot.data.path);

        if (snapshot.hasData && snapshot.data == null || snapshot.hasError) {
          return errorWidget != null
              ? errorWidget(snapshot.error)
              : Center(
                  child: Text(
                    'Exception Throw When Open From Asset\n' +
                        snapshot.error.toString(),
                  ),
                );
        }

        return ShowProgress();
      },
    );
  }
}
