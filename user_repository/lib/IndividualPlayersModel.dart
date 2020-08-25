class IndividualLearningModel {
  String model;
  int pk;
  Fields fields;

  IndividualLearningModel({this.model, this.pk, this.fields}) {
    this.fields = Fields();
  }

  IndividualLearningModel.fromJson(Map<String, dynamic> json) {
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
  int playerId;
  String name;
  String target;
  String technical;
  String physical;
  String psychology;
  String social;
  String tactical;
  String information;
  String date;
  int id;

  Fields(
      {this.playerId,
        this.name,
        this.target,
        this.technical,
        this.physical,
        this.psychology,
        this.social,
        this.tactical,
        this.information,
        this.date,
        this.id}) {
   this.name = "";
   this.target = "";
   this.technical = "";
   this.physical = "";
   this.psychology = "";
   this.social ="";
   this.tactical = "";
   this.information ="";
  }

  Fields.fromJson(Map<String, dynamic> json) {
    playerId = json['playerId'];
    name = json['Name'];
    target = json['Target'];
    technical = json['Technical'];
    physical = json['Physical'];
    psychology = json['Psychology'];
    social = json['Social'];
    tactical = json['Tactical'];
    information = json['Information'];
    date = json['date'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playerId'] = this.playerId;
    data['Name'] = this.name;
    data['Target'] = this.target;
    data['Technical'] = this.technical;
    data['Physical'] = this.physical;
    data['Psychology'] = this.psychology;
    data['Social'] = this.social;
    data['Tactical'] = this.tactical;
    data['Information'] = this.information;
    data['date'] = this.date;
    data['id'] = this.id;
    return data;
  }
}