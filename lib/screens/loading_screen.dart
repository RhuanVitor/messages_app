import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              'Carregando...',
            ),
          ],
        ),
      ),
    );
  }
}
