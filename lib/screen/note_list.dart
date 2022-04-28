import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notekeeper/models/note.dart';
import 'package:notekeeper/utils/database_helper.dart';
import 'package:notekeeper/screen/note_details.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList = <Note>[]; //Note is our Object, a list of Note (Object)
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if(noteList == null) {
      noteList = <Note>[];
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('clicked');
          navigateToDetails(Note('','', 2), 'Add Note');
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.titleSmall;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this.noteList[position].priority),
              child: getPriorityIcons(this.noteList[position].priority),
            ),
            title: Text(this.noteList[position].title, style: titleStyle),
            subtitle: Text(this.noteList[position].date),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete(context, this.noteList[position]);
              },
            ),
            onTap: () {
              debugPrint("ListTile tapped");
              navigateToDetails(this.noteList[position],'Edit Note');
            },
          ),
        );
      },
    );
  }

  //Return PriorityColor
  Color getPriorityColor(int priority)
  {
    switch (priority)
    {
      case 1:
        return Colors.red;
      case 2:
        return Colors.yellow;
      default:
        return Colors.yellow;
    }
  }

  //Return PriorityIcons
  Icon getPriorityIcons(int priority)
  {
    switch (priority)
    {
      case 1:
        return Icon(Icons.play_arrow);
      case 2:
        return Icon(Icons.keyboard_arrow_right);
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
       _showSnackBar(context, 'Note Deleted');
       updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetails(Note note, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return NoteDetails(note, title);
    }));
    updateListView();
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase(); //Get Instance of Database
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList(); //Get List of Note
      noteListFuture.then((noteList) //From the noteListFuture we can get the List of Note as in the variable noteList and passed to the current one
      {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      }); //Update Note List
    });
  }
}
