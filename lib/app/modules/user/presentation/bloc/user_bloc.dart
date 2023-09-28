import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/services/service_api_result_type.dart';
import '../../data/repository/user_repository_impl.dart';
import '../../domain/entities/user_base_entity.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
  UserBloc() : super(const UserInitial()) {
    on<UserEventInitial>(initialUser);
    on<UserEventRefresh>(refreshUser);
  }
  Future<void> initialUser(
      UserEventInitial event, Emitter<UserState> emit) async {
    emit(const UserLoading());
    await _onUser(event, emit);
  }

  Future<void> refreshUser(
      UserEventRefresh event, Emitter<UserState> emit) async {
    await _onUser(event, emit);
  }

  Future<void> _onUser(UserEvent event, Emitter<UserState> emit) async {
    try {
      final response = await userRepositoryImpl.getUser();
      if (response.result == ApiResultType.success) {
        final data = response.data as List<UserBaseEntity>;
        emit(UserSuccess(data));
      } else {
        emit(UserError(response.message!));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Stream<UserEvent> onUserTransformer(
      Stream<UserEvent> events, Stream<UserEvent> Function(UserEvent) mapper) {
    return events;
  }
}
