import 'package:flutter/material.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/screens/notification.dart';

// Widget representing a single ToDo item in the list
class ToDoItem extends StatelessWidget {
  final ToDo todo; // The ToDo object associated with this item
  final Function(ToDo) onToDoChanged; // Callback function for task completion status change
  final Function(String) onDeleteItem; // Callback function for task deletion
  final Function(String, String) editTask;
  final Function(ToDo) handleEditTask;
  final BuildContext context;

  // Constructor for ToDoItem, taking required parameters
  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
    required this.editTask,
    required this.handleEditTask,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(bottom: 20), // Set margin for the ListTile container
      child: ListTile(
        onTap: () {
          onToDoChanged(
              todo); // Invoke callback function when the item is tapped
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20), // Set rounded corners for the ListTile
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 5), // Set content padding
        tileColor: Colors.white, // Set background color of the ListTile
        leading: Icon(
          todo.isDone
              ? Icons.check_box
              : Icons
                  .check_box_outline_blank, // Display check box icon based on completion status
          color: Color.fromARGB(255, 171, 57, 8), // Set icon color to blue
        ),
        title:
            todo.editing ? _buildEditingTextField(context) : _buildTaskText(),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                // Handle editing task
                handleEditTask(todo);
              },
              tooltip: 'Edit',
              icon: Icon(
                Icons.edit,
                color: const Color.fromARGB(255, 95, 94, 94),
                size: 24,
              ),
            ),
            IconButton(
            tooltip: 'Set a reminder',
            onPressed: ()
               => setReminder(context, todo),
            icon: Icon(Icons.alarm_rounded)),
            IconButton(
              tooltip: 'Delete',
              onPressed: () {
                onDeleteItem(todo.id);
              },
              icon: Icon(
                Icons.delete,
                size: 24,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditingTextField(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: TextEditingController(text: todo.todoText),
      onChanged: (value) {
        todo.todoText = value; // Update task text as the user types
      },
      onSubmitted: (value) {
        todo.editing = false; // Exit editing mode when submitted
        editTask(todo.id, value); // Call editTask function
      },
    );
  }

  Widget _buildTaskText() {
    return Text(
      todo.todoText,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
        decoration: todo.isDone ? TextDecoration.lineThrough : null,
      ),
    );
  }
 }
