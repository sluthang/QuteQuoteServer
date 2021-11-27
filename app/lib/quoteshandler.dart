import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/quotes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quotedetails.dart';

class MyQuotes extends StatefulWidget {
  const MyQuotes({Key? key, children}) : super(key: key);

  @override
  _MyQuotesState createState() => _MyQuotesState();
}

class _MyQuotesState extends State<MyQuotes> {
  final TextEditingController name = TextEditingController();
  final TextEditingController text = TextEditingController();
  List _quoteList = [];

  @override
  void initState(){
    super.initState();
    getJsonData();
  }

  // This function allows you to add new quotes in a textbox
  void _show(BuildContext ctx){
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: ctx,
        builder: (ctx)  => Padding(
          padding: MediaQuery.of(ctx).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                keyboardType: TextInputType.name,
                controller: name,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                keyboardType: TextInputType.text,
                controller: text,
                decoration: const InputDecoration(labelText: 'Quote'),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(onPressed: (){
                setState(() {
                  updateQuotes(name.text, text.text);

                  Navigator.pop(ctx);
                  name.clear();
                  text.clear();
                  getJsonData();
                });
              }, child: const Text('Submit'))
            ],
          ),
        ));
  }

  //Displays quotes in a list form
  Future<String> getJsonData() async{
    var response = await http
        .get(Uri.parse('http://20.10.11.124:5000/quotes'));
    //only accept json response
    headers: <String, String>{
      'Content-Type' : 'application/json; charset=UTF-8'
    };
    var responseData = jsonDecode(response.body) as List;
    //printing the list of the quotes on the terminal
    print(response.body);

    setState(() {
      _quoteList = responseData.map((e) => Quotes.fromJson(e)).toList();
    });
    return (response.body);
  }

  //This function allows us to add new quote
  Future<Quotes> updateQuotes(String name, String text) async {
    final response = await http.post(
      Uri.parse('http://20.10.11.124:5000/quotes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': text,
        'name': name,
      }),
    );
    return Quotes.fromJson(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: _quoteList.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(_quoteList[index].name),
            subtitle: Text(
              _quoteList[index].text,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) =>
                    DetailedScreen(quotes: _quoteList[index],)
                )
              );
            },
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _show(context),
      ),
    );
  }
}


