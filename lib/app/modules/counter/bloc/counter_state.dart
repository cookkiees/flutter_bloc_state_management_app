part of 'counter_bloc.dart';

class CounterState extends Equatable {
  final int counter;

  const CounterState(this.counter);

  @override
  List<Object> get props => [counter];
}

class InitialState extends CounterState {
  const InitialState(super.count);
}

class UpdateState extends CounterState {
  const UpdateState(super.counter);
}
