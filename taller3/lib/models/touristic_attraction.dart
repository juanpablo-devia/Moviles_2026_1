class TouristicAttraction {
  final int id;
  final String name;
  final String description;
  final List<String>? images;
  final double? latitude;
  final double? longitude;
  final int? cityId;
  final Map<String, dynamic>? city;

  TouristicAttraction({
    required this.id,
    required this.name,
    required this.description,
    this.images,
    this.latitude,
    this.longitude,
    this.cityId,
    this.city,
  });

  String? get cityName => city?['name'];

  factory TouristicAttraction.fromJson(Map<String, dynamic> json) {
    return TouristicAttraction(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Sin nombre',
      description: json['description'] ?? 'Sin descripción',
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      latitude: double.tryParse(json['latitude']?.toString() ?? ''),
      longitude: double.tryParse(json['longitude']?.toString() ?? ''),
      cityId: json['cityId'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'images': images,
      'latitude': latitude?.toString(),
      'longitude': longitude?.toString(),
      'cityId': cityId,
      'city': city,
    };
  }
}
