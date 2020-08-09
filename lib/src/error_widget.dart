import 'package:flutter/material.dart';

typedef Widget ErrorWidget(dynamic error);

Widget errorWidgetHolder(dynamic error) => Center(
      child: Center(
        child: Text(
          error.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
