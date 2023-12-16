import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todowithmvc/controller/filter_tasks_controller.dart';
import 'package:todowithmvc/controller/todo_task_controller.dart';
import 'package:todowithmvc/model/todo_model.dart';
import 'package:todowithmvc/utils/export.dart';
import 'package:todowithmvc/utils/widgets/messenger.dart';

import 'package:todowithmvc/utils/widgets/text_field.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  TextEditingController titleController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
                      color: AppConstant.kBkLight,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (inCompleteTasks.isEmpty) {
                              return const Center(
                                child: Text('NO TASKS CREATED'),
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
                      color: AppConstant.kBkLight,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (completedTasks.isEmpty) {
                              return const Align(
                                alignment: Alignment.bottomCenter,
                                child: Text('No tasks Completed'),
                              );
                            } else {
                              return TodoTile(tasks: completedTasks[index]);
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
                    Form(
                      key: formKey,
                      child: customTextField(
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
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          final todo = ToDoModel(
                              title: titleController.text, isCompleted: 0);
                          if (formKey.currentState!.validate()) {
                            ref.read(todoProvider.notifier).addTodo(todo);
                            titleController.clear();
                            Navigator.pop(context);
                            CustomSnackBar.showSuccessSnackBar(
                                context, 'Todo added...');
                          }
                        },
                        child: const Text('Add'))
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
