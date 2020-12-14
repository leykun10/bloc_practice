import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'state.dart';
import 'events.dart';
import 'Ticker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerBloc extends Bloc<TimerEvent,TimerState>{
  final Ticker _ticker;
  StreamSubscription<int> _tickerSubscription;
  static const int _duration=60;
  TimerBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker,
        super(TimerInitial(_duration));

  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async*{
        if(event is TimerStarted){
         yield* mapTimerStartedToState(event);
        }
       else if(event is TimerTicked){
          yield* mapTimerTickedToState(event);
        }
        else if(event is TimerPaused){
          yield* mapTimerPausedToState(event);
        }
        else if(event is TimerResumed){
          yield* mapTimerResumedToState(event);
        }
        else if(event is TimerReset){
          yield* _mapTimerResetToState(event);
        }

  }
  Stream<TimerState> mapTimerResumedToState(TimerResumed resumed) async*{
    if(state is TimerPaused){
      _tickerSubscription.resume();
      yield TimerRunInProgress(state.duration);
    }

  }

  Stream<TimerState> _mapTimerResetToState(TimerReset reset) async* {
    _tickerSubscription?.cancel();
    yield TimerInitial(_duration);
  }
  Stream<TimerState> mapTimerTickedToState(TimerTicked state) async*{
    yield state.duration>0?TimerRunInProgress(state.duration):TimerRunComplete();
  }
  Stream<TimerState> mapTimerStartedToState(TimerStarted state) async*{
    yield TimerRunInProgress(_duration);
    _tickerSubscription?.cancel();
    _tickerSubscription=_ticker.tick(state.duration).listen((duration) {
       return add(TimerTicked(duration));
    });


  }

  Stream<TimerState> mapTimerPausedToState(TimerPaused paused) async*{
    if(state is TimerRunInProgress){
      _tickerSubscription?.pause();
      yield TimerRunPause(state.duration);
    }


  }


}