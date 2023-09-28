part of 'counter_bloc.dart';

sealed class CounterEvent {}

class NumberIncreaseEvent extends CounterEvent {}

class NumberDecreaseEvent extends CounterEvent {}
