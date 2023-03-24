part of 'list_users_cubit.dart';

abstract class ListUserState {}

class ListUserInitialState extends ListUserState {}

class ListUserDoneState extends ListUserState {
  List<UserModel> listUsers;
  ListUserDoneState(this.listUsers);
}

class ListUserErrorState extends ListUserState {}

class ListUserLoadingState extends ListUserState {}

class ListUserSwitchModeViewState extends ListUserState {}
