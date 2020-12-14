import 'package:bloc_practice/Blocs/TimerBloc.dart';
import 'package:bloc_practice/Blocs/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Blocs/state.dart';
class ActionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     children: mapStateToAction(BlocProvider.of<TimerBloc>(context)));
  }
  List<Widget> mapStateToAction(TimerBloc timerBloc){
    TimerState currentState = timerBloc.state;
    if(currentState is TimerInitial){
      return [FlatButton(child: Icon(Icons.play_arrow),onPressed: (){
        timerBloc.add(TimerStarted(currentState.duration));
      },)];
    }
    if (currentState is TimerRunInProgress) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () => timerBloc.add(TimerPaused()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(TimerReset()),
        ),
      ];
    }
    if (currentState is TimerRunPause) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timerBloc.add(TimerResumed()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(TimerReset()),
        ),
      ];
    }
    if (currentState is TimerRunComplete) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(TimerReset()),
        ),
      ];
    }
    return [];
  }
}
