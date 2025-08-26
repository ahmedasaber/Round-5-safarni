class Car {
  int? id;
  String? model;
  String? brand;
  String? dailyRate;
  int? seats;
  String? transmission;
  String? fuelType;
  int? hasAc;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  Category? category;

  Car({
    this.id,
    model,
    brand,
    dailyRate,
    seats,
    transmission,
    fuelType,
    hasAc,
    categoryId,
    createdAt,
    updatedAt,
    category,
  });

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'];
    brand = json['brand'];
    dailyRate = json['daily_rate'];
    seats = json['seats'];
    transmission = json['transmission'];
    fuelType = json['fuel_type'];
    hasAc = json['has_ac'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['model'] = model;
    data['brand'] = brand;
    data['daily_rate'] = dailyRate;
    data['seats'] = seats;
    data['transmission'] = transmission;
    data['fuel_type'] = fuelType;
    data['has_ac'] = hasAc;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  Category({this.id, name, description, imageUrl, createdAt, updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image_url'] = imageUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
