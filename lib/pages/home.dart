import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map timeDate = {};

  @override
  Widget build(BuildContext context) {

    timeDate = timeDate.isNotEmpty ? timeDate : ModalRoute.of(context)!.settings.arguments as Map; //Receive the arguments sent from loading.dart //Initial Date //If is empty return the inital, if not then use the new
    print(timeDate);

    //Set Background
    String bgImage = timeDate['isDay'] ? 'day.jpg' : 'night.png';
    Color? bgColor = timeDate['isDay'] ? Colors.blue : Colors.indigo[700];
    Color? textColor = timeDate['isDay'] ? Colors.white : Colors.blueGrey[100];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                FlatButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location'); //Push to another route with the Context Object
                    setState(() {
                      timeDate = {
                        'time': result['time'],
                        'location': result['location'],
                        'flag': result['flag'],
                        'isDay': result['isDay'],
                      }; //Overriding the old timeDate MAP with the new one
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: textColor,
                  ),
                  label: Text(
                      'Edit Location',
                      style: TextStyle(
                        color: textColor,
                      ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      timeDate['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: textColor,
                      )
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  timeDate['time'],
                  style: TextStyle(
                    fontSize: 20.0,
                    color: textColor,
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
