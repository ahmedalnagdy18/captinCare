import 'package:captin_care/core/common/alert_dialog_widget.dart';
import 'package:captin_care/features/home/data/model/students_model.dart';
import 'package:captin_care/features/home/presentation/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:captin_care/features/home/presentation/widgets/dashboard_card_widget.dart';
import 'package:captin_care/features/home/presentation/widgets/slider_widget.dart';
import 'package:captin_care/features/home/presentation/widgets/student_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF3B82F6);
    const bgColor = Color(0xFFF3F4F6);
    const textColor = Color(0xFF111827);

    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<StudentModel> students = [];
        if (state is DashboardLoaded) {
          students = state.students;
        }

        final studentsToShow =
            searchCtrl.text.isEmpty
                ? students
                : students.where((s) {
                  final query = searchCtrl.text.toLowerCase();
                  return s.name.toLowerCase().contains(query) ||
                      s.phone.toLowerCase().contains(query);
                }).toList();
        return Scaffold(
          backgroundColor: bgColor,
          body: Row(
            children: [
              // ------------------ SIDEBAR ------------------
              SliderWidget(),

              // ------------------ MAIN CONTENT ------------------
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top bar (Dashboard title + Admin icon)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Color(0xFFD1D5DB),
                                child: Icon(Icons.person, color: textColor),
                              ),
                              SizedBox(width: 8),
                              Text('Admin'),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // ------------------ CARDS ------------------
                      SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            DashboardCardWidget(
                              title: "Total Students",
                              number: "${students.length}",
                            ),
                            SizedBox(width: 20),
                            DashboardCardWidget(
                              title: "Active Students",
                              number:
                                  "${students.where((e) => e.status == "Active").length}",
                            ),
                            SizedBox(width: 20),
                            DashboardCardWidget(
                              title: "Paused Accounts",
                              number:
                                  "${students.where((e) => e.status == "Paused").length}",
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // ------------------ STUDENTS LIST HEADER ------------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Students List",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 14,
                              ),
                            ),
                            onPressed: () => openStudentForm(context),
                            child: const Text(
                              "Add Student",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // Search bar
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 48,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xFFD1D5DB)),
                              ),
                              child: TextField(
                                controller: searchCtrl,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search by name or phone",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                onChanged: (_) {
                                  setState(
                                    () {},
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<DashboardCubit>()
                                  .fetchStudents(); // refresh data button
                            },
                            icon: Icon(Icons.refresh),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),
                      // ------------------ STUDENTS TABLE ------------------
                      state is DashboardLoading
                          ? Center(child: CircularProgressIndicator.adaptive())
                          : Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                headingRowColor: WidgetStateProperty.all(
                                  Colors.grey.shade200,
                                ),
                                columnSpacing: 40,
                                horizontalMargin: 20,
                                columns: const [
                                  DataColumn(label: Text("#")),
                                  DataColumn(label: Text("Name")),
                                  DataColumn(label: Text("School")),
                                  DataColumn(label: Text("Parent Phone")),
                                  DataColumn(label: Text("payment Method")),
                                  DataColumn(label: Text("Amout")),
                                  DataColumn(label: Text("Status")),
                                  DataColumn(label: Text("Actions")),
                                ],
                                rows: List.generate(studentsToShow.length, (i) {
                                  final s = studentsToShow[i];
                                  return DataRow(
                                    cells: [
                                      DataCell(Text("${i + 1}")),
                                      DataCell(Text(s.name)),
                                      DataCell(Text(s.school)),
                                      DataCell(Text(s.phone)),
                                      DataCell(Text(s.paymentMethod)),
                                      DataCell(Text(s.amout)),
                                      DataCell(
                                        Row(
                                          children: [
                                            Text(s.status),
                                            SizedBox(width: 6),
                                            s.status == "Paused"
                                                ? Container(
                                                  width: 8,
                                                  height: 8,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.red,
                                                  ),
                                                )
                                                : Container(
                                                  width: 8,
                                                  height: 8,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                          ],
                                        ),
                                      ),
                                      DataCell(
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              ),
                                              onPressed:
                                                  () => openStudentForm(
                                                    context,
                                                    student: s,
                                                  ),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed:
                                                  () => showDialog(
                                                    context: context,
                                                    builder:
                                                        (
                                                          context,
                                                        ) => AlertDialogWidget(
                                                          onDelete:
                                                              () => context
                                                                  .read<
                                                                    DashboardCubit
                                                                  >()
                                                                  .removeStudent(
                                                                    s.id!,
                                                                  ),
                                                        ),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
