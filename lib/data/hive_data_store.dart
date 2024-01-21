import 'package:curso_flutter/models/task.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';


///ALL THE [CRUD] OPERATION METHODS ARE HERE
class HiveDataStore {
  /// BOX NAME - STRING
  static const boxName = 'taskBox';

  ///OUR CURRENT BOX WITH ALL THE SAVED DATA INSIDE - Box<Task>
  final Box<Task> box = Hive.box<Task>(boxName);

  ///ADD NEW TASK TO BOX
  Future<void> addTask({required Task task}) async {
    await box.put(task.id, task);
  }

  ///SHOW TASK
  Future<Task?> getTask({required String id}) async {
    return box.get(id)!;
  }

  ///UPDATE TASK
  Future<void> updateTask({required Task task}) async {
    await task.save();
  }

  ///DELETE TASK
  Future<void> deleteTask({required Task task}) async {
    await task.delete();
  }

  ///LISTEN TO BOX CHANGES
  ValueListenable<Box<Task>> listentoTask() => box.listenable();

}
