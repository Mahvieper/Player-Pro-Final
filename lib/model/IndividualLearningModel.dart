class IndividualLearningModel {
  int id;
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

  IndividualLearningModel(
      {this.id,
        this.playerId,
        this.name,
        this.target,
        this.technical,
        this.physical,
        this.psychology,
        this.social,
        this.tactical,
        this.information,
        this.date});

  IndividualLearningModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    return data;
  }
}