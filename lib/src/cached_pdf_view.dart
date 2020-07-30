import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cached_pdfview/src/download_indicator.dart';
import 'package:flutter_cached_pdfview/src/pdf.dart';
import 'package:flutter_cached_pdfview/src/pdf_view_wrapper.dart';

typedef Widget PlaceholderWidget(double progress);
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

  const CachedPDFView({
    Key key,
    @required this.url,
    this.pdf,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FileResponse>(
      stream: DefaultCacheManager().getFileStream(url, withProgress: true),
      builder: (context, snapshot) {
        final loading = !snapshot.hasData || snapshot.data is DownloadProgress;

        if (snapshot.hasError) {
          return errorWidget != null
              ? errorWidget(snapshot.error)
              : Center(
                  child: const Text(
                    'Error\nNo Internet And Not Cashed Yet!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                );
        } else if (loading) {
          final progress =
              (((snapshot.data as DownloadProgress)?.progress ?? 0) * 100)
                  .roundToDouble();
          return placeholder != null
              ? placeholder(progress)
              : DownloadIndicator(progress: progress);
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
