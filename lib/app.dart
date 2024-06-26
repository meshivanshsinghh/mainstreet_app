import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mainstreet/helpers/app_preferences.dart';
import 'package:mainstreet/providers/auth/merchant_auth_provider.dart';
import 'package:mainstreet/providers/auth/user_auth_provider.dart';
import 'package:mainstreet/screens/splash_view.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();
final AppPreferences appPreferences = AppPreferences();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final routeObserver = RouteObserver<PageRoute>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserAuthProvider>(
          create: (_) => UserAuthProvider(),
        ),
        ChangeNotifierProvider<MerchantAuthProvider>(
          create: (_) => MerchantAuthProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: false,
        ),
        debugShowCheckedModeBanner: false,
        navigatorKey: mainNavigatorKey,
        navigatorObservers: [routeObserver],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const SplashView(),
      ),
    );
  }
}
