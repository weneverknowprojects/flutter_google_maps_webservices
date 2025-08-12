library flutter_google_maps_webservices.places.autocomplete.example;

import 'dart:async';
import 'dart:io';
import 'package:flutter_google_maps_webservices/places.dart';

final places = GoogleMapsPlaces(
  apiKey: "API_KEY",
  baseUrl: "https://places.googleapis.com/v1",
  apiPath: "/places",
  apiHeaders: {
    'Content-Type': 'application/json',
    'X-Goog-Api-Key': "API_KEY", // Correct header name
  },
);

Future<void> main() async {
  var sessionToken = 'xyzabc_1234';
  var details = await places.getDetailsByPlaceId(
    "PLACE_ID",
    sessionToken: sessionToken,
  );

  print('\nDetails :');
  print(details.result.formattedAddress);
  print(details.result.formattedPhoneNumber);
  print(details.result.url);
  return;
  var res = await places.autocomplete('Amoeba', sessionToken: sessionToken);

  if (res.isOkay) {
    // list autocomplete prediction
    for (var p in res.predictions) {
      print('- ${p.description}');
    }

    final placeId = res.predictions.first.placeId;
    if (placeId == null) return;

    // get detail of the first result
    var details = await places.getDetailsByPlaceId(
      placeId,
      sessionToken: sessionToken,
    );

    print('\nDetails :');
    print(details.result.formattedAddress);
    print(details.result.formattedPhoneNumber);
    print(details.result.url);
  } else {
    print(res.errorMessage);
  }

  places.dispose();
}
