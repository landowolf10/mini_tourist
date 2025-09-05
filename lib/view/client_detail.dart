import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_tourist/view/back_card_info_screen.dart';
import 'package:mini_tourist/view/selected_member_dashboard_page.dart';
import 'package:mini_tourist/view/widgets/drawer.dart';
import 'package:mini_tourist/view_model/card_view_model.dart';
import 'package:mini_tourist/view_model/client_view_model.dart';
import 'package:provider/provider.dart';

class ClientDetail extends StatefulWidget {
  final int clientId;
  final bool isFromCategoryPlace;
  final bool isFromDashboard;

  const ClientDetail({
    super.key,
    required this.clientId,
    this.isFromCategoryPlace = false,
    this.isFromDashboard = false
  });

  @override
  State<ClientDetail> createState() => _ClientDetailState();
}

class _ClientDetailState extends State<ClientDetail> {
  CardViewModel cardViewModel = CardViewModel();
  ClientViewModel clientViewModel = ClientViewModel();

  @override
  void initState() {
    //Add a condition to call it if is not from the login (see users in the dashboard as admin)
    print('Is from dahsboard: ' + widget.isFromDashboard.toString());

    if (!widget.isFromDashboard) {
      cardViewModel.addCardStatus(
          cardId: widget.clientId,
          status: 'Visited',
          city: 'Zihuatanejo',
          date: DateTime.now(),
        );

        cardViewModel.getLatAndLongdByCardId(widget.clientId);
    }

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ClientViewModel>(context, listen: false).getSelectedClient(widget.clientId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClickCards'),
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
      drawer: const AppDrawer(),
      body: Consumer<ClientViewModel>(
        builder: (context, clientViewModel, child) {
          if (clientViewModel.client == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final client = clientViewModel.client!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          client.cardName,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Ciudad: ${client.city}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Categoría: ${client.category}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            client.image,
                            height: 600,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Text('No se pudo cargar la imagen');
                            },
                          ),
                        ),
                        if (widget.isFromDashboard)
                          Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SelectedMemberDashboardPage(
                                        clientId: client.cardId
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.dashboard),
                                label: const Text('Ver dahsboard'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                        if (widget.isFromCategoryPlace)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await cardViewModel.donwloadImage(client.image);
                                await cardViewModel.addCardStatus(
                                  cardId: widget.clientId,
                                  status: 'Downloaded',
                                  city: 'Zihuatanejo',
                                  date: DateTime.now(),
                                );
                                //print("Downloaded image: $imageURL");
                                Fluttertoast.showToast(
                                  msg: "¡Cupón descargado correctamente!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              },
                              icon: const Icon(Icons.download),
                              label: const Text('Descargar cupón'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BackCardInfoScreen(
                                        lat: cardViewModel.lat,
                                        lng: cardViewModel.long,
                                        schedule: cardViewModel.schedule,
                                        phoneNumber: cardViewModel.phoneNumber,
                                        web: cardViewModel.web,
                                        socialMedia: cardViewModel.socialMedia,
                                        characteristics: cardViewModel.characteristics,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.reviews),
                                label: const Text('Ver reverso'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Regresar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}