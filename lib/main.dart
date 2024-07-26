import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:strapitodapp/app/task_detail_screen.dart';
import 'package:strapitodapp/constants/app_colors.dart';

final HttpLink httpLink = HttpLink("http://localhost:1337/graphql");

final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
  GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  ),
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowMaterialGrid: false,
        theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.appBackgroundColor,
          ),
          scaffoldBackgroundColor: AppColors.appBackgroundColor,
        ),
        title: 'Flutter Demo',
        home: const AppScreen(),
      ),
    );
  }
}
