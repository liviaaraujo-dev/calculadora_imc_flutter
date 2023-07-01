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
        appBar: AppBar(title: const Text('CALCULADORA IMC', style: TextStyle(fontWeight: FontWeight.w500),), centerTitle: true),
        body: SingleChildScrollView(
          child: Form(
              child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Altura', style: TextStyle(fontSize: 25, color: Color(0xFF525052)),),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 35,
                        child: TextFormField(
                          controller: altura,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            
                          ),
                          onChanged: (value){
                            debugPrint(value);
                          },
                        ),
                      ),
                      Text(' m', style: TextStyle(fontSize: 25, color: Colors.deepPurple),)
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Peso', style: TextStyle(fontSize: 25, color: Color(0xFF525052)),),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 35,
                        child: TextFormField(
                          controller: peso,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            
                          ),
                          onChanged: (value){
                            debugPrint(value);
                          },
                        ),
                      ),
                      Text(' kg', style: TextStyle(fontSize: 25, color: Colors.deepPurple),)
                    ],
                  )
                ],
              ),
            ),
           SizedBox(height: 30,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)
              ),
              onPressed: () async {
                if(altura.text.isNotEmpty && peso.text.isNotEmpty ){
                  setState(() {
                    imc = calculationImc(peso.text, altura.text);
                    classificacao = classificationImc(imc);
                  });
                  saveImc();
                  resultImc(context, imc, classificacao);
                  _getImcs();
                  peso.clear();
                  altura.clear();
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
        
            child: Text('CALCULAR', style: TextStyle(fontSize: 18),),
            ),
            Container(
              margin: EdgeInsets.only(top: 60, bottom: 20),
              child: Text('IMCs calculados', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500))
            ),
             Container(
                child: SizedBox(
                height: 300,
                    child: ListView.builder(
                      itemCount: _imcs.length,
                      itemBuilder: (BuildContext context, index) {
                        ImcModel _imc = _imcs[index];
                        return Container(
                          margin: EdgeInsets.only(left: 10, top: 5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_imc.date.toString(), style: TextStyle(fontSize: 15),),
                                  Text(_imc.classification.toString(),style: TextStyle(fontSize: 15),),
                                  Text(_imc.imc.toString(), style: TextStyle(fontSize: 15),),
                                  Text(_imc.weight.toString() + ' kg', style: TextStyle(fontSize: 15)),
                                  Text(_imc.height.toString() + ' m',style: TextStyle(fontSize: 15)),
                                  IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: (){
                                    _imcRepository.delete(int.parse(_imc.id.toString()));
                                    _getImcs();
                                  },),
                                ],
                              ),
                              Divider(color: Colors.deepPurple,),
                            ],
                          )
                        );
                      }
                    
                    )
                ),
              ),
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
