import 'package:flutter/material.dart';
class FetchPlayersModel {
  String model;
  int pk;
  Fields fields;

//  FetchPlayersModel({this.model, this.pk, this.fields});
  FetchPlayersModel({this.model, this.pk, this.fields}) {
    this.model = "";
    this.pk = 0;
    this.fields = new Fields();
  }
  FetchPlayersModel.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields =
    json['fields'] != null ? new Fields.fromJson(json['fields']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model;
    data['pk'] = this.pk;
    if (this.fields != null) {
      data['fields'] = this.fields.toJson();
    }
    return data;
  }
}

class Fields {
  String name;
  String points;
  int id;

  Fields({this.name, this.points, this.id}) {
    this.name ="";
    this.points ="";
    this.id = 0;
  }

  Fields.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    points = json['points'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['points'] = this.points;
    data['id'] = this.id;
    return data;
  }
}