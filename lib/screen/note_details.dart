import 'package:flutter/material.dart';
import 'package:notekeeper/utils/database_helper.dart';
import 'package:notekeeper/models/note.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class NoteDetails extends StatefulWidget {

  late String appBarTitle;
  final Note note;
  NoteDetails(this.note, this.appBarTitle); //Accept title as the argument to this appBarTitle parameter

  @override
  State<NoteDetails> createState() => _NoteDetailsState(this.note, this.appBarTitle);
}

class _NoteDetailsState extends State<NoteDetails> {

  final minPadding = 5;
  static var _priorities = ['High', 'Low'];

  DatabaseHelper databaseHelper = DatabaseHelper();

  late String appBarTitle;
  Note note;

  _NoteDetailsState(this.note, this.appBarTitle);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;

    titleController.text = note.title;
    descriptionController.text = note.description!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back
          ),
          onPressed: () {
            moveToLastScreen();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: minPadding * 3, left: minPadding * 2, right: minPadding * 2),
        child: ListView(
          children: [
            ListTile(
              title: DropdownButton(
                items: _priorities.map((String dropDownItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownItem,
                    child: Text(dropDownItem),
                  );
                }).toList(),
                value: convertPriorityAsString(note.priority),
                style: textStyle,
                onChanged: (String? userSelectedValue) {
                  setState(() {
                    debugPrint('User Selected $userSelectedValue');
                    updatePriorityAsInt(userSelectedValue.toString());
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: minPadding * 3, bottom: minPadding * 3),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value) {
                  updateTitle();
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: minPadding * 3, bottom: minPadding * 3),
              child: TextField(
                controller: descriptionController,
                style: textStyle,
                onChanged: (value) {
                  updateDesc();
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: minPadding * 3, bottom: minPadding * 3),
              child: Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint('Save');
                          save();
                        });
                      },
                    ),
                  ),
                  // Container(width: 5.0,),
                  SizedBox(width: 5.0),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint('Delete');
                          delete();
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
  void updatePriorityAsInt(String value) {
    switch (value) {
      case "High":
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  String convertPriorityAsString(int value) {
    late String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
    }
    return priority;
  }

  void updateTitle()
  {
    note.title = titleController.text;
  }

  void updateDesc() {
    note.description = descriptionController.text;
  }

  void save() async {

    late var result;

    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());
    if(note.id != null) {
      result = await databaseHelper.updateNote(note);
    } else {
      result = await databaseHelper.insertNote(note);
    }

    if(result != 0){
      showAlertDialog('Status', 'Note Saved Successfully!');
    }else{
      showAlertDialog('Status', 'Saving Note Failed');
    }
  }

  void showAlertDialog(String title, String message)
  {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(
      context: context,
      builder: (_) => alertDialog,
    );
  }

  void delete() async
  {
    if(note.id == null)
    {
      showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    int result = await databaseHelper.deleteNote(note.id);
    if(result != 0)
    {
      showAlertDialog('Status', 'Note Deleted Successfully');
    }else{
      showAlertDialog('Status', 'Failed to delete');
    }
  }

  void moveToLastScreen()
  {
    Navigator.pop(context, true);
  }

}
