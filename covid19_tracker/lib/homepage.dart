
import 'dart:convert';

import 'package:covid19tracker/mostaffectedcountries.dart';
import 'package:flutter/material.dart';
import 'dataSource.dart';
import 'package:covid19tracker/worldwide/worldwidepanel.dart';
import 'package:http/http.dart' as http;
import 'package:covid19tracker/infoPanel.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map worldData;

  fetchWorldwideData() async {
    http.Response response = await  http.get('https://corona.lmao.ninja/v2/all?yesterday=false');
    setState(() {
      worldData = json.decode(response.body);
    });
//  print(worldData);
  }

  List countryData;

  fetchCountryData() async {
    http.Response response = await  http.get('https://corona.lmao.ninja/v2/countries?sort=deaths');
    setState(() {
      countryData = json.decode(response.body);
    });
  print(countryData[0]['country']);
  }

  @override
  void initState() {
    fetchWorldwideData();
    fetchCountryData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 Tracker'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              fetchWorldwideData();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.orange[100],
              height: 100.0,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              child: Text(
                  DataSource.quote,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Worldwide',style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 40.0,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(10.0),

                    ),
                    child: Center(child: Text('Regional', style: TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.bold),)),
                  )
                ],
              ),
            ),
            worldData == null ? Center(child: CircularProgressIndicator()) : WorldwidePanel(worldData: worldData),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
              child: Text('Most Affected Countries',style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
            ),
//            SizedBox(height: 5.0,),
            countryData == null ? Center(child: CircularProgressIndicator()) : MostAffectedPanel(countryData: countryData,),
            SizedBox(height: 5.0,),
            InfoPanel(),
            SizedBox(height: 15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('🙏 घर के लिए घर में रहे 🙏',textAlign: TextAlign.center,style: TextStyle(letterSpacing: 1.0, fontWeight: FontWeight.bold,fontSize: 28.0),),
              ],
            ),
            SizedBox(height: 15.0,),
          ],
        ),
      )
    );
  }
}
