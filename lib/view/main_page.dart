import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mini_tourist/utils/main_widget_lists.dart';
import 'package:mini_tourist/view/widgets/drawer.dart';
import 'package:mini_tourist/view/widgets/main_page_widgets/all_categories_distribution_widget.dart';
import 'package:mini_tourist/view/widgets/main_page_widgets/carousel_slider_widget.dart';
import 'package:mini_tourist/view/widgets/main_page_widgets/first_presentation_slider_widget.dart';
import 'package:mini_tourist/view/widgets/main_page_widgets/places_widget.dart';
import 'package:mini_tourist/view_model/client_view_model.dart';
import 'package:provider/provider.dart';
import 'package:widget_slider/widget_slider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = SliderController(
    duration: const Duration(milliseconds: 600),
  );
  double _rating = 0;

  @override
  void initState() {
    final clientViewModel = Provider.of<ClientViewModel>(context, listen: false); //This sets the images variable from the viewmodel
    clientViewModel.fetchCardNamesByPremium();
    clientViewModel.getCardsByPlaceNull();
    super.initState();
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
      body: Consumer<ClientViewModel>(builder: (context, clientViewModel, child) {
        final images = clientViewModel.images.map((cardInfo) => cardInfo.image).toList();
        final places = clientViewModel.places.map((cardInfo) => cardInfo.image).toList();

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              carouselSliderWidget(300, 0.5, 8, secondSliderImages(places, isPlace: true)),
              const SizedBox(height: 40),
              firstPresentationSlider(),
              const SizedBox(height: 60),
              carouselSliderWidget(300, 0.5, 5, secondSliderImages(images, isPlace: false)),
              allCategoriesDistributionWidget(clientViewModel),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    buildPlacesImageCard(
                      imagePath:
                          'lib/assets/images/Zihuatanejo_img.jpg', // Cambia por tus imágenes
                      text: 'Ixtapa Zihuatanejo',
                      dialogTitle: 'Aventuras',
                      dialogContent:
                          'Descubre nuestras experiencias premium en la playa',
                      context: context,
                    ),
                    const SizedBox(height: 16),
                    buildPlacesImageCard(
                      imagePath: 'lib/assets/images/Acapulco_img.jpg',
                      text: 'Acapulco',
                      dialogTitle: 'Descuentos',
                      dialogContent:
                          'Accede a descuentos del 30% en restaurantes participantes',
                      context: context,
                    ),
                    const SizedBox(height: 16),
                    buildPlacesImageCard(
                      imagePath: 'lib/assets/images/Morelia.webp',
                      text: 'Morelia',
                      dialogTitle: 'Agenda',
                      dialogContent:
                          'Concierto en la playa este viernes a las 8pm',
                      context: context,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Imagen a la izquierda (40% del ancho) con espacio arriba
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              child: Image.asset(
                                'lib/assets/images/thinking.png',
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          // Contenido a la derecha (60% del ancho)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Título descriptivo',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Descripción detallada del contenido de esta tarjeta. Puede contener varias líneas de texto informativo.',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        // Acción del botón
                                      },
                                      child: const Text(
                                        'Ver más',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24), // Espacio entre las secciones

              Container(
                width: double.infinity,
                color: Colors.black,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CONTACTO
                    const Text(
                      'CONTACTANOS',
                      style: TextStyle(
                        color: Color(0xFFD40049),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Email:\nclickcardsdeals@gmail.com', style: TextStyle(color: Colors.white)),
                    const Text('Tel: (55) 2620 0507', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 12),
                    // Íconos sociales
                    /*const Row(
                      children: [
                        FaIcon(FontAwesomeIcons.facebookF, color: Colors.white),
                        SizedBox(width: 12),
                        FaIcon(FontAwesomeIcons.linkedinIn, color: Colors.white),
                        SizedBox(width: 12),
                        FaIcon(FontAwesomeIcons.instagram, color: Colors.white),
                      ],
                    ),*/

                    const SizedBox(height: 24),
                    // LEGAL
                    const Text(
                      'LEGAL',
                      style: TextStyle(
                        color: Color(0xFFD40049),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Aviso de Privacidad', style: TextStyle(color: Colors.white)),
                    const Text('Términos & Condiciones', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 24),
                    // CALIFICACIÓN
                    const Text(
                      'CALIFICACIÓN',
                      style: TextStyle(
                        color: Color(0xFFD40049),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Nombre
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Nombre Completo',
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    // Estrellas (estáticas por ahora)
                    const Text('Califícanos', style: TextStyle(color: Colors.white)),
                    RatingBar.builder(
                      initialRating: _rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      unratedColor: Colors.white,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                          print('Rating: $_rating');
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    // Comentario
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Déjanos un Comentario',
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    // Botón Enviar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD40049),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          // Acción al enviar
                        },
                        child: const Text('Enviar', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
      }),
      drawer: const AppDrawer(),
    );
  }
}