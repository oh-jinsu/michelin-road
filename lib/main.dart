import 'package:flutter/material.dart';
import 'package:codux/codux.dart';
import 'package:michelin_road/application/effects/app_waiter.dart';
import 'package:michelin_road/application/effects/environment.dart';
import 'package:michelin_road/application/effects/infrastructure.dart';
import 'package:michelin_road/application/effects/locate.dart';
import 'package:michelin_road/application/events/app_started.dart';
import 'package:michelin_road/application/stores/location.dart';
import 'package:michelin_road/application/stores/location_status.dart';
import 'package:michelin_road/presentation/home/page.dart';
import 'package:michelin_road/presentation/splash/page.dart';

void main() => runApp(const App());

class App extends Component {
  const App({Key? key}) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useStore(() => LocationStore());
    useStore(() => LocationStatusStore());

    useEffect(() => EnvironmentEffect(), until: SplashPage);
    useEffect(() => InfrastructureEffect(), until: SplashPage);
    useEffect(() => LocateEffect());
    useEffect(() => AppWaiterEffect(), until: SplashPage);

    super.onCreated(context);
  }

  @override
  void onStarted(BuildContext context) {
    dispatch(const AppStarted());

    super.onStarted(context);
  }

  @override
  Widget render(BuildContext context) {
    return MaterialApp(
      initialRoute: "/splash",
      onGenerateRoute: (settings) {
        if (settings.name == "/splash") {
          return PageRouteBuilder(
            transitionDuration: Duration.zero,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SplashPage(),
          );
        }

        if (settings.name == "/home") {
          return MaterialPageRoute(
            builder: (context) => const HomePage(),
          );
        }

        return null;
      },
    );
  }
}
