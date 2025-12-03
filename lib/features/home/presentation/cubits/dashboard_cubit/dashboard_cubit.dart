import 'package:bloc/bloc.dart';
import 'package:captin_care/features/home/data/model/students_model.dart';
import 'package:captin_care/features/home/domain/usecases/add_student_usecase.dart';
import 'package:captin_care/features/home/domain/usecases/delete_student_usecase.dart';
import 'package:captin_care/features/home/domain/usecases/get_students_usecase.dart';
import 'package:captin_care/features/home/domain/usecases/update_student_usecase.dart';
import 'package:meta/meta.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetStudentsUseCase getStudents;
  final AddStudentUseCase addStudent;
  final UpdateStudentUseCase updateStudent;
  final DeleteStudentUseCase deleteStudent;
  DashboardCubit({
    required this.getStudents,
    required this.addStudent,
    required this.updateStudent,
    required this.deleteStudent,
  }) : super(DashboardInitial());

  void fetchStudents() {
    emit(DashboardLoading());
    getStudents().listen((students) {
      emit(DashboardLoaded(students));
    });
  }

  Future<void> addNewStudent(StudentModel student) async {
    await addStudent(student);
  }

  Future<void> updateExistingStudent(StudentModel student) async {
    await updateStudent(student);
  }

  Future<void> removeStudent(String id) async {
    await deleteStudent(id);
  }
}
