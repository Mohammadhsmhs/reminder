import 'package:dartz/dartz.dart';
import 'package:reminder/core/error/failure.dart';
import 'package:reminder/features/events/domain/entities/event_entity.dart';

abstract class EventRepository {
  Future<Either<Failure, bool>> createEvent(EventEntity eventEntity);
}
