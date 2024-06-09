import 'package:todo_app/home/ui_l_home_provider.dart';
import 'package:todo_app/widgets/textfeild.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/widgets/w_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<UILogicHome>(context, listen: false);
      provider.loadCachedData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text('Welcome to Test App'),
      ),
      backgroundColor: AppColors.background,
      body: Consumer<UILogicHome>(
        builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * provider.height,
                child: provider.list != null
                    ? ListView.builder(
                        itemCount: provider.list!.todos.length,
                        itemBuilder: (context, index) {
                          final todo = provider.list!.todos[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              child: ListTile(
                                tileColor:
                                    AppColors.background.withOpacity(0.5),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Task ID: ${todo.id} User ID: ${todo.userId}'),
                                    Text(todo.todo),
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Completed: ${todo.completed}'),
                                    TextButton(
                                      onPressed: () =>
                                          provider.updatetask(todo.id, index),
                                      child: const Text('change status'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          provider.deletedata(todo.id, index),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    if (provider.addnew == true)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFeild(
                            controller: provider.userId,
                            label: 'User ID',
                          ),
                          TextFeild(
                            controller: provider.taskId,
                            label: 'Task ID',
                          ),
                          TextFeild(
                            controller: provider.task,
                            label: 'Task',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () => provider.cancel(),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => provider.addtasks(),
                                child: const Text('Add'),
                              ),
                            ],
                          )
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WidgetButton(
                            label: 'Previous',
                            onTap: () => provider.previous()),
                        WidgetButton(
                            label: 'New task', onTap: () => provider.newtask()),
                        WidgetButton(
                          label: 'Next',
                          onTap: () => provider.next(),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
