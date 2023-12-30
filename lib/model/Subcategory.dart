class SubCategory {
  final int id;
  final String subcategoryName;

  SubCategory(this.id, this.subcategoryName);


factory SubCategory.fromJson(Map<String, dynamic> json) {
  return SubCategory(
    json['id'] as int ,
    json['subCategoryName'] as String
  );
}

 
}