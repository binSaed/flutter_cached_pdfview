import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowProgress extends StatelessWidget {
  final double progress;

  const ShowProgress({Key key, this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? CupertinoActivityIndicator()
          : CircularProgressIndicator(
              value: progress,
            ),
    );
  }
}
