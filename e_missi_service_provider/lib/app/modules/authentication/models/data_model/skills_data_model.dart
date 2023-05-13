class SkillDataModel {
  var id;
 var title;
  var categoryId;
  var parentId;
  var typeId;
  var stateId;
  bool ?isSelected=false;
  List<SubSkillDataModel>? subSkills;

  SkillDataModel({this.id,
    this.title,
    this.categoryId,
    this.parentId,
    this.typeId,
    this.stateId,
    this.isSelected,
    this.subSkills});

  SkillDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['category_id'];
    parentId = json['parent_id'];
    typeId = json['type_id'];
    stateId = json['state_id'];
    if (json['sub_skills'] != null) {
      subSkills = <SubSkillDataModel>[];
      json['sub_skills'].forEach((v) {
        subSkills!.add(new SubSkillDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category_id'] = this.categoryId;
    data['parent_id'] = this.parentId;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;
    if (this.subSkills != null) {
      data['sub_skills'] = this.subSkills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class SubSkillDataModel {
  var id;
 var title;
  var categoryId;
  var parentId;
  var typeId;
  var stateId;
  bool? isSelected=false;


  SubSkillDataModel(
      {this.id,
        this.title,
        this.categoryId,
        this.parentId,
        this.typeId,
        this.stateId,
        this.isSelected,
       });

  SubSkillDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['category_id'];
    parentId = json['parent_id'];
    typeId = json['type_id'];
    stateId = json['state_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category_id'] = this.categoryId;
    data['parent_id'] = this.parentId;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;

    return data;
  }
}
