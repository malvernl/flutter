import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FavouriteCity(),
    );
  }
}

class FavouriteCity extends StatefulWidget {
  const FavouriteCity({Key? key}) : super(key: key);

  @override
  State<FavouriteCity> createState() => _FavouriteCityState();
}

class _FavouriteCityState extends State<FavouriteCity> {

  String nameCity = "";
  var _currencies = ['USD', 'MYR', 'SGD', 'OTHERS'];
  var _currentItemSelected = 'MYR';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stateful App'),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              onSubmitted: (String userInput) {
                setState(() {
                  nameCity = userInput;
                });
              },
            ),
            DropdownButton<String>(
                items: _currencies.map((String dropDownItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownItem,
                    child: Text(dropDownItem),
                  );
                }).toList(), //Map will get value as a string, in an iteration for each of the list item

                onChanged: (String? newValueSelected) { //When Changed the selected value will be stored in the var newValueSelected
                  dropDownItemSelected(newValueSelected);
                },

              value: _currentItemSelected,

            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'Your City is $nameCity',
                style: TextStyle(
                  fontSize: 20.0,
                )
              ),
            )
          ],
        ),
      )
    );
  }

  void dropDownItemSelected(String? newValueSelected) {
    setState(() {
      _currentItemSelected = newValueSelected.toString();
    });
  }
}


