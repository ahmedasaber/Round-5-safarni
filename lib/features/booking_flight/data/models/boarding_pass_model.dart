// data/models/boarding_pass_model.dart

import '../../domain/entities/boarding_pass_entity.dart';

class BoardingPassModel extends BoardingPass {
  BoardingPassModel({
    required super.airline,
    required super.date,
    required super.departureTime,
    required super.departureCode,
    required super.arrivalTime,
    required super.arrivalCode,
    required super.gate,
    required super.seat,
    required super.terminal,
    required super.flightNumber,
    required super.userName,
    required super.userAge,
    required super.userGender,
    required super.userImage,
    required super.qrCodeUrl,
  });

  factory BoardingPassModel.fromJson(Map<String, dynamic> json) {
    return BoardingPassModel(
      airline: json['airline'],
      date: json['date'],
      departureTime: json['departure_time'],
      departureCode: json['departure_code'],
      arrivalTime: json['arrival_time'],
      arrivalCode: json['arrival_code'],
      gate: "8", // ثابت
      seat: json['seat'],
      terminal: "3", // ثابت
      flightNumber: "AC006", // ثابت
      userName: json['user']['name'],
      userAge: json['user']['age'],
      userGender: json['user']['gender'],
      userImage: json['user']['image'],
      qrCodeUrl: json['qr_code_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'airline': airline,
      'date': date,
      'departure_time': departureTime,
      'departure_code': departureCode,
      'arrival_time': arrivalTime,
      'arrival_code': arrivalCode,
      'gate': "8", // ثابت
      'seat': seat,
      'terminal': "3", // ثابت
      'flight_number': "AC006", // ثابت
      'user': {
        'name': userName,
        'age': userAge,
        'gender': userGender,
        'image': userImage,
      },
      'qr_code_url': qrCodeUrl,
    };
  }
}
