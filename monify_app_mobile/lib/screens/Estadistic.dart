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
          children: [ 
            _buildHeader(),
              _buildFilterButtons(),
              const SizedBox(height: 20),
              _buildSummaryCards(),
              _buildHighSpendingAlert(),
              const SizedBox(height: 20),
              _buildWeeklyChart(),
              const SizedBox(height: 20),
              _buildExpenseChart(),
              const SizedBox(height: 20),
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
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
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
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
          ),
      ],
    ),
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
              child: Icon(icon,color: color, size: 20),
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
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle, 
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
 }


 Widget _buildHighSpendingAlert() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
        _buildBarChart(),
        const SizedBox(height: 16),
        _buildChartLegend(),
      ],
    ),
  );
 }


 Widget _buildBarChart() {
  return SizedBox(        //De Container ahora es un Sized box para permitir voltear al eje correcto el grafico
    height: 200,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildBar('Lun',28.0,Colors.green[600]!),
        _buildBar('Mar',35.0,Colors.green[600]!),
        _buildBar('Mie',42.0,Colors.yellow[600]!),
        _buildBar('Jue',48.0,Colors.red[600]!),
        _buildBar('Vie',49.0,Colors.yellow[600]!),
        _buildBar('Sab',55.0,Colors.green[600]!),
        _buildBar('Dom',62.0,Colors.green[600]!),
      ],
    ),
  );
 }


 Widget _buildBar(String day, double valor, Color color) {
  double maxValor = 62.0; //Max valor repetido, sin eso no tendriamosun valor fijo para la escala del layout
  return Column(
    mainAxisAlignment: MainAxisAlignment.end, //Cambio clave para que el grafico comienze del eje x, debido a que Column no estaba alineado correctamente
    children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: 24,
        height: (valor / maxValor) *150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      const SizedBox(height: 6),
      Text(day),
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


 Widget _buildExpenseChart() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Distribucion de Gastos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SweepGradient(
                            colors: [
                              Colors.green[600]!,
                              Colors.green[600]!,
                              Colors.blue[600]!,
                              Colors.blue[600]!,
                              Colors.orange[600]!,
                              Colors.orange[600]!,
                              Colors.purple[600]!,
                              Colors.purple[600]!,
                            ],
                            stops: [0.0, 0.3, 0.3, 0.5, 0.5, 0.75, 0.75, 1.0],
                          ),
                        ),
                      ),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'S/1250',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategoryItem('Comida', 'S/ 375', Colors.green[600]!),
                    const SizedBox(height: 12),
                    _buildCategoryItem('Transporte', 'S/ 250', Colors.blue[600]!),
                    const SizedBox(height: 12),
                    _buildCategoryItem('Entretenimiento', 'S/ 312', Colors.orange[600]!),
                    const SizedBox(height: 12),
                    _buildCategoryItem('Otros', 'S/ 313', Colors.purple[600]!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
 }




 Widget _buildCategoryItem(String category, String amount, Color color) {
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
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          category,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ),
      Text(
        amount,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    ],
  );
 }
}