import 'package:bloc/bloc.dart';
import 'package:bloc_with_sqflite_example/db_helper.dart';
import 'package:meta/meta.dart';

part 'bloc_data_event.dart';
part 'bloc_data_state.dart';

class BlocDataBloc extends Bloc<BlocDataEvent, BlocDataState> {
  BlocDataBloc() : super(BlocDataState(arrData: [])) {

    on<AddDatanote>((event, emit)async{
      bool check = await MyDbHelepr().AddData( event.title, event.desc,event.date, event.time);
      if(check){
        emit(BlocDataState(arrData: await MyDbHelepr().feacthAllNoteData()));
      }else{
        print("Data Not Added");
      }
    });
    on<getInitialDataEvent>((event, emit)async{
      emit(BlocDataState(arrData: await MyDbHelepr().feacthAllNoteData()));
    });
    
    on<DeletEvent>((event, emit)async{
      bool check = await MyDbHelepr().deletData(event.id);
      if(check){
        emit(BlocDataState(arrData: await MyDbHelepr().feacthAllNoteData()));
      }else{
        print("Data Remove");
      }
    });

    on((event, emit){

    });
  }
}
