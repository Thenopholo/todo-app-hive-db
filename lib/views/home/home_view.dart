import 'package:curso_flutter/extensions/space_ext.dart';
import 'package:curso_flutter/models/task.dart';
import 'package:curso_flutter/utils/app_colors.dart';
import 'package:curso_flutter/utils/app_str.dart';
import 'package:curso_flutter/utils/constants.dart';
import 'package:curso_flutter/views/home/components/fab.dart';
import 'package:curso_flutter/views/home/components/home_app_bar.dart';
import 'package:curso_flutter/views/home/components/slider_drawer.dart';
import 'package:curso_flutter/views/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'widgets/task_widged.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
        valueListenable: base.dataStore.box.listenable(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();
          /// FOR SORTING LIST
          tasks.sort((a, b) => a.createdAtTime.compareTo(b.createdAtTime));
          
          return Scaffold(
            backgroundColor: Colors.white,

            //FAB
            floatingActionButton: const Fab(),

            ///BODY
            body: SliderDrawer(
              key: drawerKey,
              isDraggable: false,
              animationDuration: 1000,

              ///DRAWER
              slider: CustomDrawer(),

              appBar: HomeAppBar(
                drawerKey: drawerKey,
              ),

              ///MAIN BODY
              child: _buildHomeBody(
                textTheme,
                base,
                tasks,
              ),
            ),
          );
        });
  }

  Widget _buildHomeBody(
    TextTheme textTheme,
    BaseWidget base,
    List<Task> tasks,
  ) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          ///CUSTOM APP BAR
          Container(
            margin: const EdgeInsets.only(
              top: 60,
            ),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///PROGRESS IDICATOR
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    value: 2 / 3,
                    backgroundColor: Colors.black26,
                    valueColor: AlwaysStoppedAnimation(
                      AppColors.primaryColor,
                    ),
                  ),
                ),

                ///SPACE
                25.w,

                ///TOP LEVEL TASK INFO
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStr.mainTitle,
                      style: textTheme.displayLarge,
                    ),
                    3.h,
                    Text(
                      '2/3 Tarefas',
                      style: textTheme.titleMedium,
                    )
                  ],
                ),
              ],
            ),
          ),

          ///DIVIDER
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 100,
            ),
          ),

          ///TASKS
          SizedBox(
            width: double.infinity,
            height: 443,
            child: tasks.isNotEmpty

                /// TASK LIST NOT EMPTY
                ? ListView.builder(
                    itemCount: tasks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: ((context, index) {
                      /// GET SINGLE TASK FOR SHOWING IN LIST
                      var task = tasks[index];
                      return Dismissible(
                        direction: DismissDirection.horizontal,
                        onDismissed: (_) {
                          base.dataStore.deleteTask(task: task);
                        },
                        background: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.delete_outline,
                              color: Colors.black54,
                            ),
                            8.w,
                            const Text(
                              AppStr.deletedTask,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            )
                          ],
                        ),
                        key: Key(task.id),
                        child: TaskWidget(task: task),
                      );
                    }))

                ///TASK LIST IS EMPTY
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ///LOTTIE ANIMATION
                      FadeIn(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(
                            lottieURL,
                            animate: tasks.isNotEmpty ? false : true,
                          ),
                        ),
                      ),

                      ///SUB TEXT
                      FadeInUp(
                        from: 30,
                        child: const Text(
                          AppStr.doneAllTask,
                        ),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
