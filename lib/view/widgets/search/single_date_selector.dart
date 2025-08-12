import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_tourist/view_model/card_view_model.dart';

Widget singleDateSelector(context, TextEditingController dateController, CardViewModel cardViewModel, int clientId, bool isGeneralDashboard) {
  return TextField(
    controller: dateController,
    decoration: const InputDecoration(
      icon: Icon(Icons.calendar_today),
      labelText: "Enter Date"
    ),
    readOnly: true,
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101)
      );
      
      if(pickedDate != null ) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        if (isGeneralDashboard) {
          await cardViewModel.getVisitedAndDownloadedCardsGeneralDate(formattedDate);
        } else {
          await cardViewModel.getVisitedAndDownloadedCardsDateByCardId(clientId, formattedDate);
        }
        dateController.text = formattedDate;
      }
    }
  );
}