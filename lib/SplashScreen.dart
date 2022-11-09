import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoappfirebase/ToDoView.dart';
import 'package:todoappfirebase/TodoAdd.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  open() async
  {
    Navigator.of(context).pop();
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>ToDoView())
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds:3000), () {
      open();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
            'https://assets9.lottiefiles.com/packages/lf20_jy1bgnpp.json'
        ),
        // child: Image.asset("img/todolistsplash.png",width: 300,),
      ),
    );
  }
}
