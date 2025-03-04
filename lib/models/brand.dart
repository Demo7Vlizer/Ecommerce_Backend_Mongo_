import 'subcategory.dart';

class Brand {
  final String sId;
  final String name;
  final SubCategory? subcategoryId;

  Brand({
    required this.sId,
    required this.name,
    this.subcategoryId,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      sId: json['_id'] as String,
      name: json['name'] as String,
      subcategoryId: json['subcategoryId'] != null
          ? SubCategory.fromJson(json['subcategoryId'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'name': name,
      'subcategoryId': subcategoryId?.toJson(),
    };
  }
}
