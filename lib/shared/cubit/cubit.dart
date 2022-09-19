

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia_new/shared/cubit/states.dart';

import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() :super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
//   List<Widget>screen = [
//    NewTasksScreen(),
//       DoneTasksScreen(),
//     ArchivedTasksScreen(),
//   ];
//   List<String>appbar = [
//
//     'New Tasks',
//     'Done Tasks',
//     'Archived Tasks',
//   ];
//
//   void changeIndex(int index) {
//     currentIndex = index;
//     emit(AppChangeBottomNabBarState());
//   }
//
//   late Database database;
//   List<Map>Newtasks = [];
//   List<Map>Donetasks = [];
//   List<Map>ArchTasks = [];
//   void createDataBase() {
//     openDatabase(
//       'todo.db',
//       version: 1,
//       onCreate: (database, version) {
//         //id int
//         //title string
//         //date,time,status
//         print('database created');
//         database.execute(
//             'CREATE TABLE tasks(id INTEGER PRIMARY KEY ,title TEXT,date TEXT,time TEXT ,status TEXT)  ')
//             .then((value) {
//           print('Table Created');
//         }).catchError((error) {
//           print('Error When Created Table ${error.toString()}');
//         });
//       },
//       onOpen: (database)
//       {
//         getDataFromDataBase(database);
//
//         print('database opened');
//       },
//     ).then((value) {
//       database = value;
//
//       emit(AppCreateDateBaseState());
//     });
//   }
//
//   Future insertToDataBase(
//       {required String title, required String date, required String time}) async
//   {
//     return await database.transaction((txn) {
//       return txn.rawInsert(
//           'INSERT INTO tasks (title,date,time,status) VALUES("$title","$date","$time","new") ')
//           .then((value) {
//         print('$value insterted successfully');
//         emit(AppInsertDataBaseState());
//
//         getDataFromDataBase(database);
//       }).catchError((error) {
//         print('Error When Inserting New Record ${error.toString()}');
//       });
//     });
//   }
//
// void getDataFromDataBase(database)
// {
//   Newtasks=[];
//   Donetasks=[];
//   ArchTasks=[];
//     emit(AppGetDataBaseLoadingState());
//     database.rawQuery('SELECT * FROM tasks').then((value) {
//
//       value.forEach((element) {
//        if(element['status']=='new')
//        {
//          Newtasks.add(element);
//        }
//        else if(element['status']=='done')
//        {
//          Donetasks.add(element);
//        }
//        else
//          {
//            ArchTasks.add(element);
//          }
//       });
//       emit(AppGetDataBaseState());
//     });
//   }
// void updateData({
//   required String status,
//   required int id,
// })async{
//    database.rawUpdate(
//   'UPDATE Test SET status = ?,  WHERE id = ?',
//   [status, id],
//   ).then((value) {
//    // getDataFromDataBase(database);
//     emit(AppUpdateDataBaseState());
//    });
//
// }
//
//   void deleteDate({
//
//     required int id,
//   })async {
//     database.rawDelete('DELETE FROM Test WHERE id = ?', [id])
//         .then((value) {
//    //   getDataFromDataBase(database);
//       emit(AppDeleteDataBaseState());
//
//     });
//   }
//   bool isBottomSheetShown = false;
//   IconData fabIcon = Icons.edit;
//
//   void changeBottomSheetState({
//     required bool isShow,
//     required IconData icon,
//   }) {
//     isBottomSheetShown = isShow;
//     fabIcon = icon;
//     emit(AppChangeBottomSheetrState());
//   }

  bool isDark=false;
  ThemeMode appMode=ThemeMode.dark;

  void changeAppMode({bool ?fromShared}) {
    if(fromShared!=null)
    {
      isDark=fromShared;
      emit(AppChangeModeState());
    }

    else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark)
          .then((value) {
        emit(AppChangeModeState());
      });
    }

  }
}
