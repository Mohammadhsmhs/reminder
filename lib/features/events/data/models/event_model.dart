import 'package:reminder/features/events/domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  const EventModel(
      {String? id,
      required String name,
      required String start,
      required String end})
      : super(name: name, start: start, end: end, id: id);

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      name: json['name'],
      start: json['start'],
      end: json['end'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'start': start,
      'end': end,
    };
  }
}
