class Question {
  int id;
  String dersadi;
  String konuadi;
  int sorusayisi;
  int dogrusayisi;
  int yanlissayisi;
  int bossayisi;
  var netsayisi;
  var tarih;

  Question(
      {this.id,
      this.dersadi,
      this.konuadi,
      this.sorusayisi,
      this.dogrusayisi,
      this.yanlissayisi,
      this.bossayisi,
      this.netsayisi,
      this.tarih
      });


  factory Question.fromJson(Map<String, dynamic> data) => new Question(
        id: data["id"],
        dersadi: data["dersadi"],
        konuadi: data["konuadi"],
        sorusayisi: data["sorusayisi"],
        dogrusayisi: data["dogrusayisi"],
        yanlissayisi: data["yanlissayisi"],
        bossayisi: data["bossayisi"],
        netsayisi: data["netsayisi"],
        tarih: data["tarih"],
      );

  Map<String, dynamic> toJSon() => {
        "id": id,
        "dersadi": dersadi,
        "konuadi": konuadi,
        "sorusayisi": sorusayisi,
        "dogrusayisi": dogrusayisi,
        "yanlissayisi": yanlissayisi,
        "bossayisi": bossayisi,
        "netsayisi": netsayisi,
        "tarih": tarih,
      };
}
