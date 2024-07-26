import 'package:flutter/material.dart';
import 'package:strapitodapp/app/add_task/screen.dart';
import 'package:strapitodapp/constants/app_colors.dart';
import 'package:strapitodapp/model/task.dart';
import 'package:strapitodapp/service/fetch_task.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Details',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: _buildTask(context),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: FloatingActionButton(
          backgroundColor: AppColors.lightRedColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTaskScreen(),
              ),
            );
          },
          child: const Icon(Icons.add_sharp),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTask(BuildContext context) {
    return FutureBuilder<List<TaskManager>>(
      future: FetchTaskData().getTask(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          final taskManagers = snapshot.data!;
          return ListView.builder(
            itemCount: taskManagers.length,
            itemBuilder: (context, index) {
              final task = taskManagers[index];
              return _buildTaskList(context, task);
            },
          );
        }
      },
    );
  }

  Widget _buildTaskList(BuildContext context, TaskManager task) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.borderColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: CheckboxListTile(
            value: task.completed,
            onChanged: (bool? val) {
              setState(() {
                task.completed = val ?? false;
              });
              FetchTaskData().updateTaskCompletion(task.id, task.completed);
            },
            title: Text(
              task.title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.whiteColor,
                  ),
            ),
            subtitle: Text(
              task.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 12,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: AppColors.whiteColor),
            ),
            secondary: const Icon(
              Icons.assignment_sharp,
              color: AppColors.lightRedColor,
            ),
            autofocus: false,
            checkColor: Colors.white,
            activeColor: AppColors.lightRedColor),
      ),
    );
  }
}
