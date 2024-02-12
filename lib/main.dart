import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch/models/user.dart' as model;
import 'package:twitch/providers/user_provider.dart';
import 'package:twitch/resources/auth_methods.dart';
import 'package:twitch/screens/home_screen.dart';
import 'package:twitch/screens/login_screen.dart';
import 'package:twitch/screens/onboarding_screen.dart';
import 'package:twitch/screens/signup_screen.dart';
import 'package:twitch/utils/colors.dart';
import 'package:twitch/utils/firebase_key.dart';
import 'package:twitch/widgets/loading_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      storageBucket: FirebaseKey().storageBucket,
      apiKey: FirebaseKey().apiKey,
      appId: FirebaseKey().appId,
      messagingSenderId: FirebaseKey().messagingSenderId,
      projectId: FirebaseKey().projectId,
    ),
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twitch Clone',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: backgroundColor,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: const IconThemeData(
            color: primaryColor,
          ),
        ),
      ),
      routes: {
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
      home: FutureBuilder(
        future: AuthMethods()
            .getCurrentUser(
          FirebaseAuth.instance.currentUser != null
              ? FirebaseAuth.instance.currentUser!.uid
              : null,
        )
            .then(
          (value) {
            if (value != null) {
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(model.UserModel.fromMap(value));
            }
            return value;
          },
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const OnboardingScreen();
        },
      ),
    );
  }
}
