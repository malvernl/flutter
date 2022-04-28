import 'package:flutter/material.dart';

// void main() {
//   runApp();
// }

void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is AppBar'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Image(
              image: AssetImage('assets/picture-1.jpg'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.amber,
              child: Text('1'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.blue,
              child: Text('2'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.red,
              child: Text('3'),
            ),
          ),
        ],
      ),
        //   Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text('Hello World'),
        //     FlatButton(
        //       onPressed: (){},
        //       color: Colors.amber,
        //       child: Text('Click Me'),
        //     ),
        //     Container(
        //       color: Colors.cyan,
        //       padding: EdgeInsets.all(40.0),
        //       child: Text('Inside Container'),
        //     )
        //   ],
        // ),
        //     Container(
        //   color: Colors.grey[400],
        //   padding: EdgeInsets.all(20),
        //   margin: EdgeInsets.all(40),
        //   child: Text('Hello'),
        // ),
        // RaisedButton(
        //   onPressed: () {},
        //   child: Text('Click Me'),
        //   color: Colors.lightBlue,
        // ),

        // Icon(
        //   Icons.airport_shuttle,
        //   color: Colors.lightBlue,
        //   size: 50.0,
        // ),

        //Image
        //Image.asset('assets/picture-2.jpg'),
        //Image ( image: x ),

        // Text(
        //     'Hello Kids',
        //     style: TextStyle(
        //       fontSize: 20.0,
        //       fontWeight: FontWeight.bold,
        //       letterSpacing: 2.0,
        //       color: Colors.grey[600],
        //       fontFamily: 'IndieFlower',
        //     )
        // ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){} ,
        child: Text('Click Me'),
        backgroundColor: Colors.red[500],
      ), //Floating Action Button Bottom/Right Corner// Value will be a Widget
    ); //Implement Basic Layout
  }
}