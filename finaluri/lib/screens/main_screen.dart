import 'package:finaluri/cubit/todo_cubit.dart';
import 'package:finaluri/data/todo.dart';
import 'package:finaluri/data/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;
  List<bool> _selected = List.generate(TodoCubit.todoCount, (i) => false);

 @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds:1000));
    _animationController!.forward();
    super.initState();
    TodoRepository().fetchTodos();
  }

  @override
  void dispose()
  {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body:
          BlocBuilder<TodoCubit, TodoState>(
            bloc: context.read<TodoCubit>()..fetchTodos(),
            builder: (context, state){
              if(state is TodoLoaded) {
                return Column(
                    children: [
                      SlideTransition(
                        position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero).animate(_animationController!),
                        child: Container(
                          margin: EdgeInsets.only(top: 100, left: 15, right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("TODO APP", style: TextStyle(fontSize: 30)),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(shape: CircleBorder(),
                                      primary: Color(0xFF04a3a3)), child: Icon(Icons.add),
                                  onPressed: () {
                                    _showModals();
                                  }
                                  )
                            ],
                          ),
                        ),
                      ),
                      SlideTransition(position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero).animate(_animationController!),
                          child: Container(
                              width: 400,
                              height: 435,
                              margin: EdgeInsets.only(top: 100),
                              decoration: BoxDecoration(color: Color(0xFF6cb4b1), borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                              child: ListView.builder(
                                itemCount: state.todoList.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () => _editModal(state.todoList[index]),
                                        title: Text(state.todoList[index].todo!),
                                        subtitle: Text(state.todoList[index].description!),
                                        trailing: Wrap(
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Color(state.todoList[index].isDone ? 0xFF00ff00 : 0xFF808080),
                                                  fixedSize: Size(100.0, 20.0),
                                                shape:  CircleBorder()
                                              ),
                                              child:Icon(Icons.done),
                                              onPressed: () {
                                                setState(() {
                                                  context.read<TodoCubit>().updateTodo(state.todoList[index].id!, state.todoList[index].isDone);
                                                });
                                              },
                                            )
                                          ]
                                        )
                                    );
                                  }
                                  )
                          )
                      )
                    ]
                );
              }
              else {
                return Center(child: Text(state is TodoLoadingError ? state.errorMessage : "ASDF"));
              }
            }
            ),
  );
 }

 void _editModal(Todo todo)
 {

   // idController.text = todo.id!.toString();
   // titleController.text = todo.todo!;
   // descController.text = todo.description!;

   showModalBottomSheet(
       context: context,
       builder: (context)
       {
         return
           Container(
               decoration: BoxDecoration(color: Color(0xFF6cb4b1)),
               child: Column(
                   children: [
                     Padding(
                   padding: EdgeInsets.only(top: 15),
                   child:Text(todo.todo!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25))),
                     Padding(
                       padding: EdgeInsets.only(top: 10),
                     child: Text(todo.description!, style: TextStyle(color: Colors.white, fontSize: 15))),

                     Padding(
                       padding: EdgeInsets.all(50),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                   primary: Color(0x33FFFFF),
                                   fixedSize: Size(50.0, 50.0),
                                   shape:  RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(5)
                                   )
                               ),
                               child: Icon(Icons.add),
                               onPressed: () {
                                 context.read<TodoCubit>().updateTodo(todo.id!, todo.isDone);
                                 Navigator.pop(context);
                               },
                             ),
                             ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                 primary: Color(0x33FFFFF),
                                 fixedSize: Size(50.0,50.0),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(5)
                                 )
                               ),
                               child: Icon(Icons.edit),
                               onPressed: () {

                               },
                             ),
                             ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                   primary: Color(0x33FFFFF),
                                   fixedSize: Size(50.0,50.0),
                                   shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(5)
                                   )
                               ),
                               child: Icon(Icons.delete),
                               onPressed: () {
                                 context.read<TodoCubit>().deleteTodo(todo.id!);
                                 Navigator.pop(context);
                               },
                             )
                           ],
                         ),

                     ),
                     Padding(
                         padding: EdgeInsets.only(top:10, left: 150),
                         child:ElevatedButton(
                             style: ElevatedButton.styleFrom(
                                 fixedSize: Size(100.0, 10.0),
                                 primary: Color(0xFFFFFFFF)), child: Text("SUBMIT", style: TextStyle(color: Color(0xFF04a3a3))),
                             onPressed: () {
                               Navigator.pop(context);
                             }
                         )
                     )
                   ]
               )
           );
       });
 }


 void _showModals()
 {
   var idController = TextEditingController();
   var titleController = TextEditingController();
   var descController = TextEditingController();
   showModalBottomSheet(
       context: context,
       builder: (context)
   {
     return
       Container(
        decoration: BoxDecoration(color: Color(0xFF6cb4b1)),
       child: Column(
       children: [
         TextFormField(
           controller: idController,
           keyboardType: TextInputType.number,
           textAlign: TextAlign.center,
           decoration: InputDecoration(
             hintText: 'Please Enter ID',
           ),
         ),
         TextFormField(
           controller: titleController,
           textAlign: TextAlign.center,
           decoration: InputDecoration(
             hintText: 'Please Enter title',
           ),
         ),
         TextFormField(
           controller: descController,
           textAlign: TextAlign.center,
           decoration: InputDecoration(
             hintText: 'Please Enter description',
           ),
         ),
         Padding(
           padding: EdgeInsets.only(top:25, left: 275),
         child:ElevatedButton(
             style: ElevatedButton.styleFrom(
                 fixedSize: Size(100.0, 10.0),
                 primary: Color(0xFFFFFFFF)), child: Text("SUBMIT", style: TextStyle(color: Color(0xFF04a3a3))),
             onPressed: () {
               var todo = Todo(
                 id: int.parse(idController.text),
                 todo: titleController.text,
                 description: descController.text,
                 isDone: false
               );
              context.read<TodoCubit>().addTodo(todo);
              Navigator.pop(context);
             }
         )
         )

       ]
     )
       );
   });
 }
}