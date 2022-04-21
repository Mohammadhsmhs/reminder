import 'package:get/get.dart';

class PickerController extends GetxController {
  final _t = [];
  var _curruntT = 1.obs;
  final bool isHour;
  late int j;
  final int? selectedHour;

  PickerController(this.isHour, {this.selectedHour});

  @override
  void onInit() {
    if (isHour) {
      _curruntT.value = selectedHour ?? 1;
      j = 24;
    } else {
      j = 60;
    }

    for (int i = 0; i < j; i++) {
      _t.add(i);
    }
    super.onInit();
  }

  RxString get curruntT {
    return _t[_curruntT.value].toString().obs;
  }

  RxString get nextT {
    return _curruntT.value + 1 > j - 1
        ? "".obs
        : _t[_curruntT.value + 1].toString().obs;
  }

  RxString get lastT {
    return _curruntT.value - 1 < 0
        ? "".obs
        : _t[_curruntT.value - 1].toString().obs;
  }

  void reduceCurrunt() {
    if (_curruntT.value != 0) _curruntT.value--;
  }

  void increaseCurrunt() {
    if (_curruntT.value != j - 1) _curruntT.value++;
  }
}
