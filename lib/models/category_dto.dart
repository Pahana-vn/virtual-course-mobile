class CategoryDTO {
  final int id;
  final String name;
  final String? description;
  final String? image;

  CategoryDTO({
    required this.id,
    required this.name,
    this.description,
    this.image,
  });

  factory CategoryDTO.fromJson(Map<String, dynamic> json) {
    return CategoryDTO(
      id: json['id'] as int,
      name: json['name'] ?? "",
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
    };
  }
}
