part of 'bloc_data_bloc.dart';

@immutable
abstract class BlocDataEvent {}

class AddDatanote extends BlocDataEvent {
  String title;
  String desc;
  String time;
  String date;

 
  AddDatanote({required this.title, required this.desc , required this.date, required this.time});
}

class getInitialDataEvent extends BlocDataEvent{

}

class DeletEvent extends BlocDataEvent {
  int id;
  DeletEvent({required this.id});
}

class UpdateEvent extends BlocDataEvent {
  Map<String, dynamic> updataData;
  int index;
  UpdateEvent({required this.updataData, required this.index});
}
