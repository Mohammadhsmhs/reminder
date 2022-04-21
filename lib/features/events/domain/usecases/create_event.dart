import 'package:reminder/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:reminder/core/usecase/usecase.dart';
import 'package:reminder/features/events/domain/entities/event_entity.dart';
import 'package:reminder/features/events/domain/repositories/event_repository.dart';

class CreateEvent implements UseCase<bool, EventEntity> {
  final EventRepository eventRepository;

  const CreateEvent(this.eventRepository);

  @override
  Future<Either<Failure, bool>> call(EventEntity event) async {
    return await eventRepository.createEvent(event);
  }
}
