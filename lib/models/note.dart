
class Note {

  late int id;
  late String title;
  String? description;
  late String date;
  late int priority;

  Note(this.title, this.date, this.priority,[this.description]); // var title Note(String title){ this.title = title } //(PHP) $this->title = title;

  Note.withId(this.id,this.title, this.date, this.priority,[this.description]);

  //Getters using variable x and return it as an value of y, ( x => y )
  int get getId => id;
  String get getTitle => title;
  String get getDate => date;
  String? get getDesc => description;
  // String? get getDesc {
  //   return description;
  // }
  int get getPrior => priority;

  set setTitle(String newTitle)
  {
    if(newTitle.length < 255) {
      this.title = newTitle;
    }
  }

  set setDesc(String newDesc)
  {
    if(newDesc.length < 255) {
      this.description = newDesc;
    }
  }

  set setPrior(int newPrior)
  {
    if(newPrior >= 1 && newPrior <= 2) {
      this.priority = newPrior;
    }
  }

  set setDate(String newDate)
  {
    this.date = newDate;
  }

  //Convert Note Object into Map Object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if(id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['description'] = description;
    map['date'] = date;
    map['priority'] = priority;

    return map;
  }

  //Extraction
  Note.fromMapObject(Map<String, dynamic> map)
  {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
    this.date = map['date'];
    this.priority = map['priority'];
  }

}