class FAQDataModel {
  int? id;
  String? question;
  String? answer;
  int? stateId;
  var typeId;
  bool isSelected=false;
  String? createdOn;
  int? createdById;

  FAQDataModel(
      {this.id,
        this.question,
        this.answer,
        this.stateId,
        this.typeId,
        this.isSelected=false,
        this.createdOn,
        this.createdById});

  FAQDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}
