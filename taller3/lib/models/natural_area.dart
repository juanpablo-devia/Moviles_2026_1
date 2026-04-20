class NaturalArea {
  final int id;
  final int? areaGroupId;
  final int? categoryNaturalAreaId;
  final String name;
  final int? departmentId;
  final int? daneCode;
  final double? landArea;
  final double? maritimeArea;
  final Map<String, dynamic>? department;
  final Map<String, dynamic>? categoryNaturalArea;

  NaturalArea({
    required this.id,
    this.areaGroupId,
    this.categoryNaturalAreaId,
    required this.name,
    this.departmentId,
    this.daneCode,
    this.landArea,
    this.maritimeArea,
    this.department,
    this.categoryNaturalArea,
  });

  String get categoryName => categoryNaturalArea?['name'] ?? 'Área natural';

  String? get departmentName => department?['name'];

  factory NaturalArea.fromJson(Map<String, dynamic> json) {
    return NaturalArea(
      id: json['id'] ?? 0,
      areaGroupId: json['areaGroupId'],
      categoryNaturalAreaId: json['categoryNaturalAreaId'],
      name: json['name'] ?? 'Sin nombre',
      departmentId: json['departmentId'],
      daneCode: json['daneCode'],
      landArea: json['landArea']?.toDouble(),
      maritimeArea: json['maritimeArea']?.toDouble(),
      department: json['department'],
      categoryNaturalArea: json['categoryNaturalArea'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'areaGroupId': areaGroupId,
      'categoryNaturalAreaId': categoryNaturalAreaId,
      'name': name,
      'departmentId': departmentId,
      'daneCode': daneCode,
      'landArea': landArea,
      'maritimeArea': maritimeArea,
      'department': department,
      'categoryNaturalArea': categoryNaturalArea,
    };
  }
}
