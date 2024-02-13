import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget showDialogLoading() {
  return const SimpleDialog(
    insetPadding: EdgeInsets.all(140),
    contentPadding: EdgeInsets.all(23),
    children: [
      Column(
        children: [
          CircularProgressIndicator(),
        ],
      )
    ],
  );
}
