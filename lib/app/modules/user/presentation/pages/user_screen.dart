import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    userBloc.add(UserEventInitial());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "U S E R",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: userBloc,
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state is UserSuccess) {
            final userList = state.userList;
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                userBloc.add(UserEventRefresh());
              },
              child: ListView.builder(
                itemCount: userList?.length ?? 0,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  final user = userList?[index];
                  return Card(
                    child: ListTile(
                      title: Text(user?.name ?? ''),
                      subtitle: Text(user?.email ?? ''),
                    ),
                  );
                },
              ),
            );
          } else if (state is UserError) {
            return Text('Error: ${state.error}');
          }
          return const Text('No data available.');
        },
      ),
    );
  }
}
