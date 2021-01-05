import 'dart:convert';
import 'package:http/http.dart';
import 'package:ridepool/Helper/MapCredential.dart';
import 'package:ridepool/Helper/Suggestion.dart';

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String keyAndroid = mapUseKey;


  Future<List<Suggestion>> fetchSuggestions(String placeName, String language) async {
    final requestUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$keyAndroid&components=country:pk&types=establishment&sessiontoken=$sessionToken';
    final getResponse = await client.get(requestUrl);

    if (getResponse.statusCode == 200) {//200 refers to Okay
      final parse = json.decode(getResponse.body);
      if (parse ['status'] == 'OK') {
        //Provide List of suggestions
        return parse ['predictions']
            .map<Suggestion>((d) => Suggestion(d['place_id'], d['description']))
            .toList();
      }
      if (parse ['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(parse ['error_message']);
    } else {
      throw Exception('Error in fetching Suggestion');
    }
  }
}