import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CalculatorImc extends StatefulWidget {
  const CalculatorImc({super.key});

  @override
  State<CalculatorImc> createState() => _CalculatorImcState();
}

class _CalculatorImcState extends State<CalculatorImc> {
  
    var altura = TextEditingController(text: "");
    var peso = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Text('Calcule o seu imc'),
          Column(
            children: [
              Container(child: Text('Sua altura')),
              TextFormField(
                controller: altura,
                onChanged: (value){
                  debugPrint(value);
                },
              )
            ],
          ),
          Column(
            children: [
              Container(child: Text('Seu peso')),
              TextFormField(
                controller: peso,
                onChanged: (value){
                  debugPrint(value);
                },
              )
            ],
          ),
          ElevatedButton(onPressed: (){}, 
          child: Text('Calcular')
          )
        ],
      ),
    );
  }
}