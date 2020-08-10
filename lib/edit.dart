import 'package:project_mars/database/dbhelper.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:project_mars/models/questions.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'package:project_mars/widgets/custom_date_time_picker.dart';
import 'package:project_mars/detail.dart';


class EditPage extends StatefulWidget {
  Question question;
  EditPage({Key key, this.question}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new EditPageState();
  }
}

class EditPageState extends State<EditPage> {
  var textEditingControllerDersadi = new TextEditingController();
  var textEditingControllerKonuadi = new TextEditingController();
  var textEditingControllerSorusayisi = new TextEditingController();
  var textEditingControllerDogrusayisi = new TextEditingController();
  var textEditingControllerYanlissayisi = new TextEditingController();
  var textEditingControllerBossayisi = new TextEditingController();
  var textEditingControllerNetsayisi = new TextEditingController();
  var textEditingControllerTarih = new TextEditingController();


  DateTime _selectedDate = DateTime.now();

  Future _pickDate() async {
    DateTime datepick = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));
    if (datepick != null)
      setState(() {
        var formate1 = "${datepick.day}-${datepick.month}-${datepick.year}";
        widget.question.tarih = formate1.toString();
      });
  }



  double num1 = 0, num2 = 0, num3 = 0, num4 = 0, res = 0, topsoru = 0;

  netHesapla() {
    setState(() {
      double num4 = double.parse(textEditingControllerSorusayisi.text);
      double num3 = double.parse(textEditingControllerBossayisi.text);
      double num2 = double.parse(textEditingControllerYanlissayisi.text);
      double num1 = double.parse(textEditingControllerDogrusayisi.text);
      topsoru = num1 + num2 + num3;

      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      );

      if (topsoru != num4) {
        AlertDialog alert = AlertDialog(
          title: Text("Soru Sayısı Hatası"),
          content: Text(
              "Doğru, Yanlış ve Boş sayısı toplam soru sayısına eşit değil!"),
          actions: [
            okButton,
          ],
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      } else {
        res = num1 - (num2 / 4);
        widget.question.netsayisi = res.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    textEditingControllerDersadi.text = widget.question.dersadi;
    textEditingControllerKonuadi.text = widget.question.konuadi;
    textEditingControllerSorusayisi.text =
        widget.question.sorusayisi.toString();
    textEditingControllerDogrusayisi.text =
        widget.question.dogrusayisi.toString();
    textEditingControllerYanlissayisi.text =
        widget.question.yanlissayisi.toString();
    textEditingControllerBossayisi.text = widget.question.bossayisi.toString();
    textEditingControllerNetsayisi.text = widget.question.netsayisi.toString();
    textEditingControllerTarih.text = widget.question.tarih;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Düzenle"),
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomDateTimePicker(
                  icon: Icons.date_range,
                  onPressed: _pickDate,
                  value: new DateFormat("dd-MM-yyyy").format(_selectedDate),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Tarih"),
                  controller: textEditingControllerTarih,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Ders Adı"),
                  controller: textEditingControllerDersadi,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Konu Adı"),
                  controller: textEditingControllerKonuadi,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Soru Sayısı"),
                  controller: textEditingControllerSorusayisi,
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Doğru Sayısı"),
                  controller: textEditingControllerDogrusayisi,
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Yanlış Sayısı"),
                  controller: textEditingControllerYanlissayisi,
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Boş Sayısı"),
                  controller: textEditingControllerBossayisi,
                  keyboardType: TextInputType.number,
                ),
                MaterialButton(
                  child: Text('Net Hesapla'),
                  shape: StadiumBorder(),
                  color: Colors.teal,
                  onPressed: () {
                    netHesapla();
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Net Sayısı"),
                  controller: textEditingControllerNetsayisi,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text("Kaydet"),
                        onPressed: () async {
                          widget.question.dersadi =
                              textEditingControllerDersadi.text;
                          widget.question.konuadi =
                              textEditingControllerKonuadi.text;
                          widget.question.sorusayisi = int.tryParse(
                              textEditingControllerSorusayisi.text);
                          widget.question.dogrusayisi = int.tryParse(
                              textEditingControllerDogrusayisi.text);
                          widget.question.yanlissayisi = int.tryParse(
                              textEditingControllerYanlissayisi.text);
                          widget.question.netsayisi = double.tryParse(
                              textEditingControllerNetsayisi.text);
                          widget.question.bossayisi =
                              int.tryParse(textEditingControllerBossayisi.text);
                          widget.question.tarih =
                              textEditingControllerTarih.text;

                          var question = new Question(
                            dersadi: textEditingControllerDersadi.text,
                            konuadi: textEditingControllerKonuadi.text,
                            sorusayisi: int.tryParse(
                                textEditingControllerSorusayisi.text),
                            dogrusayisi: int.tryParse(
                                textEditingControllerDogrusayisi.text),
                            yanlissayisi: int.tryParse(
                                textEditingControllerYanlissayisi.text),
                            netsayisi: double.tryParse(
                                textEditingControllerNetsayisi.text),
                            bossayisi: int.tryParse(
                                textEditingControllerBossayisi.text),
                          );
                          var db = DatabaseHelper();
                          await db.update(widget.question);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyApp(),
                              ));
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                    ),
                    Expanded(
                      child: RaisedButton(
                        child: Text("İptal"),
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
