import 'package:calculadora_imc_flutter/model/imc_model.dart';
import 'package:calculadora_imc_flutter/pages/calculator_imc.dart';
import 'package:calculadora_imc_flutter/repository/imc_repository.dart';
import 'package:flutter/material.dart';

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

  ImcRepository _imcRepository = ImcRepository();
  List<ImcModel> _imcs = <ImcModel>[];

  @override
  void initState() {
    _getImcs();
    super.initState();
  }

  Future<void> _getImcs() async {
    _imcs = await _imcRepository.getData();
    setState(() {});
    for(var i = 0; i < _imcs.length; i++){
      print('${_imcs[i].id} ${_imcs[i].weight} ${_imcs[i].height} ${_imcs[i].imc} ${_imcs[i].classification}');
    }
    debugPrint(_imcs[0].classification.toString());
  }

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
                saveImc();
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

          child: Text('Calcular'),
          ),
          SingleChildScrollView(
            child: Container(
              child: SizedBox(
              height: 300,
                  child: ListView.builder(
                    itemCount: _imcs.length,
                    itemBuilder: (BuildContext context, index) {
                      ImcModel _imc = _imcs[index];
                      return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(_imc.id.toString()),
                            Text(_imc.weight.toString()),
                            Text(_imc.height.toString()),
                            Text(_imc.imc.toString()),
                          ],
                        )
                      );
                    }
                  
                  )
              ),
            ),
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

  void  classificacaoImc(){
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
    setState(() {});
  }

  saveImc() async {
    // var imcF = const ImcModel(
    //   weight: double.parse(peso.text),
    //   height: double.parse(altura.text),
    //   imc: imc,
    //   classification: classificacao
    // );

    await _imcRepository.create(
      ImcModel(
      weight: double.parse(peso.text),
      height: double.parse(altura.text),
      imc: imc,
      classification: classificacao
    )
    );
  }



}
