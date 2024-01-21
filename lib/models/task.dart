import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
  });

  @HiveField(0) //ID
  final String id;
  @HiveField(1) //TITLE
  String title;
  @HiveField(2) //SUBTITLE
  String subtitle;
  @HiveField(3) //CREATED AT TIME
  String createdAtTime;
  @HiveField(4) //CREATED AT DATE
  String createdAtDate;
  @HiveField(5) //IS COMPLETED
  bool isCompleted;
  //CREATE A NEW TASK
  factory Task.create({
    required String? title,
    required String? subtitle,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
  }) =>
      Task(
        id: const Uuid().v1(),
        title: title ?? "",
        subtitle: subtitle ?? "",
        createdAtTime: (createdAtTime ?? DateTime.now()).toIso8601String(),
        createdAtDate: (createdAtDate ?? DateTime.now()).toIso8601String(),
        isCompleted: false,
      );
}
