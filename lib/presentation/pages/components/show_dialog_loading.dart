import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget showDialogLoading() {
  return const SimpleDialog(
    insetPadding: EdgeInsets.all(140),
    contentPadding: EdgeInsets.all(23),
    children: [
      Column(
        children: [
          SpinKitThreeBounce(
            size: 20,
            color: Colors.blue,
          ),
        ],
      )
    ],
  );
}
