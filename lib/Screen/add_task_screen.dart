import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final Box gorevlerBox = Hive.box('gorevler');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Görev Ekle"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Görev Başlığı",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Açıklama",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  gorevlerBox.add({
                    'title': titleController.text,
                    'note': noteController.text,
                    'isDone': false,
                  });

                  Navigator.pop(context);
                }
              },
              child: Text("Ekle"),
            ),
          ],
        ),
      ),
    );
  }
}
