import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;

  HomeScreen({required this.child});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Books')),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'By Author'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'By Title'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Profile'),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          if (index == 0) {
            context.go('/byAuthor');
            print('go to byAuthor');
          } else if (index == 1) {
            context.go('/byTitle');
            print('go to byTitle');
          } else if (index == 2) {
            context.go('/profile');
            print('go to profile');
          }
        },
      ),
    );
  }
}