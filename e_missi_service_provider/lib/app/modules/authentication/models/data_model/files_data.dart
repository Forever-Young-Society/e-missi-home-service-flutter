
class Files {
  int? id;
  int? createdById;
  int? isApprove;
  String? fileName;
  String? reason;
  String? fileLink;
  var uploadedDoc;
  var uploadedDocFileName;
  bool? showRejectedItem=false;

  Files(
      {this.id,
        this.createdById,
        this.isApprove,
        this.fileName,
        this.reason,
        this.fileLink,
        this.uploadedDoc,
        this.uploadedDocFileName,
        this.showRejectedItem,
      });

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdById = json['created_by_id'];
    isApprove = json['is_approve'];
    fileName = json['file_name'];
    reason = json['reason'];
    fileLink = json['file_link'];
    uploadedDoc = json['uploadedDoc'];
    uploadedDocFileName = json['uploadedDoc'];
    showRejectedItem = json['showRejectedItem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_by_id'] = this.createdById;
    data['is_approve'] = this.isApprove;
    data['file_name'] = this.fileName;
    data['reason'] = this.reason;
    data['file_link'] = this.fileLink;
    data['uploadedDoc'] = this.uploadedDoc;
    data['uploadedDoc'] = this.uploadedDocFileName;
    data['showRejectedItem'] = this.showRejectedItem;
    return data;
  }
}

