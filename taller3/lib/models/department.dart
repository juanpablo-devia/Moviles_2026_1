class Department {
  final int id;
  final String name;
  final String description;
  final int population;
  final double surface;
  final int regionId;

  Department({
    required this.id,
    required this.name,
    required this.description,
    required this.population,
    required this.surface,
    required this.regionId,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      population: json['population'] ?? 0,
      surface: (json['surface'] ?? 0.0).toDouble(),
      regionId: json['regionId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'population': population,
      'surface': surface,
      'regionId': regionId,
    };
  }
}
