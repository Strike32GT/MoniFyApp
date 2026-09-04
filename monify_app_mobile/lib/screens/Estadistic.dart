import 'package:flutter/material.dart';
import 'package:monify_app_mobile/themes/dark_theme.dart';
import 'package:monify_app_mobile/themes/normal_theme.dart';

class EstadisticPage extends StatefulWidget {
  const EstadisticPage({Key? key}) : super(key: key);

  @override
  State<EstadisticPage> createState() => _EstadisticPageState();
}

class _EstadisticPageState extends State<EstadisticPage> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildFilterButtons(context),
            const SizedBox(height: 20),
            _buildSummaryCards(context),
            _buildHighSpendingAlert(context),
            const SizedBox(height: 20),
            _buildWeeklyChart(context),
            const SizedBox(height: 20),
            _buildExpenseChart(context),
            if (isDark) const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Panel de analisis',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Estadisticas',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildFilterButton(context, 'Esta semana', 0),
          const SizedBox(width: 10),
          _buildFilterButton(context, 'Este mes', 1),
        ],
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context, String text, int index) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isSelected = _selectedFilter == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 46,
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary
                : (isDark ? DarkTheme.surface : Colors.white),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? theme.colorScheme.primary
                  : (isDark ? DarkTheme.border : NormalTheme.border),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected
                    ? (isDark ? DarkTheme.background : Colors.white)
                    : theme.textTheme.bodyMedium?.color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              context,
              'Gasto semanal',
              'S/ 319.50',
              '7 dias registrados',
              Icons.account_balance_wallet,
              NormalTheme.primaryGreen,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard(
              context,
              'Promedio diario',
              'S/ 45.64',
              'Limite: S/50.00',
              Icons.trending_up,
              NormalTheme.gold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String amount,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.cardColor,
        border: Border.all(color: theme.dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              theme.brightness == Brightness.dark ? 0.12 : 0.05,
            ),
            blurRadius: 14,
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
                  color: color.withOpacity(0.16),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              Icon(
                Icons.more_vert,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildHighSpendingAlert(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2B2134) : Colors.orange[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? const Color(0xFF7A3043) : Colors.orange[200]!,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.16),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.emoji_events,
                color: Colors.orange[600],
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dia con mas gastos',
                    style: theme.textTheme.titleMedium?.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Fue el dia que mas gastaste: S/62.00',
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyChart(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gasto por dia (esta semana)',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.trending_up, color: Colors.green[600], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '+8%',
                      style: TextStyle(
                        color: Colors.green[600],
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
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Column(
              children: [
                _buildBarChart(context),
                const SizedBox(height: 16),
                _buildChartLegend(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBar(context, 'Lun', 28.0, NormalTheme.primaryGreen),
          _buildBar(context, 'Mar', 55.0, NormalTheme.lime),
          _buildBar(context, 'Mie', 36.0, NormalTheme.primaryGreen),
          _buildBar(context, 'Jue', 62.0, NormalTheme.danger),
          _buildBar(context, 'Vie', 44.0, NormalTheme.gold),
          _buildBar(context, 'Sab', 54.0, NormalTheme.lime),
          _buildBar(context, 'Dom', 34.0, NormalTheme.primaryGreen),
        ],
      ),
    );
  }

  Widget _buildBar(
    BuildContext context,
    String day,
    double value,
    Color color,
  ) {
    final theme = Theme.of(context);
    const maxValue = 62.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: 26,
          height: (value / maxValue) * 150,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 10),
        Text(day, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12)),
      ],
    );
  }

  Widget _buildChartLegend(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: [
        _buildLegendItem(context, 'Dentro del presupuesto', Colors.green[600]!),
        _buildLegendItem(context, 'Cerca del limite', Colors.yellow[700]!),
        _buildLegendItem(context, 'Mayor gasto', Colors.red[600]!),
      ],
    );
  }

  Widget _buildLegendItem(BuildContext context, String text, Color color) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(text, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11)),
      ],
    );
  }

  Widget _buildExpenseChart(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Distribucion de Gastos',
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.dividerColor),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 340;

                return isCompact
                    ? Column(
                        children: [
                          _buildPieChart(context),
                          const SizedBox(height: 20),
                          _buildCategoryLegend(context),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(flex: 2, child: _buildPieChart(context)),
                          const SizedBox(width: 20),
                          Expanded(child: _buildCategoryLegend(context)),
                        ],
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
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
                  NormalTheme.primaryGreen,
                  NormalTheme.primaryGreen,
                  NormalTheme.lime,
                  NormalTheme.lime,
                  NormalTheme.gold,
                  NormalTheme.gold,
                  Colors.purple[600]!,
                  Colors.purple[600]!,
                ],
                stops: const [0.0, 0.3, 0.3, 0.5, 0.5, 0.75, 0.75, 1.0],
              ),
            ),
          ),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: theme.cardColor,
              shape: BoxShape.circle,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'S/1250',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Total',
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryLegend(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryItem(context, 'Comida', 'S/ 375', Colors.green[600]!),
        const SizedBox(height: 12),
        _buildCategoryItem(context, 'Transporte', 'S/ 250', Colors.blue[600]!),
        const SizedBox(height: 12),
        _buildCategoryItem(
          context,
          'Entretenimiento',
          'S/ 312',
          Colors.orange[600]!,
        ),
        const SizedBox(height: 12),
        _buildCategoryItem(context, 'Otros', 'S/ 313', Colors.purple[600]!),
      ],
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    String category,
    String amount,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            category,
            style: theme.textTheme.bodyLarge?.copyWith(fontSize: 14),
          ),
        ),
        Text(
          amount,
          style: theme.textTheme.titleMedium?.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
