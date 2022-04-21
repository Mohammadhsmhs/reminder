import 'dart:convert';

import 'package:reminder/core/constants/constants.dart';
import 'package:reminder/core/error/exceptions.dart';

import 'package:reminder/features/events/domain/entities/event_entity.dart';
import 'package:http/http.dart' as http;
import 'package:reminder/features/login/presentation/GetX/login_controller.dart';

import '../models/event_model.dart';

abstract class EventRemoteDataSource {
  Future<EventModel> createEvent(EventEntity eventEntity);
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final http.Client client;
  final LoginController profileInfo;

  const EventRemoteDataSourceImpl(this.client, this.profileInfo);
  @override
  Future<EventModel> createEvent(EventEntity eventEntity) async {
    final _eventModel = EventModel(
        name: eventEntity.name, start: eventEntity.start, end: eventEntity.end);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${profileInfo.token}'
    };
    var request = http.Request(
        'POST', Uri.parse('${Constants.constantUrl}/v1/calendar/create'));
    request.body = json.encode(_eventModel.toJson());
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var temp = await response.stream.bytesToString();

      return EventModel.fromJson(json.decode(temp));
    } else {
      throw ServerException();
    }
  }
}
