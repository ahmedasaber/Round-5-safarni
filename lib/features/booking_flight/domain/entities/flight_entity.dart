class FlightEntity {
  final String id;
  final String airline;
  final String from;
  final String to;
  final DateTime departureDate;
  final DateTime returnDate;
  final double price;
  final String departureTime;
  final String arrivalTime;
  final String duration;

  FlightEntity({
    required this.id,
    required this.airline,
    required this.from,
    required this.to,
    required this.departureDate,
    required this.returnDate,
    required this.price,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
  });
}
