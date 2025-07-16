import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    print('${bloc.runtimeType.toString()} onChange $change');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    print('${bloc.runtimeType.toString()} onClose');
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    print('${bloc.runtimeType.toString()} onCreate');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType.toString()} onChange $error');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    print('${bloc.runtimeType.toString()} onChange $event');
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    // print('${bloc.runtimeType.toString()} onChange $transition');
  }

}