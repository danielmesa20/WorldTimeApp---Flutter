import 'dart:async';
import 'package:intl/intl.dart';  // DateFormat
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

      // Timer t = new Timer(const Duration(seconds: 1), () {
      //   setState(() {
      //       data['time'] = DateTime.parse(data['time'])
      //         .add(Duration(minutes: 1))
      //         .toString();
      //   });
      // });

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    //Selecciona el background image y background color dependiendo si es de día o de noche
    Color bgImage = data['isDaytime'] ? Colors.blue : Colors.indigo;
    Color bgColor = data['isDaytime'] ? Colors.blueAccent : Colors.indigoAccent;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          color: bgImage,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: TextStyle (
                          fontSize: 45.0,
                          color: Colors.amberAccent,
                          letterSpacing: 2.0, 
                          fontFamily: 'Kalam',
                        ),
                      ),
                    ],
                  ),
                  Text(
                    data['date'],
                    style: TextStyle (
                      fontSize: 17.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    DateFormat.jm().format(DateTime.parse(data['time'])),
                    style: TextStyle (
                      fontSize: 70.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                      fontFamily: 'IndieFlower',
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: FloatingActionButton(
             onPressed: () async {
                dynamic result = await Navigator.pushNamed(context, '/location');
                if(result != null){
                  setState(() {            
                    data = {
                      'time': result['time'],
                      'location': result['location'],
                      'isDaytime': result['isDaytime'],
                      'flag': result['flag'],
                      'date': result['date']
                    };
                  });
                }
              }, 
              child: Icon(Icons.edit_location),
              backgroundColor: Colors.grey[800],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}