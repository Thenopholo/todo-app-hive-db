import 'package:curso_flutter/extensions/space_ext.dart';
import 'package:curso_flutter/models/task.dart';
import 'package:curso_flutter/utils/app_colors.dart';
import 'package:curso_flutter/utils/app_str.dart';
import 'package:curso_flutter/utils/constants.dart';
import 'package:curso_flutter/views/home/components/fab.dart';
import 'package:curso_flutter/views/home/components/home_app_bar.dart';
import 'package:curso_flutter/views/home/components/slider_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
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
  final List<int> testing = [1];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
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
        child: _buildHomeBody(textTheme),
      ),
    );
  }

  Widget _buildHomeBody(TextTheme textTheme) {
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
            child: testing.isNotEmpty

                /// TASK LIST NOT EMPTY
                ? ListView.builder(
                    itemCount: 1,
                    scrollDirection: Axis.vertical,
                    itemBuilder: ((context, index) {
                      return Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (_) {
                            /// WE WILL REMOVE THE CORRENT TASK FROM DB
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
                          key: Key(
                            index.toString(),
                          ),
                          child: TaskWidget(
                            /// THIS IS ONLY FOR TESTING
                            /// WE WILL USE TASK FROM DB
                            task: Task(
                              id: "1",
                              title: "Home Task",
                              subTitle: "Cleaning room",
                              createdAtTime: DateTime.now(),
                              createdAtDate: DateTime.now(),
                              isCompleted: false,
                            ),
                          ));
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
                            animate: testing.isNotEmpty ? false : true,
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
