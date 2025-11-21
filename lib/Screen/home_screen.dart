import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dailydo/Screen/screen.dart';

//Ana ekran - görev listesini gösterir
class HomeScreen extends StatelessWidget {
  final Box gorevlerBox = Hive.box('gorevler');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Görevler', style: TextStyle(color: Colors.white)),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
      ),

      body: ValueListenableBuilder(
        valueListenable: gorevlerBox.listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return Center(child: Text("Henüz görev eklenmedi."));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final task = box.getAt(index);

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Checkbox(
                    value: task['isDone'],
                    onChanged: (value) {
                      box.putAt(index, {
                        'title': task['title'],
                        'note': task['note'],
                        'isDone': value!,
                      });
                    },
                  ),
                  title: Text(
                    task['title'],
                    style: TextStyle(
                      decoration: task['isDone']
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  subtitle: Text(task['note']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      box.deleteAt(index);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
