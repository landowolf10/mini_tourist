import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_tourist/utils/constant_data.dart';
import 'package:mini_tourist/view/create_member.dart';
import 'package:mini_tourist/view/login_page.dart';
import 'package:mini_tourist/view/users_page.dart';
import 'package:mini_tourist/view/widgets/drawer.dart';
import 'package:mini_tourist/view/widgets/search/search.dart';
import 'package:mini_tourist/view_model/card_view_model.dart';
import 'package:provider/provider.dart';

class GeneralSearchPage extends StatefulWidget {
  const GeneralSearchPage({super.key});

  @override
  State<GeneralSearchPage> createState() => _GeneralSearchPageState();
}

class _GeneralSearchPageState extends State<GeneralSearchPage> {
  late CardViewModel cardViewModel;
  TextEditingController dateController = TextEditingController();
  String? selectedCity = 'Ciudades';

  @override
  void initState() {
    cardViewModel = Provider.of<CardViewModel>(context, listen: false);

    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);

    cardViewModel.getVisitedAndDownloadedCardsGeneral();
    cardViewModel.getVisitedAndDownloadedCardsGeneralDate(formattedDate);

    dateController.text = formattedDate; //set the initial value of text field
    super.initState();
  }

  void onCityChanged(String? newValue) {
    setState(() {
      selectedCity = newValue;
      // Aquí puedes agregar la lógica para filtrar por ciudad
      if (newValue == 'Todas' || newValue == null) {
        // Mostrar todas las tarjetas
        cardViewModel.getVisitedAndDownloadedCardsGeneral();
      } else {
        cardViewModel.getVisitedAndDownloadedCardsGeneralCity(selectedCity!);
      }
    });
  }

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
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.people),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<CardViewModel>(
            builder: (context, cardViewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildGeneralCountContainer(cardViewModel),
                  const SizedBox(height: 20),
                  buildGeneralCountDateContainer(
                      context, dateController, cardViewModel),
                  const SizedBox(height: 20),
                  buildGeneralCountDateRangeContainer(context, cardViewModel),
                  const SizedBox(height: 20),
                  buildFilterByCityContainer(
                      cardViewModel, selectedCity, cities, onCityChanged),
                  const SizedBox(height: 20),
                  buildUserManagementContainer(
                    onRead: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UsersPage()
                      ),
                    ),
                    onCreate: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterMemberPage()
                      ),
                    ),
                    onUpdate: () => Navigator.pushNamed(context, '/update'),
                    onDelete: () => Navigator.pushNamed(context, '/delete'),
                    onLogout: () => Navigator.pushReplacementNamed(context, '/login'),
                  ),
                ],
              );
            },
          ),
        ),
        drawer: const AppDrawer());
  }

  Widget buildUserManagementContainer({
    required VoidCallback onRead,
    required VoidCallback onCreate,
    required VoidCallback onUpdate,
    required VoidCallback onDelete,
    required VoidCallback onLogout,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      padding: const EdgeInsets.all(16),
      decoration: myBoxDecoration(color: Colors.green.shade50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Manejo de usuarios',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),
          _buildButton('Ver asociados', onRead, color: const Color.fromARGB(255, 0, 255, 42)),
          const SizedBox(height: 10),
          _buildButton('Crear asociado', onCreate, color: Colors.green),
          const SizedBox(height: 10),
          _buildButton('Actualizar asociado', onUpdate, color: Colors.blue),
          const SizedBox(height: 10),
          _buildButton('Eliminar asociado', onDelete, color: Colors.red),
          const SizedBox(height: 10),
          _buildButton('Cerrar sesión', onLogout, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed,
      {required Color color}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
