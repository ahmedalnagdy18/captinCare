import 'package:captin_care/features/home/data/model/students_model.dart';
import 'package:captin_care/features/home/domain/repository/dashboard_repository.dart';

class UpdateStudentUseCase {
  final DashboardRepository repository;

  UpdateStudentUseCase({required this.repository});

  Future<void> call(StudentModel student) async {
    return repository.updateStudent(student);
  }
}
