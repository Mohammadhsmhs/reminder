import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder/features/events/presentation/GetX/appointment_controller.dart';
import 'package:reminder/features/events/presentation/widgets/timepicker/time_picker_custom.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({Key? key, required this.hour}) : super(key: key);
  final int hour;

  @override
  Widget build(BuildContext context) {
    final _devSize = MediaQuery.of(context).size;
    final _appointmentController = Get.put(AppointmentController());
    var textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: const Text(
            'رویداد جدید',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 5,
          actions: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ]),
      body: ListView(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: _devSize.height * .05),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15)),
              width: _devSize.width * .9,
              height: _devSize.height * .13,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TitleWidget(devSize: _devSize, text: 'نام رویداد'),
                  SizedBox(
                    height: _devSize.height * .02,
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          // vertical: _devSize.height * .01,
                          horizontal: _devSize.width * .03),
                      height: _devSize.height * .05,
                      width: _devSize.width * .8,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            controller: textEditingController,
                            decoration: const InputDecoration(
                                hintText: "مانند : جشن نوروز",
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: _devSize.width * .9,
              height: _devSize.height * .3,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  TitleWidget(
                    devSize: _devSize,
                    text: 'زمان رویداد',
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Container(
                          width: _devSize.width * .38,
                          height: _devSize.height * .05,
                          padding: EdgeInsets.only(right: _devSize.width * .05),
                          alignment: Alignment.centerRight,
                          child: const Text(
                            'دقیقه',
                          )),
                      SizedBox(
                        width: _devSize.width * .09,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: _devSize.width * .05),
                        alignment: Alignment.centerRight,
                        width: _devSize.width * .38,
                        height: _devSize.height * .05,
                        child: const Text(
                          'ساعت',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: _devSize.width * .39,
                          height: _devSize.height * .05,
                          child: TimePickerCustom(
                            hour: hour,
                            tag: 'hour',
                            isHour: true,
                            key: UniqueKey(),
                          )),
                      SizedBox(
                        width: _devSize.width * .07,
                        child: const Center(child: Text(':')),
                      ),
                      SizedBox(
                        width: _devSize.width * .39,
                        height: _devSize.height * .05,
                        child: TimePickerCustom(
                          tag: 'mins',
                          key: UniqueKey(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _devSize.height * .02,
                  ),
                  TitleWidget(
                    devSize: _devSize,
                    text: '(دقیفه) مدت زمان رویداد',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: _devSize.width * .39,
                          height: _devSize.height * .05,
                          child: TimePickerCustom(
                            tag: 'duration',
                            key: UniqueKey(),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            // color: Colors.amber,
            margin: EdgeInsets.symmetric(
                horizontal: _devSize.width * .05,
                vertical: _devSize.height * .02),
            height: _devSize.height * .07,
            child: ElevatedButton(
              onPressed: () {
                if (textEditingController.text.isNotEmpty) {
                  _appointmentController
                      .createEvent(textEditingController.text);
                  Get.back();
                }
              },
              child: const Text('ثبت'),
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 103, 25, 158)),
            ),
          )
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required Size devSize,
    required this.text,
  })  : _devSize = devSize,
        super(key: key);

  final Size _devSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: _devSize.width * .04),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
