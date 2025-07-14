import 'package:flutter/material.dart';
import 'package:mini_tourist/view/widgets/drawer.dart';

class KnowMoreAboutMtCards extends StatelessWidget {
  const KnowMoreAboutMtCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MiniTourist'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: const SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('Conoce más sobre las Minitourist Cards'),
            )
          ],
        ),
      ),
      drawer: const AppDrawer()
    );
  }
}