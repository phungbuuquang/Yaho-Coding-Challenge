import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahoapp/data/remote/user/user_response.dart';

import 'package:yahoapp/features/list_users/repository/list_user_repository.dart';
part 'list_users_state.dart';

class ListUserCubit extends Cubit<ListUserState> {
  ListUserCubit() : super(ListUserInitialState());
  List<UserModel> _users = [];
  int page = 1;
  int total = 0;
  var isLoadmore = false;
  var isLoading = false;
  var isGrid = true;

  getListUsers() async {
    if (!isLoading) {
      emit(ListUserLoadingState());
      isLoading = true;
    }
    final res = await ListUserRepository.instance.getListUsers(page: page);

    isLoadmore = false;
    if (res != null) {
      total = res.total ?? 0;
      if (page == 1) {
        _users = res.data ?? [];
      } else {
        _users.addAll(res.data ?? []);
      }
      emit(ListUserDoneState(_users));
      return;
    }
    emit(ListUserErrorState());
  }

  loadMore() {
    if (total == _users.length) {
      return;
    }
    page += 1;
    if (!isLoadmore) {
      getListUsers();
      isLoadmore = true;
    }
  }

  Future<void> onRefresh() async {
    page = 1;
    getListUsers();
  }

  switchModeView() {
    isGrid = !isGrid;
    emit(ListUserSwitchModeViewState());
    emit(ListUserDoneState(_users));
  }
}
