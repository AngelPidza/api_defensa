class Classroom {
  final String id;
  final String title;
  final List<dynamic> childs;
  final List<dynamic> lessons;

  Classroom({
    required this.id,
    required this.title,
    required this.childs,
    required this.lessons,
  });

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      childs: json['childs'] ?? [],
      lessons: json['lessons'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'childs': childs,
      'lessons': lessons,
    };
  }
}
