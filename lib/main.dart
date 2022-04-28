import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Calculator App',
      home: CalculatorForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo[600],
        accentColor: Colors.indigoAccent,
      ),
    );
  }
}

class CalculatorForm extends StatefulWidget {
  const CalculatorForm({Key? key}) : super(key: key);

  @override
  State<CalculatorForm> createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<CalculatorForm> {

  var _formKey = GlobalKey<FormState>(); //Act as a key for our form, <FormState> is a super class

  var _currencies = ['MYR', 'SGD', 'USD'];
  final _minimumPadding = 5.0;
  var _currentSelectedItem = '';

  @override
  initState() {
    super.initState();
    _currentSelectedItem = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = "";

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleSmall;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),

      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding * 2),
          child: ListView(
            children: [
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]+"))],
                  validator: (String? principaltext) { //NULL SAFETY, putting "?" means that the principaltext can be String or NULL. Better option is to check before passing the arguments
                    if(principaltext.toString().isEmpty) {
                      return 'Please insert principal amount';
                    }
                  },
                  //validator: (value) => value!.isEmpty? 'Email cannot be empty' : null,

                  decoration: InputDecoration(
                      labelText: 'Principal',
                      hintText: 'Enter Principal e.g. 12000',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]+"))],
                  validator: (String? roitext) {
                    if(roitext.toString().isEmpty) {
                      return 'Please insert Interest Rate';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Interest Rate',
                      hintText: 'Enter Interest Rate e.g. 4.0',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        controller: termController,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]+"))],
                        validator: (String? value) => value!.isEmpty ? 'Please Insert Terms' : null,
                        decoration: InputDecoration(
                            labelText: 'Term',
                            hintText: 'Time in years',
                            errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            )),
                      ),
                    ),
                    Container(
                      width: _minimumPadding * 5,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                          items: _currencies.map((String dropDownItem) {
                            //(String dropDownItem) = get value as a String in the iteration for each of the item, eg. MYR, SGD or USD
                            return DropdownMenuItem<String>(
                              value: dropDownItem,
                              child: Text(dropDownItem),
                            );
                          }).toList(),
                          value: _currentSelectedItem,
                          onChanged: (String? newSelectedValue) {
                            _onDropDownItemSelected(newSelectedValue);
                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: [
                    Expanded(
                        child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Calculate',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          if(_formKey.currentState!.validate()) {
                            this.displayResult = _calculateTotalReturns();
                            //Return true if validator passed
                          }
                        });
                      },
                    )),
                    Expanded(
                        child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Reset',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    )),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('assets/bank.jpg');
    Image image = Image(
        image: assetImage,
        width: 125.0,
        height: 125.0); //Image image = Image.asset('')

    return Container(
        child: image, margin: EdgeInsets.all(_minimumPadding * 10));
  }

  void _onDropDownItemSelected(String? newValueSelected) {
    setState(() {
      this._currentSelectedItem = newValueSelected.toString();
      debugPrint('$_currentSelectedItem');
    });
  }

  String _calculateTotalReturns() {
    double principal =
        double.parse(principalController.text); //Text is the String
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        'After $term years, your investment will be worth $totalAmountPayable';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentSelectedItem = _currencies[0];
  }
}
