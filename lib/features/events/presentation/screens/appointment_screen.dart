import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:reminder/features/events/presentation/GetX/appointment_controller.dart';
import 'package:reminder/features/events/presentation/screens/create_event_screen.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppointmentController appointmentController =
        Get.put(AppointmentController());
    final _devSize = MediaQuery.of(context).size;
    final _ratio = _devSize.height / _devSize.width;

    final dividers = List.from(appointmentController.hours);
    dividers.removeLast();
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Center(
            child: Text(
              DateTime.now().toPersianDateStr(showDayStr: true),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Stack(
            children: [
              Container(
                height: _devSize.height * .8,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(_ratio * 5),
                        topRight: Radius.circular(_ratio * 5))),
                margin: EdgeInsets.only(
                  bottom: _devSize.height * .1,
                  right: _devSize.width * .1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: dividers
                      .map(
                        (e) => const Divider(
                          thickness: 3,
                          color: Colors.grey,
                        ),
                      )
                      .toList(),
                ),
              ),
              ...timeLine(_devSize, appointmentController),
              Container(
                height: _devSize.height * .7335,
                width: _devSize.width,
                // decoration: BoxDecoration(
                //     // color: Colors.grey,
                //     border: Border.all(color: Colors.black),
                //     borderRadius: BorderRadius.only(
                //         bottomRight: Radius.circular(_ratio * 5),
                //         topRight: Radius.circular(_ratio * 5))),
                // margin: EdgeInsets.only(
                //     // bottom: _devSize.height * .1,
                //     // right: _devSize.width * .1,
                //     ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: appointmentController.hours
                        .map(
                          (e) => Container(
                            width: _devSize.width,
                            height: _devSize.height * .1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  child: Container(
                                    width: _devSize.width * .9,
                                    height: _devSize.height * .1,
                                  ),
                                  onTap: () {
                                    Get.to(() => CreateEventScreen(
                                          hour: e,
                                        ));
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      right: _devSize.width * .05),
                                  child: Text(
                                    e.toString(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList()),
              )
            ],
          ),
        ),
      ],
    ));
  }

  List<Widget> timeLine(Size _devSize, AppointmentController controller) {
    return [
      Obx(
        () => Positioned(
          top: (((_devSize.height * .8) / 540) * controller.position.value) +
              (((_devSize.height * .8) / 540) * 4),
          // (((.8 / 420) * controller.position.value + .005)),
          width: _devSize.width * .9,
          child: Divider(
            thickness: 4,
            color: Colors.cyan,
          ),
        ),
      ),
      Obx(
        () => Positioned(
          top: _devSize.height * (((.8 / 540) * controller.position.value)),
          width: _devSize.width * .1,
          right: 0,
          child: Container(
            height: _devSize.height * .03,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.blue,
              ),
            ),
            child: FittedBox(child: Text(controller.time.value)),
          ),
        ),
      ),
    ];
  }
}


///





                        //          Container(
                        // width: _devSize.width,
                        // height: _devSize.height * .1,
                        // color: Colors.black12,
                        // child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Container(
                        //           padding: EdgeInsets.only(
                        //               right: _devSize.width * .05),
                        //           child: Text(DateTime.now().hour.toString())),