class BookingData {
  final int? roomId;
  final String checkInDate;
  final String checkOutDate;
  final String? note;

  BookingData({
    this.roomId,
    required this.checkInDate,
    required this.checkOutDate,
    this.note,
  });
}

class BookingRequest {
  final int userId;
  final int roomId;
  final String checkInDate;
  final String checkOutDate;
  final int adultsCount;
  final int childrenCount;
  final int infantsCount;
  final String? note;

  BookingRequest({
    required this.userId,
    required this.roomId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adultsCount,
    required this.childrenCount,
    required this.infantsCount,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'room_id': roomId,
      'check_in_date': checkInDate,
      'check_out_date': checkOutDate,
      'adults_count': adultsCount,
      'children_count': childrenCount,
      'infants_count': infantsCount,
      if (note != null && note!.isNotEmpty) 'note': note,
    };
  }
}

class BookingResponse {
  final int status;
  final String message;
  final BookingResponseData data;

  BookingResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      status: json['status'],
      message: json['message'],
      data: BookingResponseData.fromJson(json['data']),
    );
  }
}

class BookingResponseData {
  final int id;
  final int userId;
  final int roomId;
  final String checkInDate;
  final String checkOutDate;
  final int adultsCount;
  final int childrenCount;
  final int infantsCount;
  final String? note;
  final String updatedAt;
  final String createdAt;

  BookingResponseData({
    required this.id,
    required this.userId,
    required this.roomId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adultsCount,
    required this.childrenCount,
    required this.infantsCount,
    this.note,
    required this.updatedAt,
    required this.createdAt,
  });

  factory BookingResponseData.fromJson(Map<String, dynamic> json) {
    return BookingResponseData(
      id: json['id'],
      userId: json['user_id'],
      roomId: json['room_id'],
      checkInDate: json['check_in_date'],
      checkOutDate: json['check_out_date'],
      adultsCount: json['adults_count'],
      childrenCount: json['children_count'],
      infantsCount: json['infants_count'],
      note: json['note'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }
}