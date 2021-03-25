import 'package:easyfarm/src/providers/auth.dart';
import 'package:easyfarm/src/providers/farms.dart';
import 'package:easyfarm/src/screens/farms/farms_screen.dart';
import 'package:easyfarm/src/screens/signIn/sign_In_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Farms>(
          create: null,
          update: (ctx, auth, previousFarms) => Farms(
            auth.user.accessToken,
            auth.user.uid,
            auth.user.client,
            previousFarms == null ? null : previousFarms.farms,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Easyfarm',
          theme: ThemeData(
            primaryColor: Color.fromRGBO(34, 92, 89, 1),
          ),
          home: auth.isAuth ? FarmsScreen() : SignInScreen(),
          routes: {
            '/signin': (ctx) => SignInScreen(),
            '/farms': (ctx) => FarmsScreen(),
          },
        ),
      ),
    );
  }
}
