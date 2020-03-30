import 'dart:async';
import 'package:intl/intl.dart'; // DateFormat
import 'package:flutter/material.dart';
import 'package:flutter/services.Dart'; //Oriantación

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    //Block orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // new Timer(const Duration(seconds: 1), () {
    //   setState(() {
    //       data['time'] = DateTime.parse(data['time'])
    //         .add(Duration(minutes: 1))
    //         .toString();
    //   });
    // });

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child: Container(
          color: Colors.blue[900],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 45.0,
                      color: Colors.white,
                      letterSpacing: 2.0,
                      fontFamily: 'Kalam',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Text(
                data['date'],
                style: TextStyle(
                  fontSize: 17.0,
                  letterSpacing: 2.0,
                  color: Colors.amberAccent,
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                DateFormat.jm().format(DateTime.parse(data['time'])),
                style: TextStyle(
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
            if (result != null) {
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
          child: Icon(Icons.edit_location, color: Colors.black),
          backgroundColor: Colors.amberAccent,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
