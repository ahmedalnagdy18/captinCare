import 'package:captin_care/core/colors/app_colors.dart';
import 'package:captin_care/features/home/data/model/students_model.dart';
import 'package:captin_care/features/home/presentation/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:captin_care/features/home/presentation/widgets/export_to_excel_widget.dart';
import 'package:captin_care/features/home/presentation/widgets/student_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      color: AppColors.sidebarColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            Row(
              children: const [
                Icon(Icons.square, color: Colors.white, size: 32),
                SizedBox(width: 10),
                Text(
                  "LOGO",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Menu Items
            buildMenuItem(icon: Icons.dashboard, title: "Dashboard"),
            buildMenuItem(icon: Icons.people, title: "Students"),
            InkWell(
              onTap: () {
                openStudentForm(context);
              },
              child: buildMenuItem(icon: Icons.add, title: "Add Student"),
            ),
            InkWell(
              onTap: () {
                final students =
                    context.read<DashboardCubit>().state is DashboardLoaded
                        ? (context.read<DashboardCubit>().state
                                as DashboardLoaded)
                            .students
                            .cast<StudentModel>()
                        : <StudentModel>[];
                exportToExcel(context, students);
              },
              child: buildMenuItem(
                icon: Icons.file_copy,
                title: "Export to Excel",
              ),
            ),
            buildMenuItem(icon: Icons.settings, title: "Settings"),

            const Spacer(),

            buildMenuItem(icon: Icons.lock, title: "Logout"),
          ],
        ),
      ),
    );
  }
}

// ------------------ SIDEBAR ITEM ------------------
Widget buildMenuItem({required IconData icon, required String title}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 14),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    ),
  );
}
