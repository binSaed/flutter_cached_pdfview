import 'package:flutter/material.dart';

import 'asset/asset_pdf_view.dart';
import 'pdf.dart';
import 'pdf_view_wrapper.dart';
import 'url/cached_pdf_view.dart';
import 'utils/download_indicator.dart';
import 'utils/error_widget.dart';
import 'utils/show_progress.dart';

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
    WhenDone whenDone,
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
      whenDone: whenDone,
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
