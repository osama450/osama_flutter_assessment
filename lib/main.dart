import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_plus/app.dart';
import 'core/di/injection_container.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/database_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait<dynamic>([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    configureDependencies(),
    DatabaseManager.initHive(),
  ]);

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}
