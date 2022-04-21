import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:reminder/features/login/presentation/GetX/login_controller.dart';
import 'package:reminder/features/login/presentation/widgets/send_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const route = '/login';

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.find();
    final textEditingController = TextEditingController();
    final _devSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Text(
                'لطفا شماره همراه خود را وارد کنید',
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
              decoration: BoxDecoration(
                  color: const Color.fromARGB(20, 0, 187, 212),
                  border: Border.all(color: Colors.cyan),
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: textEditingController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black26),
                    hintText: ' مثال : 09361234545',
                    border: InputBorder.none),
              ),
            ),
            SendButton(
                function: () =>
                    _loginController.sendPhone(textEditingController.text)),
          ],
        ),
      ),
    );
  }
}
