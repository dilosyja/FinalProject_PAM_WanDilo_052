import 'dart:convert';

import 'package:final_project/models/slider_model.dart';
import 'package:http/http.dart' as http;

class Sliders {
  List<sliderModel> sliders = [];

  Future<void> getSlider()async{
    String url="https://newsapi.org/v2/everything?domains=wsj.com&apiKey=dc9555c94fab4d23a6655ca5360bb14b";
    //
    var response= await http.get(Uri.parse(url));

    var jsonData= jsonDecode(response.body);

    if(jsonData['status']=='ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element['description']!=null){
          sliderModel slidermodel= sliderModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          sliders.add(slidermodel);
        }
      });
    }
  }
}