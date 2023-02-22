
import 'package:flutter_bloc/flutter_bloc.dart';

class SBlocObserver extends BlocObserver{
  @override
  void onTransition(Bloc bloc,Transition transition){
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(change);
  }
 /* void onError(Bloc bloc ,Object error,StackTrace stackTrace)async{
     super.onError(bloc, error, stackTrace);
    print(error);*/
  }
