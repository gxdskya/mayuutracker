import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:async/async.dart';
import 'dart:io';
import 'package:csia/VidPlayer/YoutubeResponse.dart';

class ApiService{
  String _apiKey = 'AIzaSyCStIqRn98hE33EiOn1ytcVpod5s8kDWXw';
  static final ApiService apiService = ApiService();
  String nextPageToken = '';
  Future<List> getYoutubeData(String maxResults, String searchTerm) async{

    String apiKey = apiService._apiKey;
    http.Response response = await http.get(Uri.parse('https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults='+maxResults+'&q=+'+searchTerm+'+&type=video&key='+apiKey));
    if(response.statusCode==200){
      print(response.body);
      YoutubeResponse youtubeResponse = YoutubeResponse.fromJson(jsonDecode(response.body));
      nextPageToken = youtubeResponse.nextPageToken;
      return youtubeResponse.items;
    }
    else{
      throw json.decode(response.body)["error"]["message"];//prints to console
    }
  }
  Future<List> getNextPage(String nextPageToken, String maxResults, String searchTerm) async{
    http.Response response = await http.get(Uri.parse('https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults='+maxResults+'&q=+'+searchTerm+'&pageToken='+nextPageToken+'+&type=video&key='+_apiKey));
    if(response.statusCode==200){
      print(response.body);
      YoutubeResponse youtubeResponse = YoutubeResponse.fromJson(jsonDecode(response.body));

      return youtubeResponse.items;
    }
    else{
      throw json.decode(response.body)["error"]["message"];//prints to console
    }
  }
  Future<String> getNextPageToken(String maxResults, String searchTerm, String token) async {
    http.Response response;
    if (token ==''){
      response = await http.get(Uri.parse('https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults='+maxResults+'&q=+'+searchTerm+'+&type=video&key='+_apiKey));
    }
    else{
     response = await http.get(Uri.parse('https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults='+maxResults+'&q=+'+searchTerm+'&pageToken='+nextPageToken+'+&type=video&key='+_apiKey));

    }

    YoutubeResponse youtubeResponse = YoutubeResponse.fromJson(jsonDecode(response.body));
    return youtubeResponse.nextPageToken;

  }
}

//todo create api calls for the load next page