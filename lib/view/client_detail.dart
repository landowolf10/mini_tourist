import 'package:flutter/material.dart';
import 'package:mini_tourist/view/login_page.dart';
import 'package:mini_tourist/view/widgets/drawer.dart';
import 'package:mini_tourist/view_model/client_view_model.dart';
import 'package:provider/provider.dart';

class ClientDetail extends StatefulWidget {
  final int clientId;

  const ClientDetail({super.key, required this.clientId});

  @override
  State<ClientDetail> createState() => _ClientDetailState();
}

class _ClientDetailState extends State<ClientDetail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ClientViewModel>(context, listen: false).getSelectedClient(widget.clientId);
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
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Text('No se pudo cargar la imagen');
                            },
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