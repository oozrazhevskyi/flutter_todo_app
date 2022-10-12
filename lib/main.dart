import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/cubit/todolist_cubit.dart';
import 'package:flutter_todo_app/todo.model.dart';

void main() {
  runApp(const Main());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple todo app'),
      ),
      body: Container(),
    );
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodolistCubit(),
      child: MaterialApp(
        title: 'Flutter Todo App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const MainView(),
      ),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Todo App'),
      ),
      body: BlocBuilder<TodolistCubit, List<Todo>>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(8.0),
            children: state.map((todoTask) {
              return ListTile(
                leading: Icon(
                  todoTask.finished
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  size: 24.0,
                ),
                onTap: () {
                  context.read<TodolistCubit>().toggleTodo(todoTask.id);
                },
                trailing: IconButton(
                  onPressed: () {
                    context.read<TodolistCubit>().removeTodo(todoTask.id);
                  },
                  icon: const Icon(Icons.delete),
                ),
                title: Text(
                  todoTask.description,
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialogWithFields(context);
        },
      ),
    );
  }
}

Future<void> showDialogWithFields(context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      var descriptionController = TextEditingController();
      return AlertDialog(
        title: const Text('Add new todo-task'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: descriptionController,
                decoration:
                    const InputDecoration(hintText: 'Description of a task'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              var description = descriptionController.text;
              Navigator.pop(context);
              context.read<TodolistCubit>().addTodo(description);
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
