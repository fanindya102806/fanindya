class SiswaModel {
  final int id;
  final String name;
  final String gender;
  final String birth;
  final String religion;
  final String address;

  SiswaModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.birth,
    required this.religion,
    required this.address,
  });

  factory SiswaModel.fromJson(Map<String, dynamic> json) {
    // Add null checks and default values if necessary
    return SiswaModel(
      id: json['id'] ?? 0, // Default to 0 if id is not present
      name: json['name'] ?? '', // Default to empty string if name is not present
      gender: json['gender'] ?? '',
      birth: json['birth'] ?? '',
      religion: json['religion'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'gender': gender,
    'birth': birth,
    'religion': religion,
    'address': address,
  };
}
