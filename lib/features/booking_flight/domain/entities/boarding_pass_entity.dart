// domain/entities/boarding_pass.dart
class BoardingPass {
  final String airline;
  final String date;
  final String departureTime;
  final String departureCode;
  final String arrivalTime;
  final String arrivalCode;
  final String gate;
  final String seat;
  final String terminal;
  final String flightNumber;
  final String userName;
  final int userAge;
  final String userGender;
  final String userImage;
  final String qrCodeUrl;

  BoardingPass({
    required this.airline,
    required this.date,
    required this.departureTime,
    required this.departureCode,
    required this.arrivalTime,
    required this.arrivalCode,
    required this.gate,
    required this.seat,
    required this.terminal,
    required this.flightNumber,
    required this.userName,
    required this.userAge,
    required this.userGender,
    required this.userImage,
    required this.qrCodeUrl,
  });
}
