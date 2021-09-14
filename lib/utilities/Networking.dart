import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:csia/FoodSearch/classes/FoodItem.dart';
import 'package:csia/FoodSearch/FoodInstantEndpoint.dart';
class Networking{
  String apiKey = '7a7c0fe7c2e84504bd29b0b2ccf6647b';

  Networking();

  Future<InstantEndpoint> getRawData(String searchTerm) async{
    String data;
    var url = Uri.parse('https://api.spoonacular.com/food/ingredients/search?apiKey=$apiKey&query=$searchTerm');
    var response = await http.get(url);
    if (response.statusCode == 200){

      var json = convert.jsonDecode(response.body);
      InstantEndpoint instantData = InstantEndpoint.fromJson(json);
      return instantData;

    }else {
      throw Exception('something went wrong');
    }
  }
  Future<FoodItem> getFoodData(int id) async{
    String data;
    var url = Uri.parse('https://api.spoonacular.com/food/ingredients/'+id.toString()+'/information?apiKey=$apiKey&amount=1');
    var response = await http.get(url);
    if (response.statusCode ==200){
      var json = convert.jsonDecode(response.body);
      FoodItem foodData = FoodItem.fromJson(json);
      return foodData;
    }
    else{
      throw Exception('something went wrong');
    }
  }

}

