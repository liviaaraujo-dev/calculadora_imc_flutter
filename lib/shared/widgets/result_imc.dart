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
            height: 200,
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(imc.toString(), style: TextStyle(color: Colors.deepPurple, fontSize: 22, fontWeight: FontWeight.w600),),
                SizedBox(height: 10,),
                Text.rich(
                  TextSpan(
                    text:'Classificação: ',
                  style: TextStyle( fontSize: 20, fontWeight: FontWeight.w500),
                   children: [
                    TextSpan(text: classificacaso.toString(), style: TextStyle(color: Colors.deepPurple, fontSize: 20, fontWeight: FontWeight.w500),),

                  ])
                )
              ],
            ),
          ),
        );
      });
}
