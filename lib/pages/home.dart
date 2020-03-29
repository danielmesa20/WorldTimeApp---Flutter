import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    //Selecciona el background image y background color dependiendo si es de día o de noche
    Color bgImage = data['isDaytime'] ? Colors.blue : Colors.indigo;
    Color bgColor = data['isDaytime'] ? Colors.blueAccent : Colors.indigoAccent;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/$bgImage'),
          //     fit: BoxFit.cover,
          //   )
          // ),
          color: bgImage,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag']
                      };
                    });
                  }, 
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.red[300],
                    size: 30.0,
                    ),
                  label: Text(
                    "Edit Location",
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18.0,
                    ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: TextStyle (
                          fontSize: 35.0,
                          color: Colors.amberAccent,
                          letterSpacing: 2.0, 
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    data['time'],
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
          floatingActionButton: FloatingActionButton(
           onPressed: () async {
              dynamic result = await Navigator.pushNamed(context, '/location');
              setState(() {
                data = {
                  'time': result['time'],
                  'location': result['location'],
                  'isDaytime': result['isDaytime'],
                  'flag': result['flag']
                };
              });
            }, 
            child: Icon(Icons.edit_location),
            backgroundColor: Colors.grey[800],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}