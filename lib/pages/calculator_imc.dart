import 'package:calculadora_imc_flutter/pages/calculator_imc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widgets/result_imc.dart';

class CalculatorImc extends StatefulWidget {
  const CalculatorImc({super.key});

  @override
  State<CalculatorImc> createState() => _CalculatorImcState();
}

class _CalculatorImcState extends State<CalculatorImc> {

  var altura = TextEditingController(text: "");
  var peso = TextEditingController(text: "");

  var imc;
  String classificacao = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Calculadora Imc'), centerTitle: true),
        body: Form(
      child: Column(
        children: [
          const Text('Calcule o seu imc'),
          Column(
            children: [
              const Text('Sua altura'),
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
              Container(child: const Text('Seu peso')),
              TextFormField(
                controller: peso,
                onChanged: (value){
                  debugPrint(value);
                },
              )
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              if(altura.text.isNotEmpty && peso.text.isNotEmpty ){
                calculeImc();
                classificacaoImc();
                resultImc(context, imc, classificacao);
              }else{
                if(altura.text.isEmpty && peso.text.isNotEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Informe a altura")));
                  return;
                }
                
                if(peso.text.isEmpty && altura.text.isNotEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Informe o peso")));
                return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Informe o peso e altura")));
                return;
              }
            }, 

          child: Text('Calcular')
          )
        ],
      ),
    )
      )
    );

    
  }

  void calculeImc(){
    setState(() {
      imc = (double.parse(peso.text) / (double.parse(altura.text) * double.parse(altura.text))).toStringAsFixed(2);
      imc = double.parse(imc);
    });
  }

  String classificacaoImc(){
    if(imc < 16){
      classificacao = "Magreza extrema";
    }else if(imc >= 16 && imc < 17){
      classificacao = "Magreza moderada";
    }else if(imc >= 17 && imc < 18.5){
      classificacao = "Magreza leve";
    }else if(imc >= 18.5&& imc < 25){
      classificacao = "Saudável";
    }else if(imc >= 25 && imc < 30){
      classificacao = "Sobrepeso";
    }else if(imc >= 30 && imc < 35){
      classificacao = "Obesidade grau I";
    }else if(imc >= 35 && imc < 40){
      classificacao = "Obesidade grau II(severa)";
    }else{
      classificacao = "Obesidade grau III(mórbida)";
    }
    return classificacao;
  }

}
