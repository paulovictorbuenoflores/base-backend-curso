import 'package:base_backend/base_backend.dart' as base_backend;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:mysql1/mysql1.dart';

import 'package:commons_core/commons_core.dart';

//CURSO
Future<void> main(List<String> arguments) async {
  // DependencyInjector di = DependencyInjector();
  //var result = await CustomEnv.get<String>(key: 'chave');//le o arquivo .env que vai ter informacoes sencieveis
  //print(result);

  final conn = await MySqlConnection.connect(
    ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'delivery',
      password: 'root',
    ),
  );

  await conn
      .query("insert into tb_permissoes(nome, status) values ('ADMIN','A')");

  print(await conn.query('SELECT * FROM tb_permissoes'));

  /* await serve(
      (Request req) => Response(200,
          body: 'Olá mundo', headers: {'content-type': 'application/json'}),
      'localhost',
      8081);*/
}
