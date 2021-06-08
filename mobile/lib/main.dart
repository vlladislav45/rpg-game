import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rpg_game/presentation/routes/app_router.dart';
import 'package:rpg_game/utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // to hide both top and bottom bars
  SystemChrome.setEnabledSystemUIOverlays ([]);

  // Lock screen in landscape mode (horizontal mode)
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight,])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  void dispose() {
    _appRouter.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.theme,
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
