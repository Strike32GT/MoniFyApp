import 'package:flutter/material.dart';
import 'package:monify_app_mobile/screens/perfil.dart';

class Home extends StatefulWidget{
  const Home([Key? key]) : super(key: key);

  @override 
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const Center(child: Text('Estadistica', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Agregar', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Historial', style: TextStyle(fontSize: 24))),
    const ProfilePage(),
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
              offset: const Offset(0.0,-2),
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
              color: Colors.green.withOpacity(0.7),
              blurRadius: 15,
              spreadRadius: 3,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
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


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildBalanceCard(),
          _buildQuickActions(),
          _buildRecentTransactions(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green[600],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Hola usuario',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
                ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Presupuesto Actual',
            style: TextStyle(color: Colors.white70,fontSize: 16),
          ),
          const Text(
            'S/14.50',
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  } 



  Widget _buildBalanceCard() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBalanceItem('Ingresos','S/500.00', Colors.green, Icons.arrow_upward),
              _buildBalanceItem('Gastos','S/485.50', Colors.red, Icons.arrow_downward),
              _buildBalanceItem('Ahorro','S/14.50', Colors.blue, Icons.savings),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildBalanceItem(String title, String amount, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon,color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }



  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton('Enviar',Icons.send),
          _buildActionButton('Recibir',Icons.call_received),
          _buildActionButton('Pagar',Icons.payment),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.green[600], size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
      ],
    );
  }


  Widget _buildRecentTransactions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transacciones Recientes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildTransactionItem('Supermercado', 'S/85.50', Icons.shopping_cart, Colors.red),
          _buildTransactionItem('Salario', 'S/500.00', Icons.work, Colors.green),
          _buildTransactionItem('Transporte', 'S/20.00', Icons.directions_bus, Colors.red),
        ],
      )
    );
  }


  Widget _buildTransactionItem(String title, String amount, IconData icon, Color color) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title),
      subtitle: Text('Hoy'),
      trailing: Text(
        amount,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}