import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/src/show_progress.dart';

typedef Widget PlaceholderWidget(double progress);

class _DownloadIndicator extends StatelessWidget {
  /// progress for Download
  final double progress;

  const _DownloadIndicator({Key key, this.progress}) : super(key: key);

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

Widget downloadIndicator(double progress) => _DownloadIndicator(
      progress: progress,
    );
