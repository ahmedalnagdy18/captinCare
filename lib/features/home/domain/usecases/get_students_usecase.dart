import 'package:captin_care/features/home/data/model/students_model.dart';
import 'package:captin_care/features/home/domain/repository/dashboard_repository.dart';

class GetStudentsUseCase {
  final DashboardRepository repository;

  GetStudentsUseCase({required this.repository});

  Stream<List<StudentModel>> call() {
    return repository.getStudentsStream();
  }
}
