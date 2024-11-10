import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSidebarOpen = false;

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Bar'),
      ),
      body: Row(
        children: [
          if (_isSidebarOpen)
            Container(
              width: 200,
              color: Colors.grey[200],
              child: ListView(
                children: const [
                  ListTile(
                    title: Text('Sidebar Item 1'),
                  ),
                  ListTile(
                    title: Text('Sidebar Item 2'),
                  ),
                  ListTile(
                    title: Text('Sidebar Item 3'),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Text('Main Content'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleSidebar,
        child: Icon(_isSidebarOpen ? Icons.close : Icons.menu),
      ),
    );
  }
}
