import 'package:calculadora_imc_flutter/database/db.dart';
import 'package:calculadora_imc_flutter/model/imc_model.dart';

class ImcRepository{

  Future<List<ImcModel>> getData() async {
    var db = await DB().database();

    final List<Map<String, dynamic>> maps = await db.query('imc');

    return List.generate(maps.length, (i) {
      return ImcModel(
        id: maps[i]['id'],
        weight: maps[i]['weight'],
        height: maps[i]['height'],
        imc: maps[i]['imc'],
        classification: maps[i]['classification'],
        date: maps[i]['date']
      );
    });
  }

  Future<void> create(ImcModel imc) async {
    var db = await DB().database();

    db.rawInsert('INSERT INTO imc (weight, height, imc, classification, date) VALUES(?, ?, ?, ?, ?)',
      [imc.weight, imc.height, imc.imc, imc.classification, imc.date]
    );
  }

  Future<void> delete(int id) async {
    var db = await DB().database();

    db.rawInsert('DELETE FROM imc WHERE id = ?',
      [id]
    );
  }

}
