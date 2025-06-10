import 'package:flutter/material.dart';
import 'package:cupertino_modal_page/cupertino_modal_page.dart';

final CupertinoModalPageController controller = CupertinoModalPageController();

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CupertinoModalPage(
        controller: controller,
        child: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            controller.show((context) => const SecondPage());
          },
          child: const Text('Открыть модальный экран'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Second Page'),
      ),
    );
  }
}
