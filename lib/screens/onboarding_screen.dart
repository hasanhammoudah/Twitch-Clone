import 'package:flutter/material.dart';
import 'package:twitch/responsive/responsive.dart';
import 'package:twitch/screens/login_screen.dart';
import 'package:twitch/screens/signup_screen.dart';
import 'package:twitch/widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  static const String routeName = '/onboarding';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to \n Twitch',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomButton(
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  text: 'Log in',
                ),
              ),
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, SignUpScreen.routeName);
                },
                text: 'Sign Up',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
