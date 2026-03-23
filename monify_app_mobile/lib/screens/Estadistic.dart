import 'package:flutter/material.dart';

class EstadisticPage extends StatefulWidget {
  const EstadisticPage({Key? key}) : super(key : key);


  @override
  State<EstadisticPage> createState() => _EstadisticPageState();
}

class _EstadisticPageState extends State<EstadisticPage> {
  int _selectedFilter = 0;


  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildFilterButtons(),
              const SizedBox(height: 20),
              _buildSummaryCards(),
              _buildHighSpendingAlert(),
              const SizedBox(height: 20),
              _buildWeeklyChart(),
              const SizedBox(height: 20),
            ],
          ),
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
          'Panel de analisis',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Estadistica',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
   );
 }

 Widget _buildFilterButtons() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        _buildFilterButton('Esta semana',0),
        const SizedBox(width: 10),
        _buildFilterButton('Este mes', 1),
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
          color: isSelected ? Colors.green[600]! : Colors.white,
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

 Widget _buildSummaryCards() {
  return Padding(
    padding: const EdgeInsetsGeometry.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'Gasto semanal',
            'S/ 319.50',
            '7 dias registrados',
            Icons.account_balance_wallet,
            Colors.green[600]!,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'Promedio diario',
            'S/ 45.64',
            'Limite: S/50.00',
            Icons.trending_up,
            Colors.blue[600]!,
          ),
        ),
      ],
    ),
  );
 }


 Widget _buildSummaryCard(String title, String amount, String subtitle, IconData icon, Color color) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              Icon(Icons.more_vert, color: Colors.grey[400]),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title, 
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 10,
            ),
          )
        ],
      ),
    ),
  );
 }


 Widget _buildHighSpendingAlert() {
  return Padding(
    padding: const EdgeInsetsGeometry.symmetric(horizontal: 20.0),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.emoji_events, color: Colors.orange[600]!, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dia con mas gastos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Fue el dia que mas gastaste: S/62.00',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ],
            ), 
          ),
        ],
      ),
    ),
  );
 }



 Widget _buildWeeklyChart() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Gasto del dia (esta semana)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.trending_up, color: Colors.green[600]!, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '+8%',
                    style: TextStyle(
                      color: Colors.green[600]!,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildBardChart(),
        const SizedBox(height: 16),
        _buildChartLegend(),
      ],
    ),
  );
 }


 Widget _buildBardChart() {
  return Container(
    height: 200,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildBar('Lun',35.0,Colors.green[600]!),
        _buildBar('Mar',42.0,Colors.green[600]!),
        _buildBar('Mrc',55.0,Colors.yellow[600]!),
        _buildBar('Jue',62.0,Colors.red[600]!),
        _buildBar('Vie',48.0,Colors.yellow[600]!),
        _buildBar('Sab',28.0,Colors.green[600]!),
        _buildBar('Dom',49.0,Colors.green[600]!),
      ],
    ),
  );
 }


 Widget _buildBar(String day, double height, Color color) {
  return Column(
    children: [
      Container(
        width: 30,
        height: height * 2.5,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        day,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
 }


 Widget _buildChartLegend() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildLegendItem('Dentro del presupuesto', Colors.green[600]!),
      const SizedBox(width: 16),
      _buildLegendItem('Cerca del limite', Colors.yellow[600]!),
      const SizedBox(width: 16),
      _buildLegendItem('Mayor gasto', Colors.red[600]!),
    ],
  );
 }

 Widget _buildLegendItem(String text, Color color) {
  return Row(
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 6),
      Text(
        text,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 11,
        ),
      ),
    ],
  );
 }
}