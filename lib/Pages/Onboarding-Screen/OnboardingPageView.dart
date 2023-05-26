import 'package:flutter/material.dart';
import 'Onboarding_1.dart';
import 'Onboarding_2.dart';
import 'Onboarding_3.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  _OnboardingPageViewState createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final List<Widget> pages = [
    const Onboarding_1(),
    const Onboarding_2(),
    const Onboarding_3(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: pages,
      ),
    );
  }
}
