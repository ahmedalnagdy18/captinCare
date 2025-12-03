import 'package:captin_care/features/home/presentation/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:captin_care/features/home/presentation/screens/home_page.dart';
import 'package:captin_care/firebase_options.dart';
import 'package:captin_care/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1️⃣ initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 2️⃣ initialize DI (GetIt)
  await init();

  // لازم تستدعي init قبل تشغيل التطبيق
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1000, 700),
    minimumSize: Size(800, 600), // 👈 هنا بتحدد أقل حجم ممكن
    center: true,
    backgroundColor: Colors.transparent,
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(
        addStudent: sl(),
        deleteStudent: sl(),
        getStudents: sl(),
        updateStudent: sl(),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
