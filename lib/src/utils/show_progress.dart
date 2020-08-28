import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef LoadingWidget = Widget Function();

class ShowProgress extends StatelessWidget {
  /// progress optional only worked with android
  const ShowProgress({Key key, this.progress}) : super(key: key);
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? const CupertinoActivityIndicator()
          : CircularProgressIndicator(
              value: progress,
            ),
    );
  }
}

Widget loadingWidgetHolder() => const ShowProgress();
