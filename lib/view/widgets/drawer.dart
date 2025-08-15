import 'package:flutter/material.dart';
import 'package:mini_tourist/view/about_us_page.dart';
import 'package:mini_tourist/view/find_mt_cards.dart';
import 'package:mini_tourist/view/general_dashboard_page.dart';
import 'package:mini_tourist/view/know_more_about_mt_cards.dart';
import 'package:mini_tourist/view/login_page.dart';
import 'package:mini_tourist/view/main_page.dart';
import 'package:mini_tourist/view/selected_member_dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'lib/assets/images/logo.png',
                fit: BoxFit.contain,
              ),
            ),
            accountEmail: const Text('clickcardsdeals@gmail.com'),
            accountName: const Text(
              'ClickCards',
              style: TextStyle(fontSize: 24.0),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(221, 245, 25, 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Acerca de nosotros'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AboutUs()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.place),
            title: const Text('Dónde encontrarnos'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FindMtCards()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.card_giftcard),
            title: const Text('Conoce nuestras tarjetas'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const KnowMoreAboutMtCards()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Ya me anuncio en ClickCards'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              final role = prefs.getString('role');
              final loginTime = prefs.getInt('loginTime');

              if (role != null && loginTime != null) {
                final now = DateTime.now().millisecondsSinceEpoch;
                final diffSeconds = (now - loginTime) / 1000;

                if (diffSeconds <= 30) {
                  if (role == 'admin') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const GeneralSearchPage()),
                    );
                  } else if (role == 'member') {
                    final cardId = prefs.getInt('cardid');
                    if (cardId != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SelectedMemberDashboardPage(clientId: cardId)),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    }
                  }
                  return;
                }
              }
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.confirmation_num),
            title: const Text('Quiero contratar y anunciarme en ClickCards'),
            onTap: () {
              //Navigate
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Contáctanos'),
            onTap: () {
              // Aquí puedes definir la lógica o navegación correspondiente
            },
          ),
        ],
      ),
    );
  }
}