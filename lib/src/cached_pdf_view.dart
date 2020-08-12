import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cached_pdfview/src/download_indicator.dart';
import 'package:flutter_cached_pdfview/src/pdf.dart';
import 'package:flutter_cached_pdfview/src/pdf_view_wrapper.dart';

import 'download_indicator.dart';

typedef Widget DownloadingErrorWidget(dynamic error);

class CachedPDFView extends StatelessWidget {
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

  const CachedPDFView({
    Key key,
    @required this.url,
    this.pdf,
    this.placeholder,
    this.errorWidget,
    this.headers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FileResponse>(
      stream: DefaultCacheManager()
          .getFileStream(url, withProgress: true, headers: headers),
      builder: (context, snapshot) {
        final loading = !snapshot.hasData || snapshot.data is DownloadProgress;

        if (snapshot.hasError) {
          return errorWidget(snapshot.error);
        } else if (loading) {
          final progress =
              (((snapshot.data as DownloadProgress)?.progress ?? 0) * 100)
                  .roundToDouble();
          return placeholder(progress);
        } else
          return PDFViewWrapper(
            path: (snapshot.data as FileInfo).file.path,
            pdf: pdf,
            key: key,
          );
      },
    );
  }
}
