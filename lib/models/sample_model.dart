import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sample_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Sample extends HiveObject {
  static const int typeId = 1;

  @HiveField(0)
  double id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  String image;

  @HiveField(4)
  double price;

  Sample({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  @override
  String toString() {
    return "$name: $description";
  }
}

class SampleBuilder {
  double? id;
  String? name;
  String? description;
  String? image;
  double? price;

  SampleBuilder({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
  });

  Sample build() {
    return Sample(
      id: id!,
      name: name!,
      description: description!,
      image: image!,
      price: price!,
    );
  }

  SampleBuilder withId(double id) {
    this.id = id;
    return this;
  }

  SampleBuilder withName(String name) {
    this.name = name;
    return this;
  }

  SampleBuilder withDescription(String description) {
    this.description = description;
    return this;
  }

  SampleBuilder withImage(String image) {
    this.image = image;
    return this;
  }

  SampleBuilder withPrice(double price) {
    this.price = price;
    return this;
  }
}
