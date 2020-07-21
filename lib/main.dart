import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/addTodo.dart';
import 'package:todolist/bloc/todos_bloc.dart';
import 'package:todolist/blocObserver.dart';
import 'package:todolist/model/todo.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(
    BlocProvider<TodosBloc>(
      create: (_) => TodosBloc()..add(TodosLoading()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoForm(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Todos').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null ||
              snapshot.data == "" ||
              snapshot.data.documents.length == null) {
            return Text("There is not any TODO for Tanu");
          } else {
            // var listMessage = ;
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) {
                print(snapshot.data.documents[index].data);
                return TodoCard(
                  todo: Todo.fromJson(
                    snapshot.data.documents[index].data,
                  ),
                );
              },
              itemCount: snapshot.data.documents.length,
            );
          }
        },
      ),
    );
  }
}

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard({Key key, this.todo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        child: ListTile(
          title: Text(todo.note.toString()),
          subtitle: Text(
            todo.task.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
