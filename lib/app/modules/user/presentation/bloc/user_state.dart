part of 'user_bloc.dart';

class UserState extends Equatable {
  final List<UserBaseEntity>? userList;
  final String? error;
  const UserState({this.userList = const [], this.error});

  @override
  List<Object> get props => [userList!, error ?? ''];
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserSuccess extends UserState {
  const UserSuccess(List<UserBaseEntity>? userList) : super(userList: userList);
}

class UserError extends UserState {
  const UserError(String error) : super(error: error);
}
