class Ticker{

  Stream<int> tick(int ticks) {
   return Stream.periodic(Duration(seconds: 1),(e)=>ticks-e-1).take(ticks);
  }
}