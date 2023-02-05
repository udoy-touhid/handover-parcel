class User {
  UserType userType;
  double latitude;
  double longitude;

  User(this.userType, this.latitude, this.longitude);

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['userType'] = userType.name;
    map['latitude'] = latitude;
    map['longitude'] = longitude;

    return map;
  }

  static User toUser(Map<dynamic, dynamic> map) {
    var type = UserType.values.firstWhere((element) => element.name.startsWith(map['userType']));
    var user = User(type, map['latitude'] as double, map['longitude'] as double);

    return user;
  }
}

enum UserType {
  sender,
  receiver,
  driver;
}
