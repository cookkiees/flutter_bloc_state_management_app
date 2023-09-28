import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const InitialState(0)) {
    on<NumberIncreaseEvent>(onNumberIncrease);
    on<NumberDecreaseEvent>(onNumberDecrease);
  }

  void onNumberIncrease(
      NumberIncreaseEvent event, Emitter<CounterState> emit) async {
    emit(UpdateState(state.counter + 1));
    debugPrint('Number Increase Event ${state.counter}');
  }

  void onNumberDecrease(
      NumberDecreaseEvent event, Emitter<CounterState> emit) async {
    emit(UpdateState(state.counter - 1));
    debugPrint('Number Decrease Event ${state.counter}');
  }
}
