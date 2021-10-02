import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';
import 'package:newsapi_clean_architecture_cubit/app/data/datasources/local/articles_local_datasource.dart';
import 'package:newsapi_clean_architecture_cubit/app/presentation/home/view/home_view.dart';

import 'di/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Injector.setup();
  await Injector.resolve<ArticlesLocalDatasource>().initDb();
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: true,
    title: 'News X Clean Architecture',
    defaultTransition: Transition.cupertino,
    home: HomeView(),
  ));
}
