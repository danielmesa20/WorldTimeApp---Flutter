import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() async {

    //Hora por defecto que muestra la aplicación
    WorldTime instance = WorldTime(location: 'Berlin', url: 'ip');
    await instance.getTime();

    //Redirige a la pantalla Home pasando como argumentos la información obtenida de la función getTime
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
      'date': instance.date
    });
  }

  //Se ejecuta solo una vez al contruir la "Activity"
  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  //Se ejecuta cada vez que se utilice el setState
  //Muestra un sprint cuando busca la información de la api
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
            child: Container(
              color: Colors.blue[900],
               child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          "Loading",
                          style:
                          TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                      ),
                      SpinKitFoldingCube(
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ],
                ),
              )
            ),
          ),
      );
  }
}