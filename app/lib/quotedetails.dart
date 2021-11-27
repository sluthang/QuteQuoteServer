import 'package:app/quotes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedScreen extends StatelessWidget {

  const DetailedScreen({Key? key, required this.quotes}) : super(key: key);
  final Quotes quotes;

  //This widget create another page for quote details
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuteQuotes'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(quotes.name, style:const TextStyle(color: Colors.black, fontSize: 22.0)),
            const Text(''),
            Text(quotes.text, style:const TextStyle(color: Colors.black, fontSize: 19.0)),
            // ElevatedButton(onPressed: (){
            //    Navigator.pop(context);
            // }, child: const Text('Close'))
          ],
        ),
      ),
    );

  }
}