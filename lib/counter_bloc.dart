import 'dart:async';
import 'package:flutter_bloc_example/counter_event.dart';

class CounterBloc {
  int _counter = 0;

  // counter用のstreamcontroller宣言(引数はint)
  final _counterStateController = StreamController<int>();

  // counterをaddして操作(sink)するための変数
  StreamSink<int> get _inCounter => _counterStateController.sink;

  // counterを取得stream()するための変数
  Stream<int> get counter => _counterStateController.stream;

  // event取得用のstreamcontroller宣言(引数はcountevent)
  final _counterEventController = StreamController<CounterEvent>();

  //countereventをaddして操作(sink)するための変数
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent)
      _counter++;
    else
      _counter--;

    _inCounter.add(_counter);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}