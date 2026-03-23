import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override 
  State<HistoryPage> createState() => _HistoryPageState();
}


class _HistoryPageState extends State<HistoryPage> {
  int _selectedFilter = 0;

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildFilterButtons(),
            const SizedBox(height: 20),
            _buildDailySummary(),
            const SizedBox(height: 10),
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Registro Completo',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Historial',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Total (hoy)',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const Text(
                    '-S/35.50', 
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar gastos ...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        ),
      ),
    );
  }


  Widget _buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          _buildFilterButton('Hoy',0),
          const SizedBox(width: 10),
          _buildFilterButton('Semana', 1),
          const SizedBox(width: 10),
          _buildFilterButton('Mes',2),
        ],
      ),
    );
  }


  Widget _buildFilterButton(String text, int index) {
    bool isSelected = _selectedFilter == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = index;
          });
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? Colors.green[600] : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? Colors.green[600]! : Colors.grey[300]!,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildDailySummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem('Gastos', 'S/35.50', Colors.red),
              _buildSummaryItem('Ingresos', 'S/0.00', Colors.green),
              _buildSummaryItem('Balance', 'S/35.50', Colors.grey[700]!),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSummaryItem(String label, String amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }


  Widget _buildTransactionList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transacciones',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildTransactionGroup('Ayer', [
            _buildTransactionItem('Uber', 'S/15.50', Icons.directions_car, Colors.red, '14:30'),
            _buildTransactionItem('Almuerzo', 'S/20.00', Icons.restaurant, Colors.red, '12:15'),
          ]),
          const SizedBox(height: 20),
          _buildTransactionGroup('Ayer', [
            _buildTransactionItem('Supermercado','S/85.50',Icons.shopping_cart, Colors.red, '18.45'),
            _buildTransactionItem('Salario','S/500.00',Icons.work, Colors.green, '09.00'),
          ]),
          const SizedBox(height: 20),
          _buildTransactionGroup('Lunes', [
            _buildTransactionItem('Transporte', 'S/8.00', Icons.directions_bus, Colors.red, '19.20'),
          ]),
        ],
      ),
    );
  }


  Widget _buildTransactionGroup(String date, List<Widget> transactions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
          ...transactions,
      ],
    );
  }


  Widget _buildTransactionItem(String title, String amount, IconData icon, Color color, String time) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title),
      subtitle: Text(time),
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
