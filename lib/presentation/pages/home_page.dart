import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:todo_work_test_app/core/style/style_text.dart';
import 'package:todo_work_test_app/presentation/blocs/todo/todo_bloc.dart';
import 'package:todo_work_test_app/presentation/pages/add_todo_page.dart';
import 'package:todo_work_test_app/presentation/pages/components/todo_item.dart';
import 'package:todo_work_test_app/presentation/pages/detail_todo_page.dart';

class HomePage extends StatefulWidget {
  static const String homePage = "home_page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoBloc>(context).add(OnGetTodoList());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<TodoBloc>(context).add(OnGetTodoList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title:  Text("My Todo", style: h2Bold(),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.app_badge),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.bell_fill,
            ),
          )
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TodoFailed) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is TodoLoaded) {
            if (state.todos.isEmpty){
              return Center(child: Text("Add your todo click +", style: b1Bold(),));
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Remaining task (${state.todos.length})",
                      style: h4Medium(),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.todos.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            DetailTodoPage.detailTodoPage,
                            arguments: state.todos[index],
                          );
                        },
                        child: TodoItem(todo: state.todos[index]),
                      );
                    },
                  )
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade600,
        onPressed: () {
          Navigator.pushNamed(context, AddTodoPage.addTodoPage);
        },
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
