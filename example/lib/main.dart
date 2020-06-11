import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
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
      body: PDF().cachedFromUrl(url),
    );
  }
}

class PDFViewerFromAsset extends StatelessWidget {
  final String pdfAssetPath;

  const PDFViewerFromAsset({Key key, @required this.pdfAssetPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF From Asset'),
      ),
      body: PDF().fromAsset(pdfAssetPath),
    );
  }
}
