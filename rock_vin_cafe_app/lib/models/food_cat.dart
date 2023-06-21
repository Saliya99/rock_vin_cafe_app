class CategoryModel {
  String cateId;
  String cateName;
  String cateDesc;
  DateTime createdAt;
  DateTime updatedAt;

  CategoryModel({
    required this.cateId,
    required this.cateName,
    required this.cateDesc,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      cateId: map['cate_id'] as String,
      cateName: map['cate_name'] as String,
      cateDesc: map['cate_desc'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cate_id': cateId,
      'cate_name': cateName,
      'cate_desc': cateDesc,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  List<dynamic> dataToList() {
    return [
      cateId,
      cateName,
      cateDesc,
      createdAt,
      updatedAt,
    ];
  }

  String tableColumns() {
    return 'cate_id, cate_name, cate_desc, createdAt, updatedAt';
  }
}
