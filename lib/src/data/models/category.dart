import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Category extends Equatable {
  final String name;
  String? id;

  Category({
    required this.name,
    this.id,
  });

  factory Category.fromMap(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  @override
  List<Object?> get props => [name];
}
