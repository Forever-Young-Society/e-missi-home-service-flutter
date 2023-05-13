/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

class SubServices {
  var id;
  var title;
  var categoryId;
  var typeId;
  var stateId;
  var createdOn;
  var createdById;
  bool? isSelected = false;
  var combinationCount;

  SubServices(
      {this.id,
      this.title,
      this.categoryId,
      this.typeId,
      this.stateId,
      this.createdOn,
      this.isSelected,
      this.combinationCount,
      this.createdById});

  SubServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['category_id'];
    typeId = json['type_id'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    combinationCount = json['combinationCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category_id'] = this.categoryId;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    data['combinationCount'] = this.combinationCount;
    return data;
  }
}
