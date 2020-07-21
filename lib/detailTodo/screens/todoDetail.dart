import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/detailTodo/bloc/tododetail_bloc.dart';
import 'package:todolist/model/todo.dart';

class TodoDetail extends StatelessWidget {
  final Todo todo;

  const TodoDetail({Key key, this.todo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: BlocProvider(
        create: (_) => TododetailBloc()..add(TododetailLoadingEvent()),
        child: BlocBuilder<TododetailBloc, TododetailState>(
          builder: (context, state) {
            if (state is TododetailInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TodoDetailError) {
              return Text("OOPS ! tanu No Internet.");
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text("Note  :"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          todo.note.toString(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text("Task  :"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          todo.task.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
