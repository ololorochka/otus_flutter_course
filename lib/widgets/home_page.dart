import 'package:flutter/material.dart';
import 'package:otus_food/widgets/recipe_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    RecipeListWidget(),
    Text('Login'), // На будущее
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/pizza_un.png'),
            activeIcon: Image.asset('assets/icons/pizza_act.png'),
            label: 'Рецепты',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/user_un.png'),
            activeIcon: Image.asset('assets/icons/user_act.png'),
            label: 'Вход',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
