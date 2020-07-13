# ToDoList Application

A todo list application which uses the provider package to give access to the state model to its children by actively listening to any changes. Or if it not required, then we can set the listen property to false (such as a form input).
The main file is wrapped using ChangeNotifierProvider for this to work. 

With this app, you can add you to do items by giving info such as the Title, Start Date and End Date. Then the to do list will show your to do item with a time left for that task.

![Screenshot_20200713_081627_com example todolist](https://user-images.githubusercontent.com/46454997/87259989-a7cae880-c4e1-11ea-8530-07856be3b43e.jpg)

You can also delete any to do item simply by tapping the card and slide it from right to left.

<img width="190" alt="slidetodelete" src="https://user-images.githubusercontent.com/46454997/87260117-74d52480-c4e2-11ea-9bd5-f1be9234321f.png">

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
