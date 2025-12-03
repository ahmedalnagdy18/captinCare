import 'package:captin_care/features/home/presentation/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:captin_care/features/home/presentation/screens/home_page.dart';
import 'package:captin_care/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1️⃣ initialize Firebase
  await Supabase.initialize(
    url: 'https://bauouochgpbntyhmqhpm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJhdW91b2NoZ3BibnR5aG1xaHBtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ3ODUzNDAsImV4cCI6MjA4MDM2MTM0MH0.eqs6vCjTCjbUzMqv6PK_hSvKJFftstAA4oO6EKxqxJM',
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
      create:
          (context) => DashboardCubit(
            addStudent: sl(),
            deleteStudent: sl(),
            getStudents: sl(),
            updateStudent: sl(),
          )..fetchStudents(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()),
    );
  }
}
