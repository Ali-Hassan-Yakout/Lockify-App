class Rfid {
  String uid;
  String userName;
  String details;

  Rfid({
    required this.uid,
    required this.userName,
    required this.details,
  });

  Rfid.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        userName = map['userName'],
        details = map['details'];
}
