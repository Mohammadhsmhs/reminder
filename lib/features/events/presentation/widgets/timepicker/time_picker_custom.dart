import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder/features/events/presentation/widgets/timepicker/picker_controller.dart';

class TimePickerCustom extends StatelessWidget {
  const TimePickerCustom(
      {Key? key, this.isHour = false, required this.tag, this.hour})
      : super(key: key);
  final bool isHour;
  final String tag;
  final int? hour;

  @override
  Widget build(BuildContext context) {
    final _devSize = MediaQuery.of(context).size;

    PickerController controller =
        Get.put(PickerController(isHour, selectedHour: hour), tag: tag);
    return Scaffold(
      body: Center(
        child: Container(
          // color: Colors.green,
          width: _devSize.width * .39,
          height: _devSize.height * .04,
          decoration: BoxDecoration(border: Border.all()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    controller.reduceCurrunt();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.blue,
                  )),
              const SizedBox(
                width: 3,
              ),
              Obx(
                () => Text(
                  controller.lastT.value,
                  style:
                      const TextStyle(color: Color.fromARGB(98, 33, 149, 243)),
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Obx(
                () => Text(
                  controller.curruntT.value,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: _devSize.height / _devSize.width * 8),
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Obx(
                () => Text(
                  controller.nextT.value,
                  style:
                      const TextStyle(color: Color.fromARGB(98, 33, 149, 243)),
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              IconButton(
                  onPressed: () {
                    controller.increaseCurrunt();
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
