import 'dart:developer';
import 'package:curso_flutter/extensions/space_ext.dart';
import 'package:curso_flutter/models/task.dart';
import 'package:curso_flutter/utils/app_colors.dart';
import 'package:curso_flutter/utils/app_str.dart';
import 'package:curso_flutter/views/tasks/components/date_time_selection.dart';
import 'package:curso_flutter/views/tasks/components/rep_text_field.dart';
import 'package:curso_flutter/views/tasks/widgets/task_view_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    super.key,
    required this.titleTaskController,
    required this.descripitionTaskController,
    required this.task,
  });

  final TextEditingController? titleTaskController;
  final TextEditingController? descripitionTaskController;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var title;
  var subtitle;
  DateTime? time;
  DateTime? date;

  bool isTaskAlreadyExist() {
    return widget.titleTaskController?.text?.isEmpty != true &&
        widget.descripitionTaskController?.text?.isEmpty != true;
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        ///APP BAR
        appBar: const TaskViewAppBar(),

        ///BODY
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///TOP SIZE TEXT
                _buildTopSizeText(textTheme),

                ///MAIN TASK VIEW ACTIVITY
                _buildMainTaskViewActivity(
                  textTheme,
                  context,
                ),

                ///BOTTON SIDE BUTTONS
                _buildBottomSideButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ///DELETE CURRENT TASK BUTTON
          MaterialButton(
            onPressed: () {
              log('Tarefa apagada');
            },
            minWidth: 150,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            height: 55,
            child: Row(
              children: [
                const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                5.w,
                const Text(
                  AppStr.deleteTask,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          ///ADD NEW TASK BUTTON
          MaterialButton(
            onPressed: () {
              log('Nova tarefa adicionada');
            },
            minWidth: 150,
            color: Color(0xFF2C3037),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            height: 55,
            child: const Text(
              AppStr.addNewTaskButton,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainTaskViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 420,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              AppStr.titleOfTitleTextField,
              style: textTheme.headlineMedium,
            ),
          ),

          ///TITLE TEXT FIELD
          RepTextField(
            controller: widget.titleTaskController,
            onFieldSubmitted: (String inputTitle) {
              title = inputTitle;
            },
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
          ),

          const SizedBox(
            height: 10,
          ),

          ///NOTE TEXT FIELD
          RepTextField(
            controller: widget.descripitionTaskController,
            isForDescripition: true,
            onFieldSubmitted: (String inputSubTitle) {
              subtitle = inputSubTitle;
            },
            onChanged: (String inputSubTitle) {
              subtitle = inputSubTitle;
            },
          ),

          ///TIME SELECTION
          DateTimeSelection(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => SizedBox(
                  height: 280,
                  child: TimePickerWidget(
                    // initDateTime: ,
                    dateFormat: 'HH:mm',
                    onChange: (_, __) {},
                    onConfirm: (dateTime, _) {
                      setState(() {
                        if (widget.task?.createdAtTime == null) {
                          time = dateTime;
                        } else {
                          widget.task!.createdAtTime = dateTime.toString();
                        }
                      });
                    },
                  ),
                ),
              );
            },
            title: AppStr.timeString,
          ),

          ///DATE SELECTION
          DateTimeSelection(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                maxDateTime: DateTime(2030, 4, 5),
                minDateTime: DateTime.now(),
                // Initial DateTime:
                onConfirm: (deteTime, _) {},
              );
            },
            title: AppStr.dateString,
          ),
        ],
      ),
    );
  }

  Widget _buildTopSizeText(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 90,
            child: Divider(
              thickness: 2,
            ),
          ),

          ///LATER ON ACCORDING TOTHE TASK CONDITION WE
          ///WILL DECIDE TO "ADD NEW TASK" OR "UPDATE CURRET TASK"
          RichText(
            text: TextSpan(
              text: isTaskAlreadyExist()
                  ? AppStr.addNewTask
                  : AppStr.updateCurrentTask,
              style: textTheme.titleLarge,
              children: const [
                TextSpan(
                  text: AppStr.taskStrnig,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 90,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
