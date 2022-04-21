import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:reminder/features/login/presentation/GetX/login_controller.dart';
import 'package:reminder/features/login/presentation/widgets/send_button.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);
  static const route = '/verify';
  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.find();
    final textEditingController1 = TextEditingController();
    final textEditingController2 = TextEditingController();
    final textEditingController3 = TextEditingController();
    final textEditingController4 = TextEditingController();
    final _devSize = MediaQuery.of(context).size;

    String retriveCode() {
      return textEditingController1.text +
          textEditingController2.text +
          textEditingController3.text +
          textEditingController4.text;
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Text(
                'کد چهار رقمی ارسال شده به ${_loginController.phoneNumber} را وارد کنید',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: (_devSize.height / _devSize.width) * 12),
              ),
            ),
            Container(
              height: _devSize.height * .07,
              margin: EdgeInsets.symmetric(
                  horizontal: _devSize.width * .11,
                  vertical: _devSize.height * .03),
              padding: EdgeInsets.symmetric(
                horizontal: _devSize.width * .04,
              ),
              // decoration: BoxDecoration(
              //     color: const Color.fromARGB(20, 0, 187, 212),
              //     border: Border.all(color: Colors.cyan),
              //     borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  OtpField(
                      devSize: _devSize,
                      textEditingController: textEditingController1),
                  OtpField(
                      devSize: _devSize,
                      textEditingController: textEditingController2),
                  OtpField(
                      devSize: _devSize,
                      textEditingController: textEditingController3),
                  OtpField(
                      devSize: _devSize,
                      textEditingController: textEditingController4),
                ],
              ),
            ),
            SendButton(function: () {
              _loginController.verifyCode(retriveCode());
            }),
          ],
        ),
      ),
    );
  }
}

class OtpField extends StatelessWidget {
  const OtpField({
    Key? key,
    required Size devSize,
    required this.textEditingController,
    // required this.isLast,
  })  : _devSize = devSize,
        super(key: key);

  final Size _devSize;
  // final bool isLast;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: _devSize.width * .045,
        ),
        decoration: BoxDecoration(
            color: const Color.fromARGB(20, 0, 187, 212),
            border: Border.all(color: Colors.cyan),
            borderRadius: BorderRadius.circular(15)),
        child: TextFormField(
          textAlign: TextAlign.center,
          controller: textEditingController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (value.length == 1) {
              print(FocusScope.of(context).nextFocus());
            }
          },
          maxLength: 1,
          decoration: const InputDecoration(
              counterText: '',
              hintStyle: TextStyle(color: Colors.black26),
              hintText: '0',
              border: InputBorder.none),
        ),
      ),
    );
  }
}
