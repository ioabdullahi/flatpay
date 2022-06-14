import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List todoItems = [];
  addTodo(String task) {
    if(task.isNotEmpty){
      setState(() {
        todoItems.add(task);
      });
    }
  }
  deleteTodo(int index){
    setState(() {
      todoItems.removeAt(index);
    });
  }
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Todo", style: TextStyle(
          color: Colors.yellow
        ),
        ),
    ),
      body:   ListView.builder(
        itemCount: todoItems.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            title: GestureDetector(
              onTap: (){
                showModalBottomSheet(context: context, builder: (context) => Container(
                  height: 100,
                  padding: EdgeInsets.all(24),
                  child: Text(todoItems[index]),
                ));
              },
                child: Text(todoItems[index])),

             trailing: IconButton(
               onPressed: () {
                 showDialog(
                     context: context,
                     builder: (context) =>
                         Container(
                           padding: EdgeInsets.symmetric(horizontal: 24, vertical: 50),
                           color: Colors.white,
                           height: MediaQuery.of(context).size.height/3,
                             child: Column
                               (
                               children: [
                                 Text("Are You Sure you want to Delete?"),
                                 RaisedButton (
                                   onPressed: () {
                               deleteTodo(index);
                               Navigator.pop(context);
                             },
                                   child: Text("Delete Todo"),
                             ),
                             ])
                         ));
               },
               icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
            ),
             )
          ),
        ),
      ) ,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(context: context, builder: (context) => Container(
              height: 200,
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  TextField(
                    controller: textController,
                    onChanged: (value){
                      print(value);
                      print(textController.text);
                    },
                    decoration: InputDecoration(
                      label: Text("Enter Your Task"),
                      labelStyle: TextStyle(color: Colors.black87, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(onPressed: () {
                    addTodo(textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  }, child: Text("Add Task"))
                ],
              ),
            ));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.black,
        ),
        //body: Center(child: Text('Monday reminder')),
        //  child: ListTile(
               //    Text("Monday Reminder"),
                 //  trailing: Icon(Icons.add),
          );
}
}
