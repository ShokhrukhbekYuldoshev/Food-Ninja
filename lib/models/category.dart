import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;

  const Category({
    required this.name,
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
