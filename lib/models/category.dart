class Category {
  final String categoryId;
  final String name;
  List<SubCategory> subCategory;

  Category({this.categoryId, this.name, this.subCategory});

  factory Category.fromJson(
      Map<String, dynamic> json, ) {
    return Category(
        name: json['category_name'],
        categoryId: json['category_id'],
        // subCategory: List.from(subJson.map((e) => SubCategory(
        //     subCategoryId: e['sub_category_id'],
        //     subCategoryName: e['sub_category_name'])))
        //List<Map<String, dynamic>> subJson
        );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'name': name,
    };
  }
}

class SubCategory {
  final String subCategoryId;
  final String subCategoryName;
  final String subCategoryImage;

  SubCategory({this.subCategoryId, this.subCategoryName,this.subCategoryImage});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      subCategoryImage: json['sub_category_image'],
        subCategoryName: json['sub_category_name'],
        subCategoryId: json['sub_category_id']);
  }
}
