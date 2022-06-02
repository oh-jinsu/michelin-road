import 'package:codux/codux.dart';
import 'package:flutter/material.dart';
import 'package:michelin_road/application/effects/splash_waiter.dart';

class SplashPage extends Component {
  const SplashPage({Key? key}) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useEffect(() => SplashWaiterEffect());

    super.onCreated(context);
  }

  @override
  Widget render(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
