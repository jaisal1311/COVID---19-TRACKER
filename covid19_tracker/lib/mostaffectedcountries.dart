import 'package:flutter/material.dart';

class MostAffectedPanel extends StatelessWidget {

  final List countryData;

  const MostAffectedPanel({Key key, this.countryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(physics: NeverScrollableScrollPhysics(),shrinkWrap: true, itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,),
            child: Container(
//            margin: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(child: Image.network(countryData[index]['countryInfo']['flag'], height: 40.0,),backgroundColor: Colors.white,),
                  SizedBox(width: 10.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      countryData[index]['country'],
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,letterSpacing: 1.0)
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Cases: ' + countryData[index]['cases'].toString(), style: TextStyle(color: Colors.blueAccent[700], fontSize: 16.0, fontWeight: FontWeight.bold,letterSpacing: 1.0)),
                        Text('Deaths: ' + countryData[index]['deaths'].toString(), style: TextStyle(color: Colors.red, fontSize: 16.0, fontWeight: FontWeight.bold,letterSpacing: 1.0)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
