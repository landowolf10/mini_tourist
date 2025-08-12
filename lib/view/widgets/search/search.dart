import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_tourist/view/widgets/search/single_date_selector.dart';
import 'package:mini_tourist/view_model/card_view_model.dart';

BoxDecoration myBoxDecoration({Color? color}) {
  return BoxDecoration(
    color: color ?? Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  );
}

Widget buildGeneralCountContainer(CardViewModel cardViewModel, bool isGeneralDashboard) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF007BFF), Color(0xFF0056D2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dashboard General',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Row(
        children: [
          Expanded(child: _buildStatCard(
            'Total de tarjetas visitadas', 
            isGeneralDashboard 
            ? cardViewModel.visitedCount.toString()
            : cardViewModel.visitedCountById.toString())),
          const SizedBox(width: 16),
          Expanded(child: _buildStatCard(
            'Total de tarjetas descargadas', 
            isGeneralDashboard 
            ? cardViewModel.downloadedCount.toString()
            : cardViewModel.downloadedCountById.toString())),
        ],
      ),
      ],
    ),
  );
}

Widget buildGeneralCountDateContainer(BuildContext context, TextEditingController dateController, CardViewModel cardViewModel, int clientId, bool isGeneralDashboard) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    padding: const EdgeInsets.all(16),
    decoration: myBoxDecoration(color: Colors.white),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filtro por fecha',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 12),
        singleDateSelector(context, dateController, cardViewModel, clientId, isGeneralDashboard),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildStatCard(
              'Total de tarjetas visitadas', 
              isGeneralDashboard 
              ? cardViewModel.visitedCountDate.toString()
              : cardViewModel.visitedCountDateById.toString())),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard('Total de tarjetas descargadas', 
              isGeneralDashboard 
              ? cardViewModel.downloadedCountDate.toString()
              : cardViewModel.downloadedCountDateById.toString())),
          ],
        ),
      ],
    ),
  );
}

Widget buildGeneralCountDateRangeContainer(BuildContext context, CardViewModel cardViewModel, int clientId, bool isGeneralDashboard) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    padding: const EdgeInsets.all(16),
    decoration: myBoxDecoration(color: Colors.white),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filtro por rango de fechas',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 12),

        // Botón para seleccionar rango
        Center(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            icon: const Icon(Icons.date_range),
            label: const Text(
              'Selecciona rango de fechas',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              final DateTimeRange? dateTimeRange = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(3000),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Colors.blue,
                      ),
                    ),
                    child: child!,
                  );
                },
              );

              if (dateTimeRange != null) {
                String formattedStartDate =
                    DateFormat('yyyy-MM-dd').format(dateTimeRange.start);
                String formattedEndDate =
                    DateFormat('yyyy-MM-dd').format(dateTimeRange.end);

                if (isGeneralDashboard) {
                  await cardViewModel.getVisitedAndDownloadedCardsGeneralRange(formattedStartDate, formattedEndDate);
                }
                else {
                  await cardViewModel.getVisitedAndDownloadedCardsDateRangeByCardId(clientId, formattedStartDate, formattedEndDate);
                }
              }
            },
          ),
        ),

        const SizedBox(height: 20),

        // Resultados
        Row(
          children: [
            Expanded(child: _buildStatCard(
              'Total de tarjetas visitadas', 
              isGeneralDashboard
              ? cardViewModel.visitedCountRange.toString()
              : cardViewModel.visitedCountRangeById.toString())),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard(
              'Total de tarjetas descargadas', 
              isGeneralDashboard
              ? cardViewModel.downloadedCountRange.toString()
              : cardViewModel.downloadedCountRangeById.toString())),
          ],
        ),
      ],
    ),
  );
}

Widget buildFilterByCityContainer(CardViewModel cardViewModel, String? selectedCity, List<String> cities, ValueChanged<String?> onCityChanged) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF007BFF), Color(0xFF0056D2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filtro por ciudad',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: selectedCity ?? 'Todas',
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          items: cities
              .map((city) => DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  ))
              .toList(),
          onChanged: onCityChanged,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildStatCard('Total de tarjetas visitadas', cardViewModel.visitedCountCity.toString())),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard('Total de tarjetas descargadas', cardViewModel.downloadedCountCity.toString())),
          ],
        ),
      ],
    ),
  );
}




/*Widget buildFilterByCityContainer(String selectedCity, List<String> cities, ValueChanged<String?> onChanged,
    {required int visited, required int downloaded}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    padding: const EdgeInsets.all(16),
    decoration: myBoxDecoration(color: Colors.blue.shade50),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filtro por ciudad',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: selectedCity,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          items: cities
              .map((city) => DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatCard('Total de tarjetas visitadas', visited.toString()),
            _buildStatCard('Total de tarjetas descargadas', downloaded.toString()),
          ],
        )
      ],
    ),
  );
}*/


Widget _buildStatCard(String title, String value) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    ),
  );
}
