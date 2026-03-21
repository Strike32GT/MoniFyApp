import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  const Home([Key? key]) : super(key: key);

  @override 
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('Inicio', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Estadistica', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Agregar', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Historial', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Perfil', style: TextStyle(fontSize: 24))),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0.0,-45.0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0,Icons.home_outlined,'Inicio'),
            _buildNavItem(1,Icons.bar_chart_outlined,'Estadistica'),
            //_buildAddButton(),
            Transform.translate(
              offset: const Offset(0.0,-20.0),
              child: _buildAddButton(),
            ),
            _buildNavItem(3,Icons.history_outlined,'Historial'),
            _buildNavItem(4,Icons.person_outline,'Perfil')
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        width: 48,
        height: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive ? Colors.green[600] : Colors.grey[600],
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: isActive ? Colors.green : Colors.grey[600],
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal
                ),
              ),
          ],
        ),
      ),
    );
  }


  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = 2;
        });
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.green[600],
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          Icons.add,
          size: 28,
          color: Colors.white,
        ),
      ),
    );
  }
}