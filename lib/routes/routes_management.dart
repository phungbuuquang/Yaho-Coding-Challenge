import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahoapp/features/list_users/blocs/list_users_cubit.dart';
import 'package:yahoapp/features/list_users/views/list_users_view.dart';

class RoutesManager {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.listUser:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ListUserCubit(),
            child: ListUsersView(),
          ),
        );
    }
  }
}

class RouteName {
  static const listUser = '/listUser';
}
