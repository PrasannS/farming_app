import 'dart:async';
import 'dart:convert';
import 'package:farming_app/models/shop_result.dart';

import 'package:http/http.dart';

import 'package:http/http.dart' as http;




Future<List<ShopResult>> fetchShopResult(String val) async {

  String url = 'http://192.168.0.105:5000/get_shop_data?item='+val;
  Response response = await get(url);

  var j = json.decode(response.body);
  List<ShopResult> webresults = [];
  for(Map<String, dynamic> m in j['result']){
    webresults.add(ShopResult.fromJson(m));
  }

  print(webresults);

  return webresults;

}
