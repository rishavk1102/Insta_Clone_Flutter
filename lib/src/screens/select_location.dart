import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../credentials.dart';
import '../models/place.dart';
/*
  I AM NOT USING flutter_google_places EVEN THOUGH
  IT IS VERY EASY BECAUSE IT IS NOT CUSTOMIZABLE.
 */

class SelectLocation extends StatefulWidget {
  static const routeName = '/select-location';

  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  List<Place> _placesList = [];
  List<Place> _suggestedList = [
    Place('Jamshedpur', 'Jamshedpur'),
    Place('Berhampur', 'Berhampur'),
    Place('New-York', 'New-York'),
    Place('Jublee Park', 'Jamshedpur'),
  ];
  var _locationController = TextEditingController();

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  void getLocationResults(String input) async {
    String baseUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String type = '(regions)';
    String request = '$baseUrl?input=$input&key=$PLACES_API_KEY&type=$type';
    http.Response response = await http.get(request);

    print(response.body);
    final predictions = json.decode(response.body)['predictions'];

    for (var i = 0 ; i < predictions.length ; i++) {
      //Continue from here.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 8.0,
        title: Text('Add Location'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.blueAccent,
            ),
            onPressed: () => print('Location selected'),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          input(),
        ],
      ),
    );
  }

  Widget input() => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        child: TextField(
          controller: _locationController,
          onChanged: (text) => getLocationResults(text),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.black),
            hintText: 'Enter location',
          ),
        ),
      );
}
