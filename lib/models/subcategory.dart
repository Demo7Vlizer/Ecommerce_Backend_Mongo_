class SubCategory {
  final String sId;
  final String name;

  SubCategory({
    required this.sId,
    required this.name,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      sId: json['_id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'name': name,
    };
  }
}
