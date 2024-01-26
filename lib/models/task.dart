import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
  });

  @HiveField(0) //ID
  final String id;
  @HiveField(1) //TITLE
  String title;
  @HiveField(2) //SUBTITLE
  String subTitle;
  @HiveField(3) //CREATED AT TIME
  DateTime createdAtTime;
  @HiveField(4) //CREATED AT DATE
  DateTime createdAtDate;
  @HiveField(5) //IS COMPLETED
  bool isCompleted;
  //CREATE A NEW TASK
  factory Task.create({
    required String? title,
    required String? subTitle,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
  }) =>
      Task(
        id: const Uuid().v1(),
        title: title ?? "",
        subTitle: subTitle ?? "",
        createdAtTime: (createdAtTime ?? DateTime.now()),
        createdAtDate: (createdAtDate ?? DateTime.now()),
        isCompleted: false,
      );
}
