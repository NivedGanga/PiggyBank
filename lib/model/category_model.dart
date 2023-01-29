class CategoryModel {
  final String id;
  final String iconHex;
  final String name;
  final String total="0";
  CategoryModel({required this.id, required this.name, required this.iconHex});
  @override
  String toString() {
    return '$name ';
  }
}
