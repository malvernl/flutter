import 'package:flutter/material.dart';
import 'quote.dart';
import 'quote_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: QuoteList(),
      //home: ProjectCard(),
    );
  }
}

class QuoteList extends StatefulWidget {
  const QuoteList({Key? key}) : super(key: key);

  @override
  State<QuoteList> createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {

  List<Quote> quotes = [
    Quote(author: 'Malvern', text: 'Be Confident'),
    Quote(author: 'Mal', text: 'Be Smart'),
    Quote(author: 'Vern', text: 'Be Discipline'),
  ];

  Widget quoteTemplate(quote){
    return QuoteCard(quotev: quote, delete: quote); //Create an Instance of QuoteCard passing the quote (values)//arguments into the named parameters - quotev
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Awesome Quote',
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: quotes.map((quote) => QuoteCard( //quotes = List<Quote> quotes//<Quote> = quote.dart Class Quote //Map is used to iterate everything inside the .map(x)
          quotev: quote, //quotev = Class QuoteCard Constructor arguments
          delete: () {
            setState(() {
              quotes.remove(quote); //quote = quote that are received on quotes.map((quote)) //quotes = what to delete -> the list Quotes to delete
            });
          },
        )).toList(),
        // children: quotes.map((quote) => Text('${quote.text} - ${quote.author}')).toList(),
        // children: quotes.map((quote) => quoteTemplate(quote)).toList(), //Passing in Quote into quoteTemplate
      ),
    );
  }
}


// class ProjectCard extends StatefulWidget{
//   @override
//   State<ProjectCard> createState() => _ProjectCardState();
// }
//
// class _ProjectCardState extends State<ProjectCard> { //State Object
//
//   int ninjaLevel = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       appBar: AppBar(
//         title: Text('Project ID'),
//         centerTitle: true,
//         backgroundColor: Colors.grey[850],
//         elevation: 0.0,
//       ),
//       body: Padding(
//         padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: CircleAvatar(
//                 backgroundImage: AssetImage('assets/ninja_id/chun-li.png'),
//                 radius: 40.0,
//               ),
//             ),
//             Divider(
//               height: 60.0,
//               color: Colors.grey[800],
//             ),
//             Text(
//               'Name',
//               style: TextStyle(
//                 color: Colors.grey,
//                 letterSpacing: 2.0,
//               )
//             ),
//             SizedBox(height: 10.0),
//             Text(
//               'Chun-Li',
//               style: TextStyle(
//                 color: Colors.amberAccent[200],
//                 letterSpacing: 2.0,
//                 fontSize: 28.0,
//                 fontWeight: FontWeight.bold,
//               )
//             ),
//             SizedBox(height: 30.0),
//             Text(
//               'Current Level',
//               style: TextStyle(
//                 color: Colors.grey,
//                 letterSpacing: 2.0,
//                 fontSize: 25.0,
//                 fontWeight: FontWeight.bold,
//               )
//             ),
//             SizedBox(height: 10.0),
//             Text(
//               '$ninjaLevel',
//               style: TextStyle(
//                 color: Colors.amberAccent[200],
//                 letterSpacing: 2.0,
//                 fontSize: 25.0,
//                 fontWeight: FontWeight.bold,
//               )
//             ),
//             SizedBox(height: 30.0),
//             Row(
//               children: [
//                 Icon(
//                   Icons.email,
//                   color: Colors.grey[400],
//                 ),
//                 SizedBox(width: 10.0),
//                 Text(
//                   'chun-li@project.com',
//                   style: TextStyle(
//                     color: Colors.grey[400],
//                     fontSize: 18.0,
//                     letterSpacing: 1.0,
//                   )
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             ninjaLevel += 1; //When trigger it rebuilds the Widget
//           });
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.grey[800],
//       ),
//     );
//   }
// }
