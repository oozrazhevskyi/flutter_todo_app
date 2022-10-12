import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_todo_app/todo.model.dart';
import 'package:uuid/uuid.dart';

class TodolistCubit extends Cubit<List<Todo>> {
  TodolistCubit()
      : super([
          Todo(id: const Uuid().v4(), description: "hi there", finished: true),
          Todo(
              id: const Uuid().v4(),
              description: "hello world",
              finished: false)
        ]);

  void addTodo(description) {
    var tempState = state;
    tempState.add(
      Todo(id: const Uuid().v4(), description: description, finished: false),
    );
    emit(List.from(tempState));
  }

  void removeTodo(uuid) {
    var tempState = state;
    tempState.removeWhere((element) => element.id == uuid);
    emit(List.from(tempState));
  }

  void toggleTodo(uuid) {
    var tempState = state;
    var todoTaskIndex = tempState.indexWhere((element) => element.id == uuid);
    tempState[todoTaskIndex].finished ^= true; // a = !a
    emit(List.from(tempState));
  }
}
