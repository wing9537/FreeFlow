import 'package:flutter/material.dart';
import 'package:free_flow/common/tool.dart';
import 'package:free_flow/state/new_diary.dart';
import 'package:free_flow/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class CreateDiary extends StatefulWidget {
  const CreateDiary({super.key});

  @override
  State<StatefulWidget> createState() => _CreateDiaryState();
}

class _CreateDiaryState extends State<CreateDiary> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final NewDiaryState form = context.read();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Diary"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                form.submit().then((_) {
                  Tool.showToast(context, "Done!");
                });
              }
            },
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
            child: Column(children: [
              TextFormField(
                maxLength: 50,
                initialValue: form.title,
                onChanged: (value) => form.title = value,
                decoration: const InputDecoration(hintText: "Title"),
                validator: (value) => value == null || value.isEmpty
                    ? "Title should not be blank."
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                minLines: 5,
                maxLines: 20,
                initialValue: form.content,
                onChanged: (value) => form.content = value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Content",
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
