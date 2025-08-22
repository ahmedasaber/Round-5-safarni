class ToursEntity {
  final int id;
  final int categoryId;
  final String title;
  final String location;
  final String description;
  final double price;
  final String image;
  final int views;
  final bool isRecommended;
  final double rating;

  const ToursEntity({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.location,
    required this.description,
    required this.price,
    required this.image,
    required this.views,
    required this.isRecommended,
    required this.rating,
  });
}
