import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable{

  const TimerEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent{
  final int duration;
  TimerStarted(this.duration);
  @override
  String toString() => "TimerStarted { duration: $duration }";
}
class TimerPaused extends TimerEvent{
}
class TimerResumed extends TimerEvent {}

class TimerReset extends TimerEvent {}

class TimerTicked extends TimerEvent{
  final int duration;
  TimerTicked(this.duration);
  @override
  String toString() => "TimerStarted { duration: $duration }";
}

