import 'package:flutter/material.dart';

import 'show_progress.dart';

typedef PlaceholderWidget = Widget Function(double progress);

class _DownloadIndicator extends StatelessWidget {
  const _DownloadIndicator({Key key, this.progress}) : super(key: key);

  /// progress for Download
  final double progress;

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

Widget downloadIndicator(double progress) =>
    _DownloadIndicator(progress: progress);
