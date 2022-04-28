class Quote {
  late String text; //late String text //When used in Named or Optional Parameters need to put required when this.value
  late String author;

  Quote({ required this.text, required this.author }) //Named Parameter {} or Optional Parameter [] //Named doesn't care about the order of arguments passing
  {
  }
}