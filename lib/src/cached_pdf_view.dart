import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cached_pdfview/src/download_indicator.dart';
import 'package:flutter_cached_pdfview/src/pdf_view.dart';
import 'package:flutter_cached_pdfview/src/pdf_view_wrapper.dart';

class CachedPDFView extends StatelessWidget {
  final String url;

  final PDF pdf;

  const CachedPDFView({
    Key key,
    @required this.url,
    this.pdf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FileResponse>(
      stream: DefaultCacheManager().getFileStream(url, withProgress: true),
      builder: (context, snapshot) {
        final loading = !snapshot.hasData || snapshot.data is DownloadProgress;

        if (snapshot.hasError)
          return Center(
            child: const Text(
              'Error\nNo Internet And Not Cashed Yet!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          );
        else if (loading)
          return DownloadIndicator(
              progress: (snapshot.data as DownloadProgress)?.progress);
        else
          return PDFViewWrapper(
            path: (snapshot.data as FileInfo).file.path,
            pdf: pdf,
            key: key,
          );
      },
    );
  }
}
