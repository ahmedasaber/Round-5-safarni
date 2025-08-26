
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['location'] = this.location;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image'] = this.image;
    data['views'] = this.views;
    data['is_recommended'] = this.isRecommended;
    data['rating'] = this.rating;
    return data;
  }
}
