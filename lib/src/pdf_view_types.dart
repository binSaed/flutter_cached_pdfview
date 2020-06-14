import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/src/asset_pdf_view.dart';
import 'package:flutter_cached_pdfview/src/cached_pdf_view.dart';
import 'package:flutter_cached_pdfview/src/pdf_view.dart';
import 'package:flutter_cached_pdfview/src/pdf_view_wrapper.dart';

extension PDFViewTypes on PDF {
  Widget cachedFromUrl(String url, {Key key}) {
    return CachedPDFView(
      key: key,
      pdf: this,
      url: url,
    );
  }

  Widget fromPath(String path, {Key key}) {
    return PDFViewWrapper(
      key: key,
      pdf: this,
      path: path,
    );
  }

  Widget fromAsset(String pathOfAsset, {Key key}) {
    return AssetPDFView(
      key: key,
      pdf: this,
      assetPath: pathOfAsset,
    );
  }
}
