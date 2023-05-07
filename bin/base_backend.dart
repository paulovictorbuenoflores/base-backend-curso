import 'package:commons_core/commons_core.dart';

import 'core/database/database_mysql_adapter.dart';

//CURSO
void main(List<String> arguments) async {
  // DependencyInjector di = DependencyInjector();
  //var result = await CustomEnv.get<String>(key: 'chave');//le o arquivo .env que vai ter informacoes sencieveis
  //print(result);
  print("|${await CustomEnv.get<String>(key: 'host')}|");
  print(await CustomEnv.get<int>(key: 'port'));
  print(await CustomEnv.get<String>(key: 'user'));
  print(await CustomEnv.get<String>(key: 'db'));
  print(await CustomEnv.get<String>(key: 'password'));
  print(await DatabaseMySqlAdapter().query('SELECT * FROM tb_permissoes'));

  /* await serve(
      (Request req) => Response(200,
          body: 'Olá mundo', headers: {'content-type': 'application/json'}),
      'localhost',
      8081);*/
}
