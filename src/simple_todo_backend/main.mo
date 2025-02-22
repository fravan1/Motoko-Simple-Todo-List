import Array "mo:base/Array";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import _iter "mo:base/Iter";

actor TodoList {
    // Define the Task type
    type Task = {
        id: Nat;
        description: Text;
        completed: Bool;
    };

    // Store tasks in an array
    var tasks: [Task] = [];
    var nextId: Nat = 0;

    // Add a new task
    public func addTask(description: Text): async Nat {
        let newTask: Task = {
            id = nextId;
            description = description;
            completed = false;
        };
        tasks := Array.append(tasks, [newTask]);
        nextId += 1;
        return newTask.id;
    };

    // Mark a task as completed
    public func completeTask(taskId: Nat): async Text {
        tasks := Array.map<Task, Task>(tasks, func(task) {
            if (task.id == taskId) {
                { task with completed = true }
            } else {
                task
            }
        });
        return "Task marked as complete";
    };

    // List all tasks
    public query func listTasks(): async [Task] {
        return tasks;
    };

    // Delete a task by ID
    public func deleteTask(taskId: Nat): async Text {
        tasks := Array.filter<Task>(tasks, func(task) = task.id != taskId);
        return "Task deleted";
    };

    // Helper function to find a task by ID
    public query func getTask(taskId: Nat): async ?Task {
        return Array.find<Task>(tasks, func(task) = task.id == taskId);
    };
};