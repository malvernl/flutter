import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String location;
  late String time;
  late String flag;
  late String url;
  late bool isDay;

  WorldTime({ required this.location, required this.flag, required this.url }); // WorldTime({paralocation}, paraflag){ this.location = paralocation; this.flag = paraflag; }

  Future<void> getTime() async { //Future is a temporary placeholder that tells the function to return void but only after the async completes //To use await

    try {
      //Make request
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);

      //Get Properties from data
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1,3); //If negative timezone then do substring(0,3);

      // //Create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDay = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);

    }catch (e) {
      print('Error : $e');
    }



    // String datetime = data['datetime']; //'datetime' property/key has the exact time, with offset included.
    // DateTime now = DateTime.parse(datetime.substring(0,26));
    // print(now);
  }

  // void getTime() async {
  // Response response = await get(Uri.http('jsonplaceholder.typicode.com','/todos/1')); //Get Data from the endpoint //Response object
  // Map data = jsonDecode(response.body);
  // print(data);
  // }
}

// WorldTime instance = WorldTime(location: 'Kuala Lumpur', flag: 'malaysia.png', url: '/Asia/Kuala_Lumpur');