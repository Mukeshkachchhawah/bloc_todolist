import 'package:bloc_with_sqflite_example/bloc/bloc_data_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController idController = TextEditingController();

  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BlocDataBloc>(context).add(getInitialDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text("ToDo App"),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    dateController.text = DateTime.now().toString();
                    timeController.text = TimeOfDay.now().toString();
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: titleController,
                            decoration: InputDecoration(
                                hintText: "Enter Title",
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: descController,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                hintText: "Enter Desc",
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: timeController,
                            onTap: () async {
                              TimeOfDay? TimePicked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.dial);
                              if (TimePicked != null) {
                                setState(() {
                                  timeController.text =
                                      TimePicked.format(context);
                                });
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "local time",
                                suffixIcon: Icon(Icons.timer_sharp),
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: dateController,
                            onTap: () async {
                              DateTime? datePicked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2021),
                                  lastDate: DateTime(2024));
                              if (datePicked != null) {
                                dateController.text =
                                    DateFormat('YMMD').format(datePicked);
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Year-Month-day",
                                suffixIcon: Icon(Icons.calendar_month),
                                border: OutlineInputBorder()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    titleController.text = "";
                                    descController.text = " ";
                                    Navigator.pop(context);
                                  },
                                  child: Text("cansal")),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<BlocDataBloc>(context)
                                        .add(AddDatanote(
                                            date: dateController.text,
                                            time: timeController.text,
                                            desc: descController.text,
                                            title: titleController.text));
                                    titleController.text = "";
                                    descController.text = " ";
                                  },
                                  child: Text("Save"))
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              icon: Text("Add Taks"))
        ],
      ),
      body: BlocBuilder<BlocDataBloc, BlocDataState>(
        builder: (context, state) {
          var listData = state.arrData;
          return ListView.builder(
            itemCount: listData.length,
            itemBuilder: (context, index) {
              var value = listData[index];
              return ListTile(
                leading: Text("${index + 1}"),
                title: Row(
                  children: [
                    Text("${value['title']}"),
                    SizedBox(
                      width: 20,
                    ),
                    Text("${value['time']}")
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text("${value['desc']}"),
                    SizedBox(
                      width: 20,
                    ),
                    Text("${value['date']}")
                  ],
                ),
                trailing: InkWell(
                    onTap: () {
                      BlocProvider.of<BlocDataBloc>(context)
                          .add(DeletEvent(id: value["Noted_id"]));
                    },
                    child: Icon(Icons.delete)),
              );
            },
          );
        },
      ),
    
    );
  }
}
