import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../credentials.dart';
import '../models/place.dart';
/*
  I AM NOT USING flutter_google_places EVEN THOUGH
  IT IS VERY EASY BECAUSE IT IS NOT CUSTOMIZABLE.

  RECEIVED JSON : (INPUT = 'pa')

  {
    "predictions": [
        {
            "description": "Paris, France",
            "id": "691b237b0322f28988f3ce03e321ff72a12167fd",
            "matched_substrings": [
                {
                    "length": 2,
                    "offset": 0
                }
            ],
            "place_id": "ChIJD7fiBh9u5kcRYJSMaMOCCwQ",
            "reference": "ChIJD7fiBh9u5kcRYJSMaMOCCwQ",
            "structured_formatting": {
                "main_text": "Paris",
                "main_text_matched_substrings": [
                    {
                        "length": 2,
                        "offset": 0
                    }
                ],
                "secondary_text": "France"
            },
            "terms": [
                {
                    "offset": 0,
                    "value": "Paris"
                },
                {
                    "offset": 7,
                    "value": "France"
                }
            ],
            "types": [
                "locality",
                "political",
                "geocode"
            ]
        },
        {
            "description": "Patna, Bihar, India",
            "id": "4fc282a7b1c8d08f121b0e74132c2dad67f1198d",
            "matched_substrings": [
                {
                    "length": 2,
                    "offset": 0
                }
            ],
            "place_id": "ChIJBU8txTeZ8jkRcLIH9gUOGoM",
            "reference": "ChIJBU8txTeZ8jkRcLIH9gUOGoM",
            "structured_formatting": {
                "main_text": "Patna",
                "main_text_matched_substrings": [
                    {
                        "length": 2,
                        "offset": 0
                    }
                ],
                "secondary_text": "Bihar, India"
            },
            "terms": [
                {
                    "offset": 0,
                    "value": "Patna"
                },
                {
                    "offset": 7,
                    "value": "Bihar"
                },
                {
                    "offset": 14,
                    "value": "India"
                }
            ],
            "types": [
                "locality",
                "political",
                "geocode"
            ]
        },
        {
            "description": "Pakistan",
            "id": "9186f9868169e0c14adb511cd0659bc45b630687",
            "matched_substrings": [
                {
                    "length": 2,
                    "offset": 0
                }
            ],
            "place_id": "ChIJH3X9-NJS2zgRXJIU5veht0Y",
            "reference": "ChIJH3X9-NJS2zgRXJIU5veht0Y",
            "structured_formatting": {
                "main_text": "Pakistan",
                "main_text_matched_substrings": [
                    {
                        "length": 2,
                        "offset": 0
                    }
                ]
            },
            "terms": [
                {
                    "offset": 0,
                    "value": "Pakistan"
                }
            ],
            "types": [
                "country",
                "political",
                "geocode"
            ]
        },
        {
            "description": "Palembang, Palembang City, South Sumatra, Indonesia",
            "id": "64094a95da76c10c1ee943a2cb30d7e98a2c533b",
            "matched_substrings": [
                {
                    "length": 2,
                    "offset": 0
                }
            ],
            "place_id": "ChIJ46Mn_Oh1Oy4RwNAgsoCdAwM",
            "reference": "ChIJ46Mn_Oh1Oy4RwNAgsoCdAwM",
            "structured_formatting": {
                "main_text": "Palembang",
                "main_text_matched_substrings": [
                    {
                        "length": 2,
                        "offset": 0
                    }
                ],
                "secondary_text": "Palembang City, South Sumatra, Indonesia"
            },
            "terms": [
                {
                    "offset": 0,
                    "value": "Palembang"
                },
                {
                    "offset": 11,
                    "value": "Palembang City"
                },
                {
                    "offset": 27,
                    "value": "South Sumatra"
                },
                {
                    "offset": 42,
                    "value": "Indonesia"
                }
            ],
            "types": [
                "locality",
                "political",
                "geocode"
            ]
        },
        {
            "description": "Pasadena, CA, USA",
            "id": "8b4b3c6cbc5db3b204124335deee6ae96ba83765",
            "matched_substrings": [
                {
                    "length": 2,
                    "offset": 0
                }
            ],
            "place_id": "ChIJUQszONzCwoARSo_RGhZBKwU",
            "reference": "ChIJUQszONzCwoARSo_RGhZBKwU",
            "structured_formatting": {
                "main_text": "Pasadena",
                "main_text_matched_substrings": [
                    {
                        "length": 2,
                        "offset": 0
                    }
                ],
                "secondary_text": "CA, USA"
            },
            "terms": [
                {
                    "offset": 0,
                    "value": "Pasadena"
                },
                {
                    "offset": 10,
                    "value": "CA"
                },
                {
                    "offset": 14,
                    "value": "USA"
                }
            ],
            "types": [
                "locality",
                "political",
                "geocode"
            ]
        }
    ],
    "status": "OK"
  }
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
    Place('Chhota Govindpur', 'Jamshedpur'),
  ];
  var _locationController = TextEditingController();

  bool isSearching = false;

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  void getLocationResults(String input) async {
    _placesList.clear();
    String baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String type = '(regions)';
    String request = '$baseUrl?input=$input&key=$PLACES_API_KEY&type=$type';
    http.Response response = await http.get(request);

    final List predictions = json.decode(response.body)['predictions'];

    for (var i = 0; i < predictions.length; i++) {
      _placesList.add(Place(predictions[i]['description'],
          predictions[i]['structured_formatting']['secondary_text']));
    }
    print(_placesList[4].subTitle);

    setState(() {
      isSearching = true;
      _placesList = _placesList.reversed.toList();
    });
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
          SizedBox(height: 10.0),
          suggestions(),
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

  Widget suggestions() => Expanded(
        child: ListView.builder(
          itemCount: isSearching ? _placesList.length : 5,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Place place =
                    (isSearching) ? _placesList[index] : _suggestedList[index];
                Navigator.of(context).pop(place);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(isSearching
                      ? (_placesList[index].title != null)
                          ? _placesList[index].title
                          : ''
                      : _suggestedList[index].title),
                  subtitle: Text(isSearching
                      ? (_placesList[index].subTitle != null)
                          ? _placesList[index].subTitle
                          : ''
                      : _suggestedList[index].subTitle),
                ),
              ),
            );
          },
        ),
      );
}
