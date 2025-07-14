import 'package:flutter/material.dart';

Widget firstPresentationSlider() {
  return SizedBox(
    height: 350,
    child: Stack(
      fit: StackFit.expand,
      children: [
        // Imagen de fondo
        Image.asset(
          'lib/assets/images/Zihuatanejo.jpg',
          fit: BoxFit.cover,
        ),

        // Degradado
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black54,
                Colors.transparent,
              ],
            ),
          ),
        ),

        // Texto encima
        const Positioned(
          top: 10,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ClickCards ¡Un click, muchos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black45,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
              Text(
                'ahorros!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black45,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
              // Aquí viene el fix
              SizedBox(height: 8),
              SizedBox(
                width: 350, // Ajusta el largo visible de la línea
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Todo lo que a TI te conviene en',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black45,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
              Text(
                'Ixtapa Zihuatanejo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black45,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: 350, // Ajusta el largo visible de la línea
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '¡COMPRA! ¡DEGUSTA! ¡EXPLORA!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black45,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
