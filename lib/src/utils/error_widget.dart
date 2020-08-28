import 'package:flutter/material.dart';

typedef ErrorWidget = Widget Function(dynamic error);

Widget errorWidgetHolder(dynamic error) => Center(
      child: Center(
        child: Text(
          error.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
