class User {
  String firebaseId;
  String emailId;
  String profileName;
  String profilePic;
  String number;
  int followersCount, commentsCount, followingsCount, postsCount;
  String des, profession;
  String city, webS, facB, youT;

  User();

  User.fromMap(Map map, uid) {
    firebaseId = uid;
    emailId = map["email"] ?? "...@gmail.com";
    profileName = map["name"] ?? "Set from Setting";
    profilePic = map["profilePic"] ?? null;
    followersCount = map["followersCount"] ?? 0;
    commentsCount = map["commentsCount"] ?? 0;
    followingsCount = map["followingsCount"] ?? 0;
    postsCount = map["postsCount"] ?? 0;
    des = map["des"] ?? null;
    city = map["city"] ?? null;
    webS = map["webS"] ?? null;
    facB = map["facB"] ?? null;
    number = map["number"] ?? null;
    youT = map["youT"] ?? null;
    profession = map["profession"] ?? null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["name"] = profileName;
    map["number"] = number;
    map["city"] = city;
    map["profession"] = profession;
    map["des"] = des;
    return map;
  }
}
