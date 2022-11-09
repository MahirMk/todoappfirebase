import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoappfirebase/TodoAdd.dart';
import 'package:todoappfirebase/UpdateToDo.dart';

class ToDoView extends StatefulWidget {

  @override
  State<ToDoView> createState() => _ToDoViewState();
}

class _ToDoViewState extends State<ToDoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do View"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>TodoAdd())
          );
        },
        child: Icon(Icons.add,size: 50,),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("ToDoList").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
            {
              if(snapshot.hasData)
              {
                if(snapshot.data.size<=0)
                {
                  return Center(child: Text("No Data"),);
                }
                else
                {
                  return Column(
                    children: snapshot.data.docs.map((document){
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(
                          child: Container(
                            width: 400,
                            child: Card(
                              elevation: 10,
                              color: Colors.green.shade100,
                              child: Column(
                                children: [
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text("Title : ",style: TextStyle(color: Colors.black87,fontSize: 30),),
                                        Text(document["Title"].toString(),style: TextStyle(color: Colors.red.shade900,fontSize: 30),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height:20,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text("Remark : ",style: TextStyle(color: Colors.black87,fontSize: 30),),
                                        Text(document["Remark"].toString(),style: TextStyle(color: Colors.red.shade900,fontSize: 30),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Date : ",style: TextStyle(color: Colors.black87,fontSize: 25),),
                                          Text(document["Date"].toString(),style: TextStyle(color: Colors.blue.shade900,fontSize: 25),),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          AlertDialog alert = new AlertDialog(
                                            title: Container(child: Text("Warning!",style: TextStyle(color: Colors.white),)),
                                            backgroundColor: Colors.green,
                                            content: Text("Are you sure you want to delete record?",style: TextStyle(color: Colors.white)),
                                            actions: [
                                              TextButton(onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                                child: Text("Cancel",style: TextStyle(color: Colors.white),),
                                              ),
                                              TextButton(onPressed: () async{
                                                var docid = document.id.toString();
                                                await FirebaseFirestore.instance.collection("ToDoList").doc(docid).delete().then((value){
                                                Navigator.of(context).pop();
                                                });
                                              },
                                                child: Text("Delete",style: TextStyle(color: Colors.white),),
                                              ),
                                            ],
                                          );
                                          showDialog(context: context, builder: (BuildContext context){
                                            return alert;
                                          });
                                        },
                                        child: Container(
                                            width: 100,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black,width: 2)
                                            ),
                                            child: Center(child: Text("DELETE",style: TextStyle(color: Colors.pink.shade900,fontSize: 20,fontWeight: FontWeight.bold),))
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: (){
                                            var docid = document.id.toString();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (context)=>UpdateToDo( ))
                                            );
                                          },
                                          child: Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black,width: 2)
                                              ),
                                              child: Center(child: Text("Update",style: TextStyle(color: Colors.pink.shade900,fontSize: 20,fontWeight: FontWeight.bold),))
                                          )
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              }
              else
              {
                return Center(child: CircularProgressIndicator(),);
              }
            }
        ),
      ),
    );
  }
}
