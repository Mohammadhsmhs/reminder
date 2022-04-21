import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:reminder/features/events/data/datasources/event_remote_data_source.dart';
import 'package:reminder/features/events/data/repositories/event_repository_impl.dart';
import 'package:reminder/features/events/domain/entities/event_entity.dart';
import 'package:reminder/features/events/domain/repositories/event_repository.dart';
import 'package:reminder/features/events/domain/usecases/create_event.dart';
import 'package:reminder/features/events/presentation/widgets/timepicker/picker_controller.dart';
import 'package:reminder/features/login/presentation/GetX/login_controller.dart';

class AppointmentController extends GetxController {
  late final EventRepository repo;
  late final LoginController _loginController;
  late final EventRemoteDataSource eventRemoteDataSource;

  var time = DateFormat.Hm().format(DateTime.now()).obs;
  var startHour = DateTime.now().hour - 1;
  var mins = DateTime.now().minute;
  List<int> hours = [];
  var position = (60 + DateTime.now().minute).obs;
  @override
  void onInit() {
    _loginController = Get.find();
    eventRemoteDataSource =
        EventRemoteDataSourceImpl(Client(), _loginController);
    repo = EventRepositoryImpl(
        networkInfo: _loginController.netInfo,
        eventRemoteDataSource: eventRemoteDataSource);
    updateTimer();

    for (int i = 0; i < 7; i++) {
      hours.add(startHour + i);
    }
    super.onInit();
  }

  void updateTimer() async {
    Timer.periodic(Duration(seconds: 10), (Timer t) {
      time.value = DateFormat.Hm().format(DateTime.now());
      if (mins != DateTime.now().minute) {
        mins = DateTime.now().minute;

        position.value++;
      }
    });
  }

  void createEvent(String name) {
    final PickerController hourController = Get.find(tag: 'hour');
    final PickerController minController = Get.find(tag: 'mins');
    final PickerController durationController = Get.find(tag: 'duration');
    final time = DateTime.now();
    final start = DateTime(
      time.year,
      time.month,
      time.day,
      int.parse(hourController.curruntT.value),
      int.parse(minController.curruntT.value),
    );
    final end = start
        .add(Duration(minutes: int.parse(durationController.curruntT.value)));

    CreateEvent(repo).call(EventEntity(
        name: name,
        start: start.toUtc().toString(),
        end: end.toUtc().toString()));
  }
}
