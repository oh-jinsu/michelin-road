import 'package:codux/codux.dart';
import 'package:flutter/material.dart';

mixin DialogEffectMixin on Effect {
  void showAlertDialog({
    required String content,
  }) {
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
