import 'package:flutter/material.dart';
import 'package:mini_tourist/view_model/client_view_model.dart';
import 'package:provider/provider.dart';

class PlaceDetail extends StatefulWidget {
  const PlaceDetail({super.key});

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  @override
  void initState() {
    final clientViewModel = Provider.of<ClientViewModel>(context, listen: false); //This sets the images variable from the viewmodel
    clientViewModel.getCardsByPlaceNull();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}