import 'package:project_mars/database/dbhelper.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:project_mars/models/questions.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'package:project_mars/edit.dart';

class QuestionDetailsPage extends StatefulWidget {
  Question question;
  QuestionDetailsPage({Key key, this.question}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new QuestionDetailsPageState();
  }
}

class QuestionDetailsPageState extends State<QuestionDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Detaylar"),
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Tarih",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(widget.question.tarih),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Text(
                  "Ders Adı",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(widget.question.dersadi),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Text(
                  "Konu Adı",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(widget.question.konuadi),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Text(
                  "Soru Sayısı",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(widget.question.sorusayisi.toString()),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Text(
                  "Doğru Sayısı",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(widget.question.dogrusayisi.toString()),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Text(
                  "Yanlış Sayısı",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(widget.question.yanlissayisi.toString()),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Text(
                  "Boş Sayısı",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(widget.question.bossayisi.toString()),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Text(
                  "Net Sayısı",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(widget.question.netsayisi.toString()),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text("Düzenle"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPage(
                                  question: widget.question,
                                ),
                              ));
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                    ),
                    Expanded(
                      child: RaisedButton(
                        child: Text("Sil"),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return new AlertDialog(
                                  title: Text("Kayıt Silinecek"),
                                  content: Text("Emin misiniz?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Sil"),
                                      onPressed: () async {
                                        var db = DatabaseHelper();
                                        await db.delete(widget.question.id);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MyApp(),
                                            ));
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("İptal"),
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                        );
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                    ),
                    Expanded(
                      child: RaisedButton(
                        child: Text("Geri Dön"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyApp(),
                              ));
                        },
                      ),
                    ),
                  ],
                )
              ],
            )),
          ),
        ));
  }
}
