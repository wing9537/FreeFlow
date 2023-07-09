import 'package:flutter/material.dart';
import 'package:free_flow/common/constant.dart';
import 'package:free_flow/common/tool.dart';
import 'package:free_flow/state/diary_form.dart';
import 'package:free_flow/views/diary/photo_list.dart';
import 'package:free_flow/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class CreateDiary extends StatefulWidget {
  const CreateDiary({super.key});

  @override
  State<StatefulWidget> createState() => _CreateDiaryState();
}

class _CreateDiaryState extends State<CreateDiary> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final DateTime _today = DateTime.now();

  void _submitForm(DiaryFormState state) {
    if (_formKey.currentState!.validate()) {
      state.submit().then((_) {
        Tool.showToast(context, "Done!");
        Navigator.popAndPushNamed(context, Nav.calendar);
      });
    }
  }

  void _resetForm(DiaryFormState state) {
    setState(() => state.clear());
    Navigator.popAndPushNamed(context, Nav.createDiary);
  }

  void _showDatePicker(DiaryFormState state) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _today,
      firstDate: DateTime(2023, 1, 1),
      lastDate: _today,
    );
    if (selectedDate != null) {
      state.recordDate = selectedDate;
      state.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final DiaryFormState state = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: Text("My Diary (${state.diaryDay})"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _resetForm(state),
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _submitForm(state),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  maxLength: 50,
                  initialValue: state.title,
                  onChanged: (value) => state.title = value,
                  decoration: InputDecoration(
                    hintText: "Title",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () => _showDatePicker(state),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Title should not be blank."
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  minLines: 5,
                  maxLines: 20,
                  initialValue: state.content,
                  onChanged: (value) => state.content = value,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Content",
                  ),
                ),
                const SizedBox(height: 10),
                const PhotoList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
