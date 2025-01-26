class Subject {
  final int id;
  final String name;

  Subject({required this.id, required this.name});
}

class Buddy {
  final String name;
  final int id;
  final int? score;
  final List<int> teachingSubjects;
  final List<int> learningSubjects;

  Buddy({
    required this.name,
    required this.id,
    this.score,
    required this.teachingSubjects,
    required this.learningSubjects,
  });

  factory Buddy.fromJson(Map<String, dynamic> json) {
    return Buddy(
      name: json['name'],
      id: json['id'],
      score: json['score'],
      teachingSubjects: List<int>.from(json['teachingSubjects']),
      learningSubjects: List<int>.from(json['learningSubjects']),
    );
  }
}
