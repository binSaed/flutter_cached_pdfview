import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/src/asset/asset_pdf_view.dart';
import 'package:flutter_cached_pdfview/src/pdf.dart';
import 'package:flutter_cached_pdfview/src/pdf_view_wrapper.dart';
import 'package:flutter_cached_pdfview/src/url/cached_pdf_view.dart';
import 'package:flutter_cached_pdfview/src/utils/error_widget.dart';
import 'package:flutter_cached_pdfview/src/utils/show_progress.dart';

import 'utils/download_indicator.dart';

extension PDFViewTypes on PDF {
  Widget fromUrl(
    String url, {
    Key key,
    PlaceholderWidget placeholder = downloadIndicator,
    DownloadingErrorWidget errorWidget = errorWidgetHolder,
    Map<String, String> headers,
  }) {
    return CachedPDFView(
      'without_cache',
      key: key,
      pdf: this,
      url: url,
      placeholder: placeholder,
      errorWidget: errorWidget,
      headers: headers,
      maxAgeCacheObject: const Duration(microseconds: 0),
      maxNrOfCacheObjects: 0,
    );
  }

  Widget cachedFromUrl(
    String url, {
    Key key,
    PlaceholderWidget placeholder = downloadIndicator,
    DownloadingErrorWidget errorWidget = errorWidgetHolder,
    Map<String, String> headers,
    Duration maxAgeCacheObject = const Duration(days: 10),
    int maxNrOfCacheObjects = 100,
  }) {
    return CachedPDFView(
      'libCachedPdfView',
      key: key,
      pdf: this,
      url: url,
      placeholder: placeholder,
      errorWidget: errorWidget,
      headers: headers,
      maxAgeCacheObject: maxAgeCacheObject,
      maxNrOfCacheObjects: maxNrOfCacheObjects,
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
