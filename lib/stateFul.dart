import 'package:flutter/material.dart';
import 'main.dart';

class todoApp extends StatefulWidget {
  const todoApp({Key? key}) : super(key: key);

  @override
  State<todoApp> createState() => _todoAppState();
}

class _todoAppState extends State<todoApp> {
  final List<Todo> _todoList = <Todo>[];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: _todoList.map((Todo todo) {
          return TodoItem(
            todo: todo,
            onTodoChanged: _changeTodo,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayList(),
          tooltip: 'Add Item',
          focusColor: Colors.green,
          // hoverColor: Colors.blue,
          foregroundColor: Colors.yellow,
          backgroundColor: Colors.black,
          mouseCursor: SystemMouseCursors.text,
          child: Icon(Icons.add)),
    );
  }

  void _changeTodo(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  void _addTodoItem(String name) {
    setState(() {
      _todoList.add(Todo(
        name: name,
        checked: false,
      ));
    });
    _controller.clear();
  }

  Future<void> _displayList() async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // contentPadding: ,
          backgroundColor: Color.fromARGB(255, 255, 247, 0),
          title: const Text(
            'Add a new todo item',
            style: TextStyle(color: Colors.black),
          ),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
                hintText: 'Type your new todo', iconColor: Colors.red),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('submit',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_controller.text);
              },
            ),
          ],
        );
      },
    );
  }
}