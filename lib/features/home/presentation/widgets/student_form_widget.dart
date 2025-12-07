import 'package:captin_care/core/colors/app_colors.dart';
import 'package:captin_care/core/common/main_app_textfield.dart';
import 'package:captin_care/core/extentions/app_extentions.dart';
import 'package:captin_care/features/home/data/model/students_model.dart';
import 'package:captin_care/features/home/presentation/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ------- ADD OR EDIT STUDENT DIALOG -------

void openStudentForm(BuildContext context, {StudentModel? student}) {
  final nameCtrl = TextEditingController(text: student?.name ?? "");
  final schoolCtrl = TextEditingController(text: student?.school ?? "");
  final phoneCtrl = TextEditingController(text: student?.phone ?? "");
  final amoutCtrl = TextEditingController(text: student?.amout ?? "");

  String status = student?.status ?? "Active";
  String paymentMethod = student?.paymentMethod ?? "InstaPay";

  showDialog(
    context: context,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          bool isEnabled() {
            return nameCtrl.text.isNotEmpty &&
                schoolCtrl.text.isNotEmpty &&
                phoneCtrl.text.isNotEmpty &&
                amoutCtrl.text.isNotEmpty;
          }

          nameCtrl.addListener(() => setState(() {}));
          schoolCtrl.addListener(() => setState(() {}));
          phoneCtrl.addListener(() => setState(() {}));
          amoutCtrl.addListener(() => setState(() {}));

          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(student == null ? "Add Student" : "Edit Student"),
            content: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MainAppTextfield(
                    labelText: "Name",
                    controller: nameCtrl,
                    inputFormatters: [PreventStartingSpaceInputFormatter()],
                  ),
                  const SizedBox(height: 6),
                  MainAppTextfield(
                    labelText: "School",
                    controller: schoolCtrl,
                    inputFormatters: [PreventStartingSpaceInputFormatter()],
                  ),
                  const SizedBox(height: 6),
                  MainAppTextfield(
                    maxLength: 11,
                    labelText: "Parent Phone",
                    controller: phoneCtrl,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 6),
                  MainAppTextfield(
                    labelText: "Amout",
                    controller: amoutCtrl,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField(
                    initialValue: paymentMethod,
                    items:
                        ["InstaPay", "Vodafone cash"]
                            .map(
                              (q) => DropdownMenuItem(value: q, child: Text(q)),
                            )
                            .toList(),
                    onChanged: (x) => paymentMethod = x!,
                    decoration: const InputDecoration(
                      labelText: "Payment Method",
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField(
                    initialValue: status,
                    items:
                        ["Active", "Paused"]
                            .map(
                              (s) => DropdownMenuItem(value: s, child: Text(s)),
                            )
                            .toList(),
                    onChanged: (v) => status = v!,
                    decoration: const InputDecoration(labelText: "Status"),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: AppColors.primaryBlue),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    isEnabled() ? AppColors.primaryBlue : Colors.grey,
                  ),
                ),
                onPressed:
                    isEnabled()
                        ? () {
                          final cubit = context.read<DashboardCubit>();
                          if (student == null) {
                            cubit.addNewStudent(
                              StudentModel(
                                name: nameCtrl.text,
                                school: schoolCtrl.text,
                                phone: phoneCtrl.text,
                                paymentMethod: paymentMethod,
                                amout: amoutCtrl.text,
                                status: status,
                              ),
                            );
                          } else {
                            cubit.updateExistingStudent(
                              StudentModel(
                                id: student.id,
                                name: nameCtrl.text,
                                school: schoolCtrl.text,
                                phone: phoneCtrl.text,
                                paymentMethod: paymentMethod,
                                amout: amoutCtrl.text,
                                status: status,
                              ),
                            );
                          }
                          Navigator.pop(context);
                        }
                        : null,
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
