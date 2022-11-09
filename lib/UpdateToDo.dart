import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:simple_animations/stateless_animation/play_animation.dart';

class UpdateToDo extends StatefulWidget {

  @override
  State<UpdateToDo> createState() => _UpdateToDoState();
}

class _UpdateToDoState extends State<UpdateToDo> {

  TextEditingController _title = TextEditingController();
  TextEditingController _remark = TextEditingController();
  TextEditingController _date = TextEditingController();

  DateTime selectedDate = DateTime.now();

  ImagePicker _picker = ImagePicker();
  File imagefile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update ToDo"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 100),
            Container(
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink.shade900,width: 3.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60.0),
                    topRight: Radius.circular(60.0),
                    bottomLeft: Radius.circular(60.0),
                    bottomRight: Radius.circular(60.0),
                  ),
                ),
                child: Container(
                    child: Center(child: Text("Title",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),)))
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.pink.shade900,width: 3.0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: TextField(
                    controller: _title,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
                    keyboardType: TextInputType.name,
                  )
              ),
            ),
            SizedBox(height: 50),
            Container(
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.red.shade900,width: 3.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60.0),
                    topRight: Radius.circular(60.0),
                    bottomLeft: Radius.circular(60.0),
                    bottomRight: Radius.circular(60.0),
                  ),
                ),
                child: Center(child: Text("Remark",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800),))
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.red.shade900,width: 3.0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: TextField(
                    controller: _remark,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.pink.shade900,fontWeight: FontWeight.bold,fontSize: 20),
                    keyboardType: TextInputType.name,
                  )
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () async{
                      File photo = await ImagePicker.pickImage(source: ImageSource.camera);
                      if(photo!=null)
                      {
                        setState((){
                          imagefile = photo;
                        });
                      }
                    },
                    icon: Icon(Icons.camera_alt,size: 60,color: Colors.black45,),
                  ),
                  IconButton(
                    onPressed: () async{
                      File photo = await ImagePicker.pickImage(source: ImageSource.gallery);
                      if(photo!=null)
                      {
                        setState((){
                          imagefile = photo;
                        });
                      }
                    },
                    icon: Icon(Icons.file_copy_sharp,size: 60,color: Colors.blue,),
                  ),
                  Container(
                      width: 100,
                      child:(imagefile!=null)?Image.file(imagefile):Image.asset("img/download.png")
                  ),
                ],
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
                      controller: _date,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1,color: Colors.yellow),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    IconButton(onPressed: () async{
                      final DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101));
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                          var d = DateFormat("dd-MM-yyy").format(picked).toString();
                          _date.text = d.toString();
                        });
                      }
                    }, icon: Icon(Icons.calendar_today)
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black,width: 3.0),
              ),
              child: GestureDetector(
                onTap: () async{

                  var title = _title.text.toString();
                  var remark = _remark.text.toString();
                  var dt = _date.text.toString();



                },
                child: PlayAnimation<Color>(
                  tween: ColorTween(begin: Colors.blue, end: Colors.white),
                  duration:  Duration(seconds: 1),
                  delay:  Duration(seconds: 1), // add delay
                  builder: (context, child, value) {
                    return Container(
                      color: value,
                      child: Center(child: Text("ADD",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),)),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
