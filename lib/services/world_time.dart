import 'package:http/http.dart';
import 'dart:convert';            // jsonDecode
import 'package:intl/intl.dart';  // DateFormat

class WorldTime {

  String location; // location name fot the UI
  String time;     // the time in that location
  String flag;     // url to an asset flag icon
  String url;      // location url for api endpoint
  bool isDaytime;  //true o false if daytime or not

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {

    try{

      //Make the request
      Response response = await get ('http://worldtimeapi.org/api/timezone/$url');

      //Pasar la respuesta de json a Map
      Map data = jsonDecode(response.body);

      //Get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //Create datetime object
      DateTime now = DateTime.parse(datetime);

      //Cambiando el formato de la fecha
      now = now.add(Duration(hours: int.parse(offset)));

      // Definiendo si es de dia o de noche 6 am a 7 pm se considera de día
      isDaytime =  now.hour > 6 &&  now.hour < 19 ? true : false;

      //Cambiando el formato de la fecha
      time = DateFormat.jm().format(now);

    }catch(e){
      //Imprimiendo el error
      print('Error al pedir la hora a la api: $e');
      time = 'could not get time data';
    }

  }

}