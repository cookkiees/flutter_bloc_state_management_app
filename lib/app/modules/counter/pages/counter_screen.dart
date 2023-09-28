import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter_bloc.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'C O U N T E R',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            if (state is InitialState) {
              return _buildCounter(context, 0);
            }
            if (state is UpdateState) {
              return _buildCounter(context, state.counter);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Column _buildCounter(BuildContext context, int counter) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Value:',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          counter.toString(),
          style: const TextStyle(fontSize: 40),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<CounterBloc>().add(NumberIncreaseEvent());
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                context.read<CounterBloc>().add(NumberDecreaseEvent());
              },
              child: const Icon(Icons.remove, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
