import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading>{

  // late String time = 'loading';

  void setupWorldTime() async {
    WorldTime instance = WorldTime(location: 'Kuala Lumpur', flag: 'malaysia.png', url: '/Asia/Kuala_Lumpur');
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDay': instance.isDay,
    });

    //print(instance.time); => world_time.dart time
    //setState(() {
    //  time = instance.time;
    // });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitWave(
          size: 50.0,
          duration: const Duration(seconds: 5),
          itemBuilder: (context, int index){

            final colors = [Colors.white, Colors.pink, Colors.yellow];
            final color = colors[index % colors.length];
            final changes = index.isEven ? Colors.green : Colors.orangeAccent;

            return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: changes,
              ),
            );
          },
        ),
      ),
    );
  }
}
