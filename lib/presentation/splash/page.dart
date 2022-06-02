import 'package:codux/codux.dart';
import 'package:flutter/material.dart';

class SplashPage extends Component {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
