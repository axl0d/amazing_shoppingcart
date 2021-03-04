import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(checked: true)
class Product {
  final int id;
  final String sku;
  final String name;
  final String description;
  final String image;

  const Product({this.id, this.sku, this.name, this.description, this.image});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
