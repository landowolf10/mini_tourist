import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mini_tourist/view/widgets/drawer.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  List<double> rates = [];

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
      body: SizedBox(
        
        child: Column(
          children: [
              //mainAxisAlignment: MainAxisAlignment.center,
                const Text('Nombre (Opcional)'),
                RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    //rates = [];
                    rates.add(rating);
                    print(rating);
                  },
                ),
                const SizedBox(
                  height: 200,
                ),
                const Text('Correo (Opcional)'),
                RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    //rates = [];
                    rates.add(rating);
                    print(rating);
                  },
                ),
                const SizedBox(
                  height: 200,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  )
                  ),
                  onPressed: (){
                    print("Rates: " + rates.toString());
                    rates = [];
                  },
                  child: const Text(
                    'Enviar',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
                  ),
            ),
        ],)
        
        
        /**/
            ),
      drawer: const AppDrawer()
    );
  }
}