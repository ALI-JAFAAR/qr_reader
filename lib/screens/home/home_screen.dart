import 'package:flutter/material.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: BodyWidget(),
      ),
    );
  }
}
