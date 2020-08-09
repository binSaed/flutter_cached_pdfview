import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/src/asset_pdf_view.dart';
import 'package:flutter_cached_pdfview/src/cached_pdf_view.dart';
import 'package:flutter_cached_pdfview/src/error_widget.dart';
import 'package:flutter_cached_pdfview/src/pdf.dart';
import 'package:flutter_cached_pdfview/src/pdf_view_wrapper.dart';
import 'package:flutter_cached_pdfview/src/show_progress.dart';

import 'download_indicator.dart';

extension PDFViewTypes on PDF {
  Widget cachedFromUrl(String url,
      {Key key,
      PlaceholderWidget placeholder = downloadIndicator,
      DownloadingErrorWidget errorWidget = errorWidgetHolder}) {
    return CachedPDFView(
      key: key,
      pdf: this,
      url: url,
      placeholder: placeholder,
      errorWidget: errorWidget,
    );
  }

  Widget fromPath(String path, {Key key}) {
    return PDFViewWrapper(
      key: key,
      pdf: this,
      path: path,
    );
  }

  Widget fromAsset(
    String pathOfAsset, {
    Key key,
    AssetErrorWidget errorWidget = errorWidgetHolder,
    LoadingWidget loadingWidget = loadingWidgetHolder,
  }) {
    return AssetPDFView(
      key: key,
      pdf: this,
      assetPath: pathOfAsset,
      errorWidget: errorWidget,
      loadingWidget: loadingWidget,
    );
  }
}
