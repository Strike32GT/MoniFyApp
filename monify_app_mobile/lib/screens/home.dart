import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monify_app_mobile/screens/Estadistic.dart';
import 'package:monify_app_mobile/screens/historial.dart';
import 'package:monify_app_mobile/screens/perfil.dart';
import 'package:monify_app_mobile/screens/widgets/Notifications.dart';
import 'package:monify_app_mobile/screens/widgets/add_expense_modal.dart';
import 'package:monify_app_mobile/themes/normal_theme.dart';

class Home extends StatefulWidget {
  final String userName; //El nombre del usuario "Hola ${userName}""
  final String userEmail;
  const Home({Key? key, required this.userName, required this.userEmail})
    : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  List<Widget> get _pages => [
    HomePage(userName: widget.userName),
    const EstadisticPage(),
    const HistoryPage(),
    ProfilePage(userName: widget.userName, userEmail: widget.userEmail),
  ];

  void _openAddExpenseModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddExpenseModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: NormalTheme.primaryGreen,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: Container(
          height: 88,
          decoration: BoxDecoration(
            color: NormalTheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0.0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_outlined, 'Inicio', colorScheme),
              _buildNavItem(
                1,
                Icons.bar_chart_outlined,
                'Estadistica',
                colorScheme,
              ),
              //_buildAddButton(),
              Transform.translate(
                offset: const Offset(0.0, -26.0),
                child: _buildAddButton(colorScheme),
              ),
              _buildNavItem(
                2,
                Icons.history_outlined,
                'Historial',
                colorScheme,
              ),
              _buildNavItem(3, Icons.person_outline, 'Perfil', colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData icon,
    String label,
    ColorScheme colorScheme,
  ) {
    final isActive = _currentIndex == index;
    final activeColor = colorScheme.primary;
    final inactiveColor = NormalTheme.textSecondary;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: SizedBox(
        width: 72,
        height: 72,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: isActive ? activeColor : inactiveColor),
            const SizedBox(height: 5),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: isActive ? activeColor : inactiveColor,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(ColorScheme colorScheme) {
    return GestureDetector(
      onTap: _openAddExpenseModal,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withOpacity(0.55),
              blurRadius: 15,
              spreadRadius: 3,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: colorScheme.primary.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(Icons.add, size: 32, color: Colors.white),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String userName;
  const HomePage({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context),
          _buildBalanceCard(context),
          _buildQuickActions(context),
          _buildRecentTransactions(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: NormalTheme.primaryGreen,
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
              Text(
                'Hola ${userName}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  List<NotificationItem> notifications = [
                    NotificationItem(
                      title: '¡Nuevo logro desbloqueado!',
                      description:
                          'Has completado tu primer reto de ahorro semanal',
                      time: 'Hace 2 horas',
                      type: NotificationType.achievement,
                      isRead: false,
                    ),

                    NotificationItem(
                      title: '¡Nuevo logro desbloqueado!',
                      description:
                          'Has gastado el 75% de tu presupuesto semanal',
                      time: 'Hace 4 horas',
                      type: NotificationType.success,
                      isRead: true,
                    ),

                    NotificationItem(
                      title: 'Nuevo reto disponible',
                      description:
                          'Participa en el reto "Sin gastos impulsivos"',
                      time: 'Hace 2 horas',
                      type: NotificationType.achievement,
                      isRead: true,
                    ),
                  ];

                  NotificationWdgt.showNotificationMenu(
                    context,
                    notifications: notifications,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Presupuesto Actual',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const Text(
            'S/14.50',
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
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
              _buildBalanceItem(
                'Ingresos',
                'S/500.00',
                Colors.green,
                Icons.arrow_upward,
              ),
              _buildBalanceItem(
                'Gastos',
                'S/485.50',
                Colors.red,
                Icons.arrow_downward,
              ),
              _buildBalanceItem(
                'Ahorro',
                'S/14.50',
                Colors.blue,
                Icons.savings,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceItem(
    String title,
    String amount,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
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

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(context, 'Enviar', Icons.send),
          _buildActionButton(context, 'Recibir', Icons.call_received),
          _buildActionButton(context, 'Pagar', Icons.payment),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String label, IconData icon) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? Colors.white : Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.green[600], size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: theme.textTheme.bodyMedium?.color,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTransactions(BuildContext context) {
    final textColor = Theme.of(context).textTheme.titleLarge?.color;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transacciones Recientes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 16),
          _buildTransactionItem(
            'Supermercado',
            'S/85.50',
            Icons.shopping_cart,
            Colors.red,
          ),
          _buildTransactionItem(
            'Salario',
            'S/500.00',
            Icons.work,
            Colors.green,
          ),
          _buildTransactionItem(
            'Transporte',
            'S/20.00',
            Icons.directions_bus,
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
    String title,
    String amount,
    IconData icon,
    Color color,
  ) {
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
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
