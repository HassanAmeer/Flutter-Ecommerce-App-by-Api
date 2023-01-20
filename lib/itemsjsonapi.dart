// To parse this JSON data, do
//
//     final postsmodel = postsmodelFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<Postsmodel> postsmodelFromJson(String str) =>
    List<Postsmodel>.from(json.decode(str).map((x) => Postsmodel.fromJson(x)));

String postsmodelToJson(List<Postsmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Postsmodel {
  Postsmodel({
    required this.id,
    required this.img,
    required this.title,
    required this.desc,
    required this.price,
    required this.size,
    required this.time,
    required this.catg,
  });

  String id;
  String img;
  String title;
  String desc;
  String price;
  String size;
  DateTime time;
  String catg;

  factory Postsmodel.fromJson(Map<String, dynamic> json) => Postsmodel(
        id: json["id"],
        img: json["img"],
        title: json["title"],
        desc: json["desc"],
        price: json["price"],
        size: json["size"],
        time: DateTime.parse(json["time"]),
        catg: json["catg"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
        "title": title,
        "desc": desc,
        "price": price,
        "size": size,
        "time": time.toIso8601String(),
        "catg": catg,
      };
}
