import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<String> todos = [];
  List<bool> checked = [];
  TextEditingController _controller = TextEditingController();

  void _addTodo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Yeni Görev Ekle'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Görev adını girin',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (_controller.text.isNotEmpty) {
                    todos.add(_controller.text);
                    checked.add(false);
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Ekle'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('İptal'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'To-Do List',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 241, 183, 203), // Açık pembe arka plan rengi
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center, // Resmi ortalamak için
                child: Image.asset(
                  'assets/images/kedi.png',
                  width: MediaQuery.of(context).size.width * 0.5, // Resmin genişliği
                  height: MediaQuery.of(context).size.height * 0.3, // Resmin yüksekliği
                  fit: BoxFit.contain, // Resmi orantılı şekilde küçült
                ),
              ),
            ),
            Container(
              color: Colors.black54, // Semi-transparent background to improve text readability
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                      child: Row(
                        children: [
                          Checkbox(
                            value: checked[index],
                            onChanged: (bool? value) {
                              setState(() {
                                checked[index] = value!;
                              });
                            },
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Text(
                              todos[index],
                              style: TextStyle(
                                fontSize: 16.0,
                                decoration: checked[index] ? TextDecoration.lineThrough : TextDecoration.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                todos.removeAt(index);
                                checked.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: Icon(
          Icons.add,
          color: Colors.white, // Artı işaretini beyaz yap
        ),
        backgroundColor: Colors.purple, // Açık mor renk
      ),
    );
  }
}
