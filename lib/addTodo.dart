import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/todos_bloc.dart';
import 'package:todolist/model/todo.dart';

class AddTodoForm extends StatelessWidget {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // if (state is TodosLoadSuccessState) {
        //   Navigator.pop(context);
        // }
        if (state is TodoInsertFailure) {
          print("failure");
        }
        if (state is TodoInsertedSucessfully) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
          });
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Add Sample"),
          ),
          body: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AddTodoTextField(
                      controller: _titleController,
                      title: "Title",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AddTodoTextField(
                      controller: _descController,
                      title: "Description",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: RaisedButton(
                        color: Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        onPressed: () {
                          context.bloc<TodosBloc>().add(
                                TodoAdded(
                                  todo: Todo(
                                    complete: false,
                                    desc: _descController.text,
                                    title: _titleController.text,
                                  ),
                                ),
                              );
                        },
                        child: Text("Submit"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AddTodoTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const AddTodoTextField({Key key, this.title, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
