import 'package:bloc_practice/Presentation/Timer.dart';
import 'dart:async';
import 'package:bloc_practice/Blocs/TimerBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'Blocs/Ticker.dart';
import 'Blocs/state.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(109, 234, 255, 1),
        accentColor: Color.fromRGBO(72, 74, 126, 1),
        brightness: Brightness.dark,
      ),
      home: BlocProvider(
          create: (context)=>TimerBloc(ticker: Ticker(),),
          child: Timer()),
    );
  }
}

