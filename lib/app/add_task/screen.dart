import 'package:flutter/material.dart';
import 'package:strapitodapp/constants/app_colors.dart';
import 'package:strapitodapp/service/fetch_task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Todo',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        elevation: 0,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                isDense: true,
                labelText: 'Add Title',
                contentPadding: EdgeInsets.all(14),
                hintStyle: TextStyle(color: AppColors.borderColor),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'can\'t be empty';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 28),
            TextFormField(
              controller: commentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                isDense: true,
                labelText: 'Add Comment',
                contentPadding: EdgeInsets.all(14),
                hintStyle: TextStyle(color: AppColors.borderColor),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'can\'t be empty';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightRedColor,
                fixedSize: const Size(120, 45),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  FetchTaskData().addTask(titleController.text.trim(),
                      commentController.text.trim());
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Task Added Successfully '),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Task Can\'t be empty'),
                    backgroundColor: AppColors.lightRedColor,
                  ));
                }
              },
              child: const Text(
                'SUBMIT',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
