import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_work_test_app/domain/entities/todo.dart';
import 'package:todo_work_test_app/presentation/blocs/delete_bloc/delete_todo_bloc.dart';
import 'package:todo_work_test_app/presentation/blocs/update_bloc/update_todo_bloc.dart';
import 'package:todo_work_test_app/presentation/pages/home_page.dart';

// ignore: must_be_immutable
class DetailTodoPage extends StatefulWidget {
  static const String detailTodoPage = "detail_todo_page";
  DetailTodoPage({super.key, required this.todo});

  final Todo todo;

  @override
  State<DetailTodoPage> createState() => _DetailTodoPageState();
}

class _DetailTodoPageState extends State<DetailTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  String iconCategory = "daily";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    iconCategory = widget.todo.category;
    titleController.text = widget.todo.title;
    categoryController.text = widget.todo.category == "daily"
        ? "Daily"
        : widget.todo.category == "task"
            ? "Task"
            : widget.todo.category == "birthday"
                ? "Birthday"
                : "Edukasi";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Todo"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.arrow_left),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("Title"),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: titleController,
                maxLines: 8,
                decoration: InputDecoration(
                    hintText: "type your note....",
                    filled: true,
                    fillColor: Colors.blue.withOpacity(0.2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none)),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownMenu(
                    controller: categoryController,
                    hintText: "Select Category",
                    inputDecorationTheme: InputDecorationTheme(
                        filled: true,
                        fillColor: Colors.blue.withOpacity(0.3),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        )),
                    onSelected: (value) {
                      categoryController.text = value!;
                      setState(() {
                        iconCategory = value;
                      });
                      debugPrint(categoryController.text);
                    },
                    leadingIcon: Hero(
                      tag: iconCategory,
                      child: Icon(
                        iconCategory == "daily"
                            ? Icons.check_circle_outline_rounded
                            : iconCategory == "task"
                                ? Icons.file_copy
                                : iconCategory == "birthday"
                                    ? Icons.cake_rounded
                                    : Icons.school_rounded,
                        color: Colors.blue.shade600,
                        size: 20,
                      ),
                    ),
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: "daily", label: "Daily"),
                      DropdownMenuEntry(value: "task", label: "Task"),
                      DropdownMenuEntry(value: "birthday", label: "Birthday"),
                      DropdownMenuEntry(value: "education", label: "Education"),
                    ],
                  ),
                ],
              ),
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Delete Todo"),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      "Cancel",
                                    )),
                                TextButton(
                                    onPressed: () {
                                      context.read<DeleteBlocBloc>().add(
                                          OnDeleteTodo(
                                              int.parse(widget.todo.id)));
                                      Navigator.pushReplacementNamed(
                                          context, HomePage.homePage);
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ))
                              ],
                            );
                          },
                        );
                      },
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: const Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        DateTime timeNow = DateTime.now();
                        String formattedDate =
                            DateFormat('d MMM').format(timeNow);

                        context.read<UpdateTodoBloc>().add(OnPutTodoList(
                              titleController.text,
                              categoryController.text,
                              formattedDate,
                              widget.todo.id,
                            ));
                        Navigator.pushReplacementNamed(
                            context, HomePage.homePage);
                      },
                      padding: const EdgeInsets.all(16),
                      color: Colors.blue.shade600,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
