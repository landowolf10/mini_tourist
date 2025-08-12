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

class SelectedMemberDashboardPage extends StatefulWidget {
  final int clientId;
  const SelectedMemberDashboardPage({
    required this.clientId,
    super.key
  });

  @override
  State<SelectedMemberDashboardPage> createState() => _SelectedMemberDashboardPageState();
}

class _SelectedMemberDashboardPageState extends State<SelectedMemberDashboardPage> {
  late CardViewModel cardViewModel;
  TextEditingController dateController = TextEditingController();
  String? selectedCity = 'Ciudades';

  @override
  void initState() {
    cardViewModel = Provider.of<CardViewModel>(context, listen: false);

    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);

    cardViewModel.getVisitedAndDownloadedCardsGeneralByCardId(widget.clientId);
    cardViewModel.getVisitedAndDownloadedCardsDateByCardId(widget.clientId, formattedDate);

    dateController.text = formattedDate; //set the initial value of text field
    super.initState();
  }

  /*void onCityChanged(String? newValue) {
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
  }*/

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
                  buildGeneralCountContainer(cardViewModel, false),
                  const SizedBox(height: 20),
                  buildGeneralCountDateContainer(context, dateController, cardViewModel, widget.clientId, false),
                  const SizedBox(height: 20),
                  buildGeneralCountDateRangeContainer(context, cardViewModel, widget.clientId, false),
                  const SizedBox(height: 20),
                  //buildFilterByCityContainer(cardViewModel, selectedCity, cities, onCityChanged),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
        drawer: const AppDrawer());
  }
}
