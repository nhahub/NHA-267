import 'package:flutter/material.dart';
import 'package:depi_graduation_project/screens/Search_screen.dart';
import 'package:depi_graduation_project/screens/Categories_screen.dart';
import 'package:depi_graduation_project/screens/Settings_Screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<int> _history = [];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const _HomeContent(),
      SearchScreen(onBack: () => _onBackPressed()),
      CategoriesScreen(onBack: () => _onBackPressed()),
      SettingsScreen(onBack: () => _onBackPressed()),
    ];
  }

  void _onTap(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _history.add(_currentIndex);
      _currentIndex = index;
    });
  }

  void _onBackPressed() {
    if (_history.isNotEmpty) {
      setState(() {
        _currentIndex = _history.removeLast();
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.ltr,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedIconTheme: IconThemeData(size: 22, color: Theme.of(context).colorScheme.secondary),
          unselectedIconTheme: IconThemeData(size: 20, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: const Icon(Icons.search), label: 'بحث'),
            BottomNavigationBarItem(icon: const Icon(Icons.grid_view), label: 'الفئات'),
            BottomNavigationBarItem(icon: const Icon(Icons.settings), label: 'الاعدادات'),
          ],
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "مبروك! تم تسجيل الدخول بنجاح 🎉",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}