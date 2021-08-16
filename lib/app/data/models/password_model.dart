class Password {
  String? website;
  String? email;
  String? notes;
  List<String>? tagsArray;
  String? password;
  String? r;
  late bool isVisible;
  String? tags;
  int? createdOn;
  int? modifiedOn;

  Password(
      {this.isVisible = true,
      this.website,
      this.email,
      this.notes,
      this.password,
      this.r,
      this.tags,
      this.createdOn,
      this.modifiedOn});

  Password.fromJson(Map<String, dynamic> json) {
    website = json['website'];
    email = json['email'];
    notes = json['notes'];
    password = json['password'];
    r = json['r'];
    isVisible = true;
    tags = json['tags'];
    if (tags != null && tags!.isNotEmpty) {
      tagsArray = tags!.split(',');
    }
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['website'] = website;
    data['email'] = email;
    data['notes'] = notes;
    data['password'] = password;
    data['r'] = r;
    data['tags'] = tags;
    data['created_on'] = createdOn;
    data['modified_on'] = modifiedOn;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
