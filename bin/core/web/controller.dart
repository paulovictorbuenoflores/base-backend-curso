import 'package:commons_core/commons_core.dart';
import 'package:shelf/shelf.dart';

import '../security/security_service.dart';

//api
//seguranca: todas as nossas rotas,  nossos objetos, estão invólucro, dentro, de um objeto chamado de Handler
abstract class Controller {
  //cara que pega o Handler
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity =
        false, // é uma rota segura ou nao? se sim introduza os dois middlewes de seguranca
  });

//cria o Handler
  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    middlewares ??= [];

    if (isSecurity) {
      //se for seguro vai no injector e tenta recuperar uma instancia de um security_service, essa instacia é um contrato e quem vai implementar ela não importa
      var _securityService = DependencyInjector().get<SecurityService>();
      middlewares.addAll([
        _securityService.authorization, //os 2 middlewas de seguranca
        _securityService.verifyJwt,
      ]);
    }
//crio essa pipeline, que é uma sequencia de instrucoes que vao ser realizadas, em cima da nossa rota
    var pipe = Pipeline();
    for (var m in middlewares) {
      //se a seguraca for verdade, entao eu adiciono para essa pipe os meus middlewares de segurança
      pipe = pipe.addMiddleware(m);
    }
//no final adiciono a rota que o usuario informou, e agora ela tem meus middlewares de seguranca
    return pipe.addHandler(router);
  }
}


//agora toda vez que fizer a implementacao do controller obrigatoriamente tenho que fazer a criacao do Handler e devolver um getHandler

