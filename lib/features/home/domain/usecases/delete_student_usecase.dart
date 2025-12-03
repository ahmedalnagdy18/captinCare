import 'package:captin_care/features/home/domain/repository/dashboard_repository.dart';

class DeleteStudentUseCase {
  final DashboardRepository repository;

  DeleteStudentUseCase({required this.repository});

  Future<void> call(String id) async {
    return repository.deleteStudent(id);
  }
}
