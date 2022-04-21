import 'package:reminder/core/network/network_info.dart';
import 'package:reminder/features/events/data/datasources/event_remote_data_source.dart';
import 'package:reminder/features/events/domain/entities/event_entity.dart';
import 'package:reminder/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:reminder/features/events/domain/repositories/event_repository.dart';

import '../../../../core/error/exceptions.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource eventRemoteDataSource;
  final NetworkInfo networkInfo;

  const EventRepositoryImpl({
    required this.eventRemoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, bool>> createEvent(EventEntity eventEntity) async {
    if (await networkInfo.isConnected) {
      try {
        await eventRemoteDataSource.createEvent(eventEntity);
        return const Right(true);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
