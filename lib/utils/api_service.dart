import 'dart:convert';
import 'dart:developer';

import 'package:fluttertest/models/emotion_model.dart';
import 'package:fluttertest/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class ApiService {
  Client client = Client();
  var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);

  // Future<EmotionModel> getEmotion(message) async {
  //   Map<String, String> headers = {
  //     "Accept":"application/json"
  //   };
  //   Map<String, dynamic> bodyParams = {
  //     "message" : message
  //   };
  //   Response response = await client.post(
  //     url,
  //     body: bodyParams,
  //     headers: headers,
  //     encoding: Encoding.getByName("utf-8")
  //   );
  //   if (response.statusCode == 200) {
  //     return EmotionModel.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception(response.body);
  //   } // check the status code for the result
  // }

  Future<dynamic> getEmotion(message) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://10.0.2.2:8000/predict'));
    request.body = json.encode({
      "message": message
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String asd = await response.stream.bytesToString();
      return json.decode(asd)["emotion"];
    }
    else {
      print(response.reasonPhrase);
    }
    return null;
  }
}




