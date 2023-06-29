import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comprobantes',
          style: TextStyle(fontFamily: 'Ubuntu-Regular'),
        ),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
