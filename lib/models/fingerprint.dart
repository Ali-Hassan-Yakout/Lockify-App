class Fingerprint {
  int id;
  String userName;
  String details;

  Fingerprint({
    required this.id,
    required this.userName,
    required this.details,
  });

  Fingerprint.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        userName = map['userName'],
        details = map['details'];
}
