import 'package:wether/data_service.dart';
import 'package:flutter/material.dart';

import 'models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse _response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          //f(WeatherInfo.fromJson(weatherInfoJson)=="Sunny"){
         backgroundColor: Colors.blue.shade100,

          appBar: AppBar(
            title: Text("Wether",style: TextStyle(color:Colors.white),),
            backgroundColor: Colors.pink.shade200,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_response != null)
                  Container(
                    width: 400,
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(15),),
                    child: Column(
                      children: [
                        Image.network(_response.iconUrl),
                        Text(
                          '${_response.tempInfo.temperature}°',
                          style: TextStyle(fontSize: 40),
                        ),
                        Text(_response.weatherInfo.description)
                      ],
                    ),
                  ),
                Container(
                  height: 300,
                 width: 400,
                 // color: Colors.blue.shade200,
                   decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(15),),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: SizedBox(
                      width: 150,
                      child: TextField(
                          controller: _cityTextController,
                          decoration: InputDecoration(labelText: 'City'),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: _search, child: Text('Search'))
              ],
            ),
          ),
        ));
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}