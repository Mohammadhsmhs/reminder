import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  const SendButton({Key? key, required this.function}) : super(key: key);
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    final _devSize = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        child: Center(
          child: Text(
            'ارسال',
            style: TextStyle(
                color: Colors.white,
                fontSize: (_devSize.height / _devSize.width) * 13),
          ),
        ),
        width: _devSize.width * .8,
        height: _devSize.height * .08,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onTap: function,
    );
  }
}
