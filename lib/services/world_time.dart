import 'package:http/http.dart';
import 'dart:convert';            // jsonDecode

class WorldTime {

  String location; // location name fot the UI
  String time;     // the time in that location
  String url;      // location url for api endpoint
  bool isDaytime;  // true o false if daytime or not
  String date;     // date of the country
  String flag;     // flag of the country
    
  //Constructor 
  WorldTime({ this.location, this.url, this.flag });

  //Función que devuelve los datos del pais buscado
  Future <void> getTime() async {

    try{

      //Make the request
      Response response = await get ('http://worldtimeapi.org/api/$url');

      //Pasar la respuesta de json a Map
      Map data = jsonDecode(response.body);
   
      //Get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
    
      //Create datetime object
      DateTime now = DateTime.parse(datetime);

      //Saving the date
      date = "${now.day}/${now.month}/${now.year}";
    
      // Sumando/Restando el offset
      if(data['utc_offset'].toString().contains('-')){
         now = now.add(Duration(hours: -int.parse(offset)));
      }else{
         now = now.add(Duration(hours: int.parse(offset)));
      }
      
      // Definiendo si es de dia o de noche, 6 am a 7 pm se considera de día
      isDaytime =  now.hour > 6 &&  now.hour < 19 ? true : false;

      //Cambiando el tipo de dato de la fecha
      time = now.toString();
    
      // Separa el "timezone" en Continente y pais solo usamos el país (posición [1])
      location = data['timezone'].toString().split('/')[1];

    }catch(e){
      //Imprimiendo el error
      print('Error al pedir la hora a la api: $e');
      time = 'could not get time data';
    }

  }

}