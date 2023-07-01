class ImcModel{
  final int? id;
  final double weight;
  final double height;
  final double imc;
  final String classification;
  final String date;

  const ImcModel( {this.id,
 required this.weight,required this.height, required this.imc, required this.classification, required this.date
  });

  Map<dynamic, dynamic> toMap(){
    return{
      'id': id,
      'weight': weight,
      'height': height,
      'imc': imc,
      'classification': classification,
      'date': date
    };
  }
}
