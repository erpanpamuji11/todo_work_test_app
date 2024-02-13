import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_work_test_app/core/constants/constants_text.dart';
import 'package:todo_work_test_app/core/style/style_color.dart';
import 'package:todo_work_test_app/core/style/style_text.dart';
import 'package:todo_work_test_app/presentation/blocs/add_todo/add_todo_bloc.dart';
import 'package:todo_work_test_app/presentation/pages/components/show_dialog_loading.dart';
import 'package:todo_work_test_app/presentation/pages/home_page.dart';

// ignore: must_be_immutable
class AddTodoPage extends StatefulWidget {
  static const String addTodoPage = "add_todo_page";
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();

  TextEditingController categoryController = TextEditingController();

  String iconCategory = "daily";

  void submitTodo() {
    if (titleController.text == "" || categoryController.text == "") {
      const snackBar = SnackBar(
        content: Text(ConstantText.formCantEmpty),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    DateTime timeNow = DateTime.now();
    String formattedDate = DateFormat('d MMM').format(timeNow);

    context.read<AddTodoBloc>().add(OnPostTodoList(
          titleController.text,
          categoryController.text,
          formattedDate,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Todo",
          style: h4Bold(),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.chevron_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: titleController,
                maxLines: 8,
                style: b2Bold(),
                decoration: InputDecoration(
                    hintText: ConstantText.typeYourNote,
                    hintStyle: b2Bold(),
                    filled: true,
                    fillColor: Colors.blue.withOpacity(0.2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none)),
              ),
              const Gap(20),
              DropdownMenu(
                width: MediaQuery.of(context).size.width * 0.7,
                controller: categoryController,
                hintText: ConstantText.selectCategoryText,
                textStyle: b2Bold(),
                inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: Colors.blue.withOpacity(0.3),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
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
                  DropdownMenuEntry(
                    value: "daily",
                    label: "Daily",
                  ),
                  DropdownMenuEntry(value: "task", label: "Task"),
                  DropdownMenuEntry(value: "birthday", label: "Birthday"),
                  DropdownMenuEntry(value: "education", label: "Education"),
                ],
              ),
              const Gap(20),
              BlocListener<AddTodoBloc, AddTodoState>(
                listener: (context, state) {
                  if (state is AddTodoLoaded) {}
                  if (state is AddTodoLoading) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return showDialogLoading();
                      },
                    );
                    Future.delayed(const Duration(milliseconds: 500), () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, HomePage.homePage);
                    });
                  }
                  if (state is AddTodoFailed) {
                    const snackBar = SnackBar(
                      content: Text("Add failed"),
                      duration: Duration(seconds: 3),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () => submitTodo(),
                        padding: const EdgeInsets.all(16),
                        color: Colors.blue.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Text(ConstantText.submitText,
                            style: b2Medium(colorText: CustomColor.primary100)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
