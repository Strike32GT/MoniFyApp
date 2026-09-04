import 'package:flutter/material.dart';
import 'package:monify_app_mobile/themes/dark_theme.dart';
import 'package:monify_app_mobile/themes/normal_theme.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildSearchBar(context),
            const SizedBox(height: 16),
            _buildFilterButtons(context),
            const SizedBox(height: 20),
            _buildDailySummary(context),
            const SizedBox(height: 16),
            _buildTransactionList(context),
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
            'Registro completo',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Historial',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Total (hoy)',
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar gastos...',
          prefixIcon: Icon(
            Icons.search,
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildFilterButton(context, 'Hoy', 0),
          const SizedBox(width: 10),
          _buildFilterButton(context, 'Semana', 1),
          const SizedBox(width: 10),
          _buildFilterButton(context, 'Mes', 2),
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
          height: 42,
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

  Widget _buildDailySummary(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSummaryItem(context, 'Gastos', 'S/35.50', Colors.red),
            _buildSummaryItem(context, 'Ingresos', 'S/0.00', Colors.green),
            _buildSummaryItem(
              context,
              'Balance',
              'S/35.50',
              theme.textTheme.titleLarge?.color ?? Colors.grey[700]!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    String amount,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(label, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12)),
        const SizedBox(height: 4),
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

  Widget _buildTransactionList(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transacciones',
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildTransactionGroup(context, 'Hoy', [
            _buildTransactionItem(
              context,
              'Almuerzo restaurante',
              '-S/18.50',
              Icons.lunch_dining,
              Colors.red,
              '13:20',
              'Comida',
              Colors.redAccent,
            ),
            _buildTransactionItem(
              context,
              'Bus linea 3',
              '-S/5.00',
              Icons.directions_bus,
              Colors.red,
              '08:15',
              'Transporte',
              Colors.green,
            ),
            _buildTransactionItem(
              context,
              'Snacks tienda',
              '-S/12.00',
              Icons.shopping_bag,
              Colors.red,
              '10:30',
              'Compras',
              Colors.purpleAccent,
            ),
          ], isDark),
          const SizedBox(height: 20),
          _buildTransactionGroup(context, 'Ayer', [
            _buildTransactionItem(
              context,
              'Supermercado',
              'S/85.50',
              Icons.shopping_cart,
              Colors.red,
              '18:45',
              null,
              null,
            ),
            _buildTransactionItem(
              context,
              'Salario',
              'S/500.00',
              Icons.work,
              Colors.green,
              '09:00',
              null,
              null,
            ),
          ], false),
        ],
      ),
    );
  }

  Widget _buildTransactionGroup(
    BuildContext context,
    String date,
    List<Widget> transactions,
    bool groupedCard,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        if (groupedCard)
          Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Column(children: transactions),
          )
        else
          ...transactions,
      ],
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    String title,
    String amount,
    IconData icon,
    Color color,
    String time,
    String? badgeLabel,
    Color? badgeColor,
  ) {
    final theme = Theme.of(context);
    final isExpense = amount.startsWith('-') || color == Colors.red;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.14),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(fontSize: 16),
      ),
      subtitle: Row(
        children: [
          if (badgeLabel != null && badgeColor != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: badgeColor.withOpacity(0.18),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                badgeLabel,
                style: TextStyle(
                  color: badgeColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(time, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12)),
        ],
      ),
      trailing: Text(
        amount,
        style: TextStyle(
          color: isExpense ? Colors.red : Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
