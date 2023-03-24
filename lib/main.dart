import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahoapp/features/list_users/views/list_users_view.dart';
import 'package:yahoapp/routes/routes_management.dart';
import 'package:yahoapp/themes/themes.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AppTheme(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.of(context, listen: true).currentTheme,
      onGenerateRoute: RoutesManager.generateRoute,
      initialRoute: RouteName.listUser,
    );
  }
}
