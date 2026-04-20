class President {
  final int id;
  final String name;
  final String lastName;
  final String startPeriodDate;
  final String endPeriodDate;
  final String description;
  final String image;

  President({
    required this.id,
    required this.name,
    required this.lastName,
    required this.startPeriodDate,
    required this.endPeriodDate,
    required this.description,
    required this.image,
  });

  factory President.fromJson(Map<String, dynamic> json) {
    return President(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      lastName: json['lastName'] ?? '',
      startPeriodDate: json['startPeriodDate'] ?? '',
      endPeriodDate: json['endPeriodDate'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'startPeriodDate': startPeriodDate,
      'endPeriodDate': endPeriodDate,
      'description': description,
      'image': image,
    };
  }
}
