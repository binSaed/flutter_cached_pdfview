import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cached_pdfview/src/download_indicator.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewCash extends StatelessWidget {
  final String url;

  final bool enableSwipe;
  final bool swipeHorizontal;
  final String password;
  final bool nightMode;
  final bool autoSpacing;
  final bool pageFling;
  final bool pageSnap;
  final int defaultPage;
  final FitPolicy fitPolicy;
  final bool fitEachPage;
  final PDFViewCreatedCallback onViewCreated;
  final RenderCallback onRender;
  final PageChangedCallback onPageChanged;
  final ErrorCallback onError;
  final PageErrorCallback onPageError;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  const PDFViewCash({
    Key key,
    @required this.url,
    this.onViewCreated,
    this.onRender,
    this.onPageChanged,
    this.onError,
    this.onPageError,
    this.gestureRecognizers,
    this.enableSwipe = true,
    this.swipeHorizontal = false,
    this.password,
    this.nightMode = false,
    this.autoSpacing = true,
    this.pageFling = true,
    this.pageSnap = true,
    this.fitEachPage = true,
    this.defaultPage = 0,
    this.fitPolicy = FitPolicy.WIDTH,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FileResponse>(
        stream: DefaultCacheManager().getFileStream(url, withProgress: true),
        builder: (context, snapshot) {
          var loading = !snapshot.hasData || snapshot.data is DownloadProgress;

          if (snapshot.hasError) return Center(
            child: const Text(
                'Error\nNo Internet And Not Cashed Yet!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
          );

          else if (loading) return DownloadIndicator(progress:( snapshot.data as DownloadProgress)?.progress);

          else return PDFView(
              filePath: (snapshot.data as FileInfo).file.path,
              onViewCreated: onViewCreated,
              onRender: onRender,
              onPageChanged: onPageChanged,
              onError: onError,
              onPageError: onPageError,
              gestureRecognizers: gestureRecognizers,
              enableSwipe: enableSwipe,
              swipeHorizontal: swipeHorizontal,
              password: password,
              nightMode: nightMode,
              autoSpacing: autoSpacing,
              pageFling: pageFling,
              pageSnap: pageSnap,
              fitEachPage: fitEachPage,
              defaultPage: defaultPage,
              fitPolicy: fitPolicy,
            );
        });
  }
}