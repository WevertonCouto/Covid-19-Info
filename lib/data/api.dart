import 'dart:convert';

import 'package:covid_19/models/Country.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Api {


  /// Get list all countries
  static Future<List<Country>> getCountries() async {
    try {
      Response response = await http
          .get('https://covid19-brazil-api.now.sh/api/report/v1/countries');
      List<Country> listCountries = <Country>[];
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        for (var i = 0; i < json['data'].length; i++) {
          listCountries.add(Country(json['data'][i]['country']));
        }
      }
      return listCountries;
    } catch (e) {
      throw e;
    }
  }

  // Get info about one country
  static Future<Country> getByCountry(String countryName) async {
    try {
      Response response = await http
          .get('https://covid19-brazil-api.now.sh/api/report/v1/$countryName');
      var json = jsonDecode(response.body);
      Country country = new Country(json['data']['country']);
      country.cases = json['data']['cases'];
      country.confirmed = json['data']['confirmed'];
      country.deaths = json['data']['deaths'];
      country.recovered = json['data']['recovered'];
      return country;
    } catch (e) {
      throw e;
    }
  }
}
