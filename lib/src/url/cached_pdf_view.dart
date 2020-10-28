import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../pdf.dart';
import '../pdf_view_wrapper.dart';
import '../utils/download_indicator.dart';
import 'custom_cache_manger.dart';

typedef DownloadingErrorWidget = Widget Function(dynamic error);
typedef WhenDone = void Function(String filePath);

class CachedPDFView extends StatelessWidget {
  const CachedPDFView(
    this._cacheKey, {
    Key key,
    @required this.url,
    this.pdf,
    this.placeholder,
    this.errorWidget,
    this.headers,
    this.maxAgeCacheObject,
    this.maxNrOfCacheObjects,
    this.whenDone,
  }) : super(key: key);

  /// pdf url like 'www.test.example,pdf'
  final String url;

  /// Pdf Model
  final PDF pdf;

  /// Widget displayed while the target [url] is loading.
  final PlaceholderWidget placeholder;

  /// Widget displayed while the target [url] failed Downloading.
  final DownloadingErrorWidget errorWidget;

  /// [headers] can be used for example for authentication.
  final Map<String, String> headers;

  /// Files are removed when they haven't been used for longer than [maxAgeCacheObject]
  final Duration maxAgeCacheObject;

  /// or when this cache has grown too big. When the cache is larger than [maxNrOfCacheObjects]
  /// files the files that haven't been used longest will be removed.
  final int maxNrOfCacheObjects;
  final String _cacheKey;

  /// whenDone call when file download and cached
  final WhenDone whenDone;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FileResponse>(
      stream: CustomCacheManger(
        key: _cacheKey,
        maxAgeCacheObject: maxAgeCacheObject,
        maxNrOfCacheObjects: maxNrOfCacheObjects,
      ).getFileStream(url, withProgress: true, headers: headers),
      builder: (_, AsyncSnapshot<FileResponse> snapshot) {
        final bool loading =
            !snapshot.hasData || snapshot.data is DownloadProgress;

        if (snapshot.hasError) {
          return errorWidget(snapshot.error);
        } else if (loading) {
          final double progress =
              (((snapshot.data as DownloadProgress)?.progress ?? 0) * 100)
                  .roundToDouble();
          return placeholder(progress);
        } else {
          final String filePath = (snapshot.data as FileInfo).file.path;
          if (whenDone != null) {
            whenDone(filePath);
          }
          return PDFViewWrapper(
            path: filePath,
            pdf: pdf,
            key: key,
          );
        }
      },
    );
  }
}
