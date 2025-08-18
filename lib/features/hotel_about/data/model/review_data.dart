import 'dart:io';

class ReviewData {
  final String userName;
  final int rating;
  final String reviewText;
  final DateTime date;
  final List<File> images;

  ReviewData({
    required this.userName,
    required this.rating,
    required this.reviewText,
    required this.date,
    required this.images,
  });
}