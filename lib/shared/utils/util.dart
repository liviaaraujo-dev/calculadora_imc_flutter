double calculationImc(weight, height){
    dynamic imc = (double.parse(weight) / (double.parse(height) * double.parse(height))).toStringAsFixed(2);
    return double.parse(imc);
}

String  classificationImc(double imc){
  String classification;

  if(imc < 16){
    classification = "Magreza extrema";
  }else if(imc >= 16 && imc < 17){
    classification = "Magreza moderada";
  }else if(imc >= 17 && imc < 18.5){
    classification = "Magreza leve";
  }else if(imc >= 18.5&& imc < 25){
    classification = "Saudável";
  }else if(imc >= 25 && imc < 30){
    classification = "Sobrepeso";
  }else if(imc >= 30 && imc < 35){
    classification = "Obesidade grau I";
  }else if(imc >= 35 && imc < 40){
    classification = "Obesidade grau II(severa)";
  }else{
    classification = "Obesidade grau III(mórbida)";
  }
  return classification;
}
