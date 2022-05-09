// ignore_for_file: prefer_const_constructors

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({ Key? key }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  
  
 
  // void initState() async{
  //   try{
  //     Position position =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //     mylatitude= position.latitude;
  //     mylongitude = position.longitude;
  //     print(mylatitude);
  //     print(mylongitude);
  //   }catch(e){
  //     print(e);
  //   }
  //   super.initState();
  //   Navigator.pushNamed(context, '/second');
  // }


  var location= '';
  var weather= '';
  var humidity=0;
  double temperature=0;
  var myIcon;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 900,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/blue.jpg'),
            fit: BoxFit.cover
          ),
          
        ),
        child: Column(
          
          children: [
            
            
            ElevatedButton(
              onPressed: () async{
      
                // const url = 'https://jsonplaceholder.typicode.com/users';
      
                // const url ='http://api.weatherapi.com/v1/current.json?key=0e6f1ea41560420b967135244222804&q=Akure&aqi=no';
    
                const url= 'https://api.openweathermap.org/data/2.5/weather?lat=7.2571&lon=5.2058&appid=6af2bb7ae8c0029e377e20528ee2aa97';
      
                var response = await http.get(Uri.parse(url));
                var userDetails = jsonDecode(response.body);
                print(userDetails);
      
                setState(() {
                location= userDetails["name"];
                weather= userDetails["weather"][0]["description"];
                myIcon= userDetails["weather"][0]["icon"];
                humidity= userDetails["main"]["humidity"];
                temperature= userDetails["main"]["temp"];
    
                });
                print(response.statusCode);
                print(location);
                print(temperature);
                
      
                
      
                try {
                  Position position =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                  var mylatitude= position.latitude;
                  var mylongitude = position.longitude;
                  
                  print(mylatitude);
                  print(position);
                  
                  print(mylongitude);
                }catch(e){
                  print(e);
                }
            }, 
              child: Text('GET LOCATION')
            ),
      
            Text('You are in $location '),
            Text('weather: $weather'),
            Image.network('http://openweathermap.org/img/wn/04d@2x.png'),
            Text('Temperature is $temperature K'),
            Text('humidity is $humidity ')
          ],
        ),
      ),
    );
  }
}