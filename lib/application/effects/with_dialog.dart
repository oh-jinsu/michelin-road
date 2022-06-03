import 'dart:io';

import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin DialogEffectMixin on Effect {
  void showAlertDialog({
    required String content,
  }) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: requireContext(),
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("안내"),
            content: Text(content),
            actions: [
              CupertinoButton(
                child: const Text("확인"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    } else {
      showDialog(
        context: requireContext(),
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("안내"),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("확인"),
              )
            ],
          );
        },
      );
    }
  }
}
