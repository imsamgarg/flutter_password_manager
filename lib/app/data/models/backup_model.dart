import 'package:password_manager/app/data/models/password_model.dart';

class Backup {
  int? dateCreated;
  List<Password>? passwords;

  Backup({this.dateCreated, this.passwords});

  Backup.fromJson(dynamic json) {
    dateCreated = json['date_created'];
    if (json['passwords'] != null) {
      passwords = <Password>[];
      json['passwords'].forEach((v) {
        passwords?.add(Password.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date_created'] = dateCreated;
    if (passwords != null) {
      data['passwords'] = passwords?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
