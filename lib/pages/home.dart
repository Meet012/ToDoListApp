import 'package:flutter/material.dart';
import 'package:task_manager/services/task.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _searchText ="";
  bool done = false;
  List<Task> tasks = [
    Task(name: "Node js"),
    Task(name: "Django"),
    Task(name: "Flutter")
  ];
  final _addController = TextEditingController();
  final _searchController = TextEditingController();
  Widget lists(int ind){
    
    return ListTile(
              leading: Checkbox(
                value: tasks[ind].done,
                onChanged: (bool? value) {
                  setState(() {
                    tasks[ind].done = value!;
                  });
                },
              ),
              title: Text(tasks[ind].name, style: TextStyle(decoration:(tasks[ind].done?TextDecoration.lineThrough:null), ),),
              trailing: InkWell(
                onTap: (){
                  setState(() {
                    tasks.removeAt(ind);
                  });
                },
                child: Icon(Icons.delete,color: Colors.red[400],),
              )
            );
  }
  Widget addNewTask(){
    return TextField(
      controller: _addController,
      maxLines: 1,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Add New Task',
          suffixIcon:IconButton(
          onPressed: (){
            setState(() {
              if (_addController.text != "") {
                tasks.add(Task(name: _addController.text));
              }
              _addController.text = "";
            });
          },
          icon: Icon(Icons.add),
        )
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "ToDo List",
          style: TextStyle(color: Colors.black),
          ),
        backgroundColor: Colors.orange[400],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: 'Enter the Task',
                suffixIcon: Icon(Icons.search)
              ),
              onChanged: (text){
                setState(() {
                  _searchText=_searchController.text;
                });
              },
            ),
            Divider(height: 20,),
            Text("Task to be Done",style: TextStyle(fontSize: 18)),
            Divider(),
            SizedBox(height: 10,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length+1,
              itemBuilder: (context,index){
                print(tasks.isEmpty);
                if(index<tasks.length && tasks[index].name.contains(_searchText)){
                  return lists(index);
                }
                if(tasks.isEmpty){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("No Task to be Found")
                    ],
                  );
                }
                return Container();
              }
            ),
            Divider(),
            SizedBox(height: 20,),
            addNewTask()
          ],
        ),
      ),
    );
  }
}