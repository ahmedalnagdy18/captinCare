import 'package:captin_care/features/home/data/repository_imp/dashboard_repository_imp.dart';
import 'package:captin_care/features/home/domain/repository/dashboard_repository.dart';
import 'package:captin_care/features/home/domain/usecases/add_student_usecase.dart';
import 'package:captin_care/features/home/domain/usecases/delete_student_usecase.dart';
import 'package:captin_care/features/home/domain/usecases/get_students_usecase.dart';
import 'package:captin_care/features/home/domain/usecases/update_student_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 1. Supabase Client
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // 2. Repository
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImp(supabase: sl()),
  );

  // 3. Usecases
  sl.registerLazySingleton<AddStudentUseCase>(
    () => AddStudentUseCase(repository: sl()),
  );
  sl.registerLazySingleton<DeleteStudentUseCase>(
    () => DeleteStudentUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetStudentsUseCase>(
    () => GetStudentsUseCase(repository: sl()),
  );
  sl.registerLazySingleton<UpdateStudentUseCase>(
    () => UpdateStudentUseCase(repository: sl()),
  );
}
