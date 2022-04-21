import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  final String? id;
  final String name;
  final String start;
  final String end;

  const EventEntity({
    this.id,
    required this.name,
    required this.start,
    required this.end,
  });

  @override
  List<Object?> get props => [
        name,
        start,
        end,
      ];
}
