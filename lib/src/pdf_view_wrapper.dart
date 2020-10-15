import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../flutter_cached_pdfview.dart';

class PDFViewWrapper extends StatelessWidget {
  const PDFViewWrapper({Key key, @required this.pdf, @required this.path})
      : super(key: key);

  /// path for pdf file in phone storage
  final String path;

  /// Pdf Model
  final PDF pdf;

  @override
  Widget build(BuildContext context) {
    return PDFView(
      filePath: path,
      onLinkHandler: pdf.onLinkHandler,
      onViewCreated: pdf.onViewCreated,
      onRender: pdf.onRender,
      onPageChanged: pdf.onPageChanged,
      onError: pdf.onError,
      onPageError: pdf.onPageError,
      gestureRecognizers: pdf.gestureRecognizers,
      enableSwipe: pdf.enableSwipe,
      swipeHorizontal: pdf.swipeHorizontal,
      password: pdf.password,
      nightMode: pdf.nightMode,
      autoSpacing: pdf.autoSpacing,
      pageFling: pdf.pageFling,
      pageSnap: pdf.pageSnap,
      fitEachPage: pdf.fitEachPage,
      defaultPage: pdf.defaultPage,
      fitPolicy: pdf.fitPolicy,
      preventLinkNavigation: pdf.preventLinkNavigation,
    );
  }
}
