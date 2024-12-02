class ChangeProfileModel {
  String? originalname;
  String? filename;
  String? location;

  ChangeProfileModel({this.originalname, this.filename, this.location});

  ChangeProfileModel.fromJson(Map<String, dynamic> json) {
    originalname = json['originalname'];
    filename = json['filename'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['originalname'] = this.originalname;
    data['filename'] = this.filename;
    data['location'] = this.location;
    return data;
  }
}
