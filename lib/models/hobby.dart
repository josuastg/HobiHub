class Hobby {
  final String imageUrl;
  final String title;

  Hobby({required this.imageUrl, required this.title});

  factory Hobby.fromJson(Map<String, dynamic> json) {
    return Hobby(imageUrl: json['groupProfileImage'], title: json['groupName']);
  }
}
