
class Tour {
  int? id;
  int? categoryId;
  String? title;
  String? location;
  String? description;
  String? price;
  String? image;
  int? views;
  bool? isRecommended;
  double? rating;

  Tour(
      {this.id,
      this.categoryId,
      this.title,
      this.location,
      this.description,
      this.price,
      this.image,
      this.views,
      this.isRecommended,
      this.rating});

  Tour.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    location = json['location'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    views = json['views'];
    isRecommended = json['is_recommended'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['title'] = title;
    data['location'] = location;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['views'] = views;
    data['is_recommended'] = isRecommended;
    data['rating'] = rating;
    return data;
  }
}
