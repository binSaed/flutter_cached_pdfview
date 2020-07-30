import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(home: MyHomePage());
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter_cached_pdfview Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FlatButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFViewerFromUrl(
                  url: 'http://africau.edu/images/default/sample.pdf',
                ),
              ),
            ),
            child: Text('Cashed PDF From Url'),
          ),
          FlatButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFViewerFromAsset(
                  pdfAssetPath: 'assets/pdf/file-example.pdf',
                ),
              ),
            ),
            child: Text('PDF From Asset'),
          ),
        ],
      ),
    );
  }
}

class PDFViewerFromUrl extends StatelessWidget {
  final String url;

  const PDFViewerFromUrl({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF From Url'),
      ),
      body: PDF().cachedFromUrl(
        url,
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}

class PDFViewerFromAsset extends StatelessWidget {
  PDFViewerFromAsset({Key key, @required this.pdfAssetPath}) : super(key: key);
  final String pdfAssetPath;
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final _pageCountController = StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF From Asset'),
        actions: <Widget>[
          StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue[900],
                      ),
                      child: Text(snapshot.data),
                    ),
                  );
                return SizedBox();
              }),
        ],
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onPageChanged: (current, total) =>
            _pageCountController.add('${current + 1} - $total'),
        onViewCreated: (pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final currentPage = await pdfViewController.getCurrentPage();
          final pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromAsset(
        pdfAssetPath,
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: "-",
                  child: Text("-"),
                  onPressed: () async {
                    final pdfController = snapshot.data;
                    final currentPage =
                        await pdfController.getCurrentPage() - 1;
                    if (currentPage >= 0)
                      await snapshot.data.setPage(currentPage);
                  },
                ),
                FloatingActionButton(
                  heroTag: "+",
                  child: Text("+"),
                  onPressed: () async {
                    final pdfController = snapshot.data;
                    final currentPage =
                        await pdfController.getCurrentPage() + 1;
                    final numberOfPages = await pdfController.getPageCount();
                    if (numberOfPages > currentPage)
                      await snapshot.data.setPage(currentPage);
                  },
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
