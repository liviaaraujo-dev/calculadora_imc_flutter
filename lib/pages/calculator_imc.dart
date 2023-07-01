import 'package:calculadora_imc_flutter/model/imc_model.dart';
import 'package:calculadora_imc_flutter/repository/imc_repository.dart';
import 'package:calculadora_imc_flutter/shared/utils/util.dart';
import 'package:flutter/material.dart';
import '../shared/widgets/result_imc.dart';

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

  final ImcRepository _imcRepository = ImcRepository();
  List<ImcModel> _imcs = <ImcModel>[];

  @override
  void initState() {
    _getImcs();
    super.initState();
  }

  Future<void> _getImcs() async {
    _imcs = await _imcRepository.getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Calculadora Imc'), centerTitle: true),
        body: SingleChildScrollView(
          child: Form(
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
                  setState(() {
                    imc = calculationImc(peso.text, altura.text);
                    classificacao = classificationImc(imc);
                  });
                  saveImc();
                  resultImc(context, imc, classificacao);
                  _getImcs();
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
            Text('Imcs Calculados'),
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
                              Text(_imc.date.toString()),
                              Text(_imc.classification.toString()),
                              Text(_imc.imc.toString()),
                              Text(_imc.weight.toString() + ' kg'),
                              Text(_imc.height.toString() + ' m'),
                              IconButton(icon: Icon(Icons.recycling), onPressed: (){
                                _imcRepository.delete(int.parse(_imc.id.toString()));
                                _getImcs();
                              },)
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
            ),
        )
      )
    );
  }

  saveImc() async {
    final now = DateTime.now();
    String day = now.day.toString().length == 1 ? '0'+ now.day.toString() : now.day.toString();
    String month = now.month.toString().length == 1 ? '0'+ now.month.toString() : now.month.toString();

    await _imcRepository.create(
      ImcModel(
        weight: double.parse(peso.text),
        height: double.parse(altura.text),
        imc: imc,
        classification: classificacao,
        date: '${day}/${month}/${now.year}'
      )
    );
  }
}
