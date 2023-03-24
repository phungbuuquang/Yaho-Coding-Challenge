import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahoapp/components/my_cached_image.dart';
import 'package:yahoapp/data/remote/user/user_response.dart';
import 'package:yahoapp/features/list_users/blocs/list_users_cubit.dart';

import 'package:yahoapp/themes/themes.dart';

class ListUsersView extends StatefulWidget {
  const ListUsersView({super.key});

  @override
  State<ListUsersView> createState() => _ListUsersViewState();
}

class _ListUsersViewState extends State<ListUsersView> {
  ListUserCubit get _cubit => BlocProvider.of<ListUserCubit>(context);
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.getListUsers();
    });
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 500) {
      _cubit.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('List users'),
        actions: [
          IconButton(
              icon: Icon(
                  AppTheme.of(context).currentThemeKey == AppThemeKeys.light
                      ? Icons.nightlight_round
                      : Icons.wb_sunny),
              onPressed: () {
                AppTheme.of(context).switchTheme();
              })
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<ListUserCubit, ListUserState>(
            buildWhen: (previous, current) =>
                current is ListUserSwitchModeViewState,
            builder: (_, state) => Padding(
              padding: const EdgeInsets.only(
                top: 16,
                right: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: _cubit.switchModeView,
                    child: Icon(
                      _cubit.isGrid ? Icons.table_rows : Icons.grid_view,
                      color: AppTheme.of(context).currentThemeKey ==
                              AppThemeKeys.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ListUserCubit, ListUserState>(
                buildWhen: (previous, current) =>
                    current is ListUserLoadingState ||
                    current is ListUserDoneState,
                builder: (_, state) {
                  if (state is ListUserLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).indicatorColor,
                      ),
                    );
                  }
                  if (state is ListUserDoneState) {
                    return RefreshIndicator(
                      onRefresh: () => _cubit.onRefresh(),
                      child: _cubit.isGrid
                          ? GridView.builder(
                              controller: controller,
                              padding: const EdgeInsets.all(16),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 2 / 3,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: state.listUsers.length,
                              itemBuilder: (_, index) {
                                final item = state.listUsers[index];
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color:
                                        AppTheme.of(context).currentThemeKey ==
                                                AppThemeKeys.dark
                                            ? const Color(0xFF263238)
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(5, 5),
                                        blurRadius: 15,
                                        color: Colors.black.withOpacity(0.1),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: MyCachedImage(
                                            item.avatar ?? '',
                                            height: 100,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        (item.firstName ?? '') +
                                            (item.lastName ?? ''),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      Text(
                                        item.email ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      )
                                    ],
                                  ),
                                );
                              })
                          : _buildListView(state.listUsers, context),
                    );
                  }
                  return const SizedBox.shrink();
                }),
          ),
        ],
      ),
    );
  }

  ListView _buildListView(List<UserModel> users, BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: controller,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: users.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, index) {
        final item = users[index];
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppTheme.of(context).currentThemeKey == AppThemeKeys.dark
                ? const Color(0xFF263238)
                : Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                offset: const Offset(5, 5),
                blurRadius: 15,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: MyCachedImage(
                  item.avatar ?? '',
                  width: 50,
                  height: 50,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    (item.firstName ?? '') + (item.lastName ?? ''),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    item.email ?? '',
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
