import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todowithmvc/controller/date_time_controller.dart';
import 'package:todowithmvc/controller/filter_tasks_controller.dart';
import 'package:todowithmvc/controller/todo_task_controller.dart';
import 'package:todowithmvc/model/todo_model.dart';
import 'package:todowithmvc/services/notification_service.dart';
import 'package:todowithmvc/utils/export.dart';
import 'package:todowithmvc/utils/widgets/date_time_picker.dart';
import 'package:todowithmvc/utils/widgets/messenger.dart';

import 'package:todowithmvc/utils/widgets/text_field.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    timeController.dispose();
    timeController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoState = ref.watch(todoProvider);
    final todoList = todoState.tasks;
    final isLoad = todoState.isLoad;
    List<ToDoModel> inCompleteTasks = [];
    List<ToDoModel> completedTasks = [];
    if (!isLoad) {
      inCompleteTasks = filterIncompleteTasks(todoList);
      completedTasks = filterCompletedTasks(todoList);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
      ),
      body: isLoad
          ? const CircularProgressIndicator()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppConstant.kBkLight,
                          borderRadius: BorderRadius.circular(18.r)),
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (inCompleteTasks.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 150.h, horizontal: 90.w),
                                child: Text(
                                  'No tasks created',
                                  style: TextStyle(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              );
                            } else {
                              return Dismissible(
                                  key: Key(todoList[index].id.toString()),
                                  background: Container(
                                    color: AppConstant.kRed,
                                    child: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.delete)),
                                  ),
                                  onDismissed: (direction) {
                                    ref.read(todoProvider.notifier).deleteTodo(
                                        todoList[index].id!.toInt());
                                  },
                                  child: TodoTile(
                                    tasks: inCompleteTasks[index],
                                  ));
                            }
                          },
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Divider(
                                color: AppConstant.kGreyLight,
                                thickness: 1.h,
                              ),
                            );
                          },
                          itemCount: inCompleteTasks.isEmpty
                              ? 1
                              : inCompleteTasks.length),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'Completed',
                    style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: AppConstant.kBlueLight),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppConstant.kBkLight,
                          borderRadius: BorderRadius.circular(18.r)),
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (completedTasks.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 150.h, horizontal: 80.w),
                                child: Text(
                                  'No tasks Completed',
                                  style: TextStyle(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              );
                            } else {
                              return Dismissible(
                                  key: Key(todoList[index].id.toString()),
                                  background: Container(
                                    color: AppConstant.kRed,
                                    child: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.delete)),
                                  ),
                                  onDismissed: (direction) {
                                    ref.read(todoProvider.notifier).deleteTodo(
                                        todoList[index].id!.toInt());
                                  },
                                  child:
                                      TodoTile(tasks: completedTasks[index]));
                            }
                          },
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Divider(
                                color: AppConstant.kGreyLight,
                                thickness: 1.h,
                              ),
                            );
                          },
                          itemCount: completedTasks.isEmpty
                              ? 1
                              : completedTasks.length),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: addTodoBotton(
        addFunction: () {
          showModalBottomSheet(
            isScrollControlled: true,
            showDragHandle: true,
            useSafeArea: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 10.w,
                    right: 10.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ADD TODO',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Divider(
                          height: 10.h,
                          thickness: 1.h,
                          color: AppConstant.kBKDark,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      customTextField(
                        hintText: 'Enter Title',
                        labelText: 'Enter Title',
                        controller: titleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'title is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 170.w,
                            child: customTextField(
                              textInputType: TextInputType.datetime,
                              readOnly: true,
                              hintText: 'select date',
                              labelText: 'Date',
                              controller: dateController,
                              icon: IconButton(
                                  onPressed: () {
                                    datePicker(context).then((value) {
                                      setState(() {
                                        dateController.text = value.toString();
                                      });
                                    });
                                  },
                                  icon: const Icon(
                                      Icons.calendar_today_outlined)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'date is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          SizedBox(
                            width: 170.w,
                            child: customTextField(
                              readOnly: true,
                              hintText: 'select time',
                              labelText: 'Time',
                              controller: timeController,
                              icon: IconButton(
                                  onPressed: () {
                                    timePicker(context).then((value) {
                                      setState(() {
                                        timeController.text =
                                            '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
                                      });
                                    });
                                  },
                                  icon: const Icon(Icons.access_time)),
                              validator: (value) {
                                if (value == '00 : 00' || value!.isEmpty) {
                                  return 'time is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            final todo = ToDoModel(
                              title: titleController.text,
                              isCompleted: 0,
                              date: dateController.text,
                              time: timeController.text,
                            );
                            if (formKey.currentState!.validate()) {
                              ref.read(todoProvider.notifier).addTodo(todo);
                              NotificationService().displayNotification(
                                  title: 'Reminder',
                                  body: titleController.text,
                                  scheduledDate: ref
                                      .read(dateTimeConverterProvider)
                                      .stringToDateTime(
                                          '${dateController.text.padLeft(2, '0')} ${timeController.text.padLeft(2, '0')}'));

                              titleController.clear();
                              timeController.clear();
                              dateController.clear();
                              Navigator.pop(context);
                              CustomSnackBar.showSuccessSnackBar(
                                  context, 'Todo added...');
                            }
                          },
                          child: const Text('Add'))
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
