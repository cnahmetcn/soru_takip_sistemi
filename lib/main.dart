import 'package:project_mars/add.dart';
import 'package:project_mars/models/questions.dart';
import 'package:flutter/material.dart';
import 'package:project_mars/database/dbhelper.dart';
import 'package:project_mars/detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Soru Takip Sistemi"),
              actions: <Widget>[
                PopupMenuButton(
                  itemBuilder: (content) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text("Yeni Ekle"),
                    ),
                  ],
                  onSelected: (int menu) {
                    switch (menu) {
                      case 1:
                        {
                          navigatorKey.currentState.push(MaterialPageRoute(
                              builder: (content) => AddPage()));
                        }
                        break;

                      default:
                        {}
                        break;
                    }
                  },
                ),
              ],
            ),
            body: MyHomePage()));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var db = new DatabaseHelper();
    return Padding(
      padding: EdgeInsets.all(10),
      child: FutureBuilder<List>(
        future: db.findAll(),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Question question = Question.fromJson(snapshot.data[index]);
                return Card(
                  child: ListTile(
                    title: Text(question.dersadi),
                    subtitle: Text(question.konuadi +
                        " - " +
                        question.netsayisi.toString()),
                    trailing: Text(question.tarih.toString()),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionDetailsPage(
                              question: question,
                            ),
                          ));
                    },
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
