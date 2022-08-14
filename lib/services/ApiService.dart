import 'dart:convert';

import '../config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String _url = AppConfig().apiUrl();
  // _setHeaders() => {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //     };
  _setHeaders(String token) => {
        'Authorization': 'Bearer ' + token,
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
  // _setHeadersWithMultipart(String token) => {
  //       'Authorization': 'Bearer ' + token,
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //     };
  // _setHeadersWithMultipartWithoutAuth(String token) => {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //     };
  _setHeadersWithoutAuth() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  postData({
    data,
    apiUrl,
    bool auth = true,
    bool multipart = false,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fullUrl = _url + apiUrl;

    if (auth == false) {
      return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeadersWithoutAuth(),
      );
    } else {
      return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeaders(prefs.getString("token")),
      );
    }
  }

  getData({apiUrl, bool auth = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fullUrl = _url + apiUrl;

    if (auth == false) {
      return await http.get(
        Uri.parse(fullUrl),
        headers: _setHeadersWithoutAuth(),
      );
    } else {
      return await http.get(
        Uri.parse(fullUrl),
        headers: _setHeaders(prefs.getString('token')),
      );
    }
  }

  putData({
    data,
    apiUrl,
    bool auth = true,
    bool multipart = false,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fullUrl = _url + apiUrl;

    if (auth == false) {
      return await http.put(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeadersWithoutAuth(),
      );
    } else {
      return await http.put(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeaders(prefs.getString('token')),
      );
    }
  }

  deleteData({apiUrl, bool auth = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fullUrl = _url + apiUrl;

    if (auth == false) {
      return await http.delete(
        Uri.parse(fullUrl),
        headers: _setHeadersWithoutAuth(),
      );
    } else {
      return await http.delete(
        Uri.parse(fullUrl),
        headers: _setHeaders(prefs.getString('token')),
      );
    }
  }
}
