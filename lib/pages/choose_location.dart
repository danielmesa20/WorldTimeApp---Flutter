import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  WorldTime instance;
  bool loading = false;

  List<WorldTime> locations = [
    WorldTime(url: 'America/Cordoba', location: 'Cordoba', flag: 'arg.png'),
    WorldTime(url: 'Europe/Athens', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Berlin', flag: 'germany.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'America/Caracas', location: 'Caracas', flag: 'vene.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
  ];

  _ChooseLocationState() {
    instance = null;
  }

  void updateTime(index) async {
    instance = locations[index];
    await instance.getTime();

    //Navigate to home screen
    Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
      'date': instance.date
    });
  }

  @override
  Widget build(BuildContext context) {

    Color appBarColor = loading ? Colors.grey[900] : Colors.blue[900];

    return Scaffold(
      appBar: loading == false
          ? AppBar(
              backgroundColor: appBarColor,
              title: Text("Choose a Location"),
              centerTitle: true,
              elevation: 0.0,
            )
          : null,
      body: loading == false
          ? ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 0.0),
                  child: Card(
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          loading = true;
                        });
                        updateTime(index);
                      },
                      title: Text(locations[index].location),
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/${locations[index].flag}'),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
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
                  )),
            ),
    );
  }
}
