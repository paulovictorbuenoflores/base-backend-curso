/**
 * crio um contener de injecao de dependencia para evitar de criar e fabricar varios objetos
 * para isso usamos um _sigleton, que cria uma instacia de um objeto que fica alocada do inicio 
 * ao fim da aplicacao
 */
//typedef permite adicionar um determinado nome para um tipo
//typedef T InstanceCreator<T>();
typedef InstanceCreator<T> = T Function();

class DependencyInjector {
  DependencyInjector._();
  static final _singleton = DependencyInjector._();
  factory DependencyInjector() => _singleton;

  //final _instanceMap = Map<Type, _InstanceGenerator<Object>>();
  final _instanceMap = <Type, _InstanceGenerator<Object>>{};

  void register<T extends Object>(
    InstanceCreator<T> instance, {
    bool isSingleton = true,
  }) =>
      _instanceMap[T] = _InstanceGenerator(instance, isSingleton);

  T get<T extends Object>() {
    final instance = _instanceMap[T]?.getInstance();
    if (instance != null && instance is T) return instance;
    throw Exception('[ERROR] -> Instance ${T.toString()} not found');
  }

  call<T extends Object>() => get<T>();
}

class _InstanceGenerator<T> {
  T? _instance;
  bool _isFirstGet = false;

  final InstanceCreator<T> _instanceCreator;
  _InstanceGenerator(this._instanceCreator, bool isSingleton)
      : _isFirstGet = isSingleton;

  T? getInstance() {
    if (_isFirstGet) {
      _instance = _instanceCreator();
      _isFirstGet = false;
    }
    //return _instance != null ? _instance : _instanceCreator();
    return _instance ?? _instanceCreator();
  }
}
