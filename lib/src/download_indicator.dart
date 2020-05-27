import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/src/show_progress.dart';

class DownloadIndicator extends StatelessWidget {
  final double progress;

  const DownloadIndicator({Key key, this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 50.0,
            height: 50.0,
            child: ShowProgress(progress: progress),
          ),
          const SizedBox(width: 20.0),
          const Text('Downloading...'),
        ],
      ),
    );
  }
}
