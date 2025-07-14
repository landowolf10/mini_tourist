import 'package:flutter/material.dart';
import 'package:mini_tourist/utils/constant_data.dart';
import 'package:mini_tourist/view/widgets/main_page_widgets/all_categories_widget.dart';
import 'package:mini_tourist/view_model/client_view_model.dart';

Widget allCategoriesDistributionWidget(ClientViewModel clientViewModel) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final item = categories[index];

        return GestureDetector(
          onTap: () {
            if (item['category'] == 'all_categories') {
              showAllCategoriesPopup(context, clientViewModel);
            } else {
              clientViewModel.fetchCardNamesByCategory(item['category']!);
            }
          },
          child: ClipRRect(
            // Mueve ClipRRect aquí para que afecte a toda la tarjeta
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Imagen de fondo con oscurecimiento
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                    child: Image.asset(
                      item['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Texto centrado
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        item['text']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          shadows: [
                            Shadow(
                              color: Colors.black45,
                              blurRadius: 6,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
