class Task {
  String title;
  String note;
  bool isDone;

  Task({
    required this.title,
    required this.note,
    this.isDone = false,
  });
}
