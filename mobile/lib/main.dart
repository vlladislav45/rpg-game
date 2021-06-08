import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rpg_game/presentation/routes/app_router.dart';
import 'package:rpg_game/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // to hide both top and bottom bars
  SystemChrome.setEnabledSystemUIOverlays ([]);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,])
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
