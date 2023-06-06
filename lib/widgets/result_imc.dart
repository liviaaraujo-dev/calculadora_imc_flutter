import 'package:flutter/material.dart';

Future<void> resultImc(BuildContext context, double imc, String classificacaso) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: SizedBox(
            height: 100,
            width: 200,
            child: Column(
              children: [
                Text(imc.toString()),
                Text(classificacaso.toString())
              ],
            ),
          ),
        );
      });
}
