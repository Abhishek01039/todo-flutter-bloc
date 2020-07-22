import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/addTodo.dart';
import 'package:todolist/bloc/todos_bloc.dart';
import 'package:todolist/blocObserver.dart';
import 'package:todolist/detailTodo/bloc/tododetail_bloc.dart';
import 'package:todolist/detailTodo/screens/todoDetail.dart';
import 'package:todolist/locator.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/services/todoService.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  setup();
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
          // BlocProvider.of<TododetailBloc>(context)
          //     .add(TododetailLoadingEvent());
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
                // print(snapshot.data.documents[index].data);
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

class TodoCard extends StatefulWidget {
  final Todo todo;

  const TodoCard({Key key, this.todo}) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  final TodoServices _todoServices = locator<TodoServices>();
  showDialogBox() {
    return showDialog(
      context: context,
      child: AlertDialog(
        title: Text("Are you want to delete the data ? "),
        // content: ,
        actions: [
          RaisedButton(
            onPressed: () {
              _todoServices.deleteData(widget.todo.id).then((value) {
                Navigator.pop(context);
              });
            },
            child: Text("Yes"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("No"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        child: ListTile(
          leading: Checkbox(
            value: widget.todo.complete,
            onChanged: (value) {
              setState(() {
                widget.todo.complete = value;
              });
            },
          ),
          title: Container(
            child: Text(
              widget.todo.title.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Text(
            widget.todo.desc.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TodoDetail(
                  todo: widget.todo,
                ),
              ),
            );
          },
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                  ),
                  onPressed: () {},
                ),
                // SizedBox(
                //   width: 5,
                // ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    showDialogBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
