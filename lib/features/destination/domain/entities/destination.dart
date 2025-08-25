class Destination {
  final String id;
  final String title;
  final String location;
  final String duration;
  final double rating;
  final int reviewsCount;
  final String description;
  final List<String> images;
  final List<String> topActivities;
  final String bestTimeToVisit;

  Destination({
    required this.id,
    required this.title,
    required this.location,
    required this.duration,
    required this.rating,
    required this.reviewsCount,
    required this.description,
    required this.images,
    required this.topActivities,
    required this.bestTimeToVisit,
  });
}
