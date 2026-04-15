import 'package:flutter/material.dart';
import 'package:monify_app_mobile/screens/widgets/Configuration.dart';
import 'package:monify_app_mobile/themes/dark_theme.dart';

class ProfilePage extends StatelessWidget {
  final String userName;
  final String userEmail;

  const ProfilePage({
    Key? key,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

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
            _buildUserProfileCard(context),
            _buildCurrentStreakCard(context),
            _buildWeeklyProgress(context),
            _buildAchievementsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MI ESPACIO',
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
                'Perfil & Logros',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: isDark ? DarkTheme.surface : Colors.transparent,
                ),
                icon: Icon(Icons.settings, color: theme.textTheme.bodyMedium?.color),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfigurationPage(
                        userName: userName,
                        userEmail: userEmail,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfileCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.green[600],
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.24 : 0.12),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white.withOpacity(0.18),
                      child: Text(
                        userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFC928),
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Center(
                          child: Text(
                            '4',
                            style: TextStyle(
                              color: Color(0xFF1D2433),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userEmail,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Color(0xFFFFC928), size: 16),
                          const SizedBox(width: 6),
                          Text(
                            'Nivel 4 - Ahorrador Pro',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              'Progreso a nivel 5',
              style: TextStyle(
                color: Colors.white.withOpacity(0.95),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: 0.625,
                minHeight: 8,
                backgroundColor: Colors.white.withOpacity(0.24),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFC928)),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1,250 / 2,000 XP',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.95),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '62%',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.95),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStreakCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Racha actual',
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
                  ),
                  if (isDark)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B3B20),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'En racha',
                        style: TextStyle(
                          color: Color(0xFFFFC928),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 78,
                    height: 78,
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Icon(
                      Icons.local_fire_department,
                      color: Colors.orange[600],
                      size: 38,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isDark ? '3 dias dentro del\npresupuesto' : '3 dias',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: isDark ? 18 : 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (!isDark)
                          Text(
                            'dentro del presupuesto',
                            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
                          ),
                        if (isDark) ...[
                          const SizedBox(height: 4),
                          Text(
                            'iSigue asi! Solo 4 dias mas para tu proximo logro',
                            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Mejor racha: 7 dias',
                            style: TextStyle(
                              color: Colors.green[400],
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              if (!isDark) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.emoji_events, color: Colors.green[600], size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Sigue asi! Solo 4 dias mas para tu proximo logro',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Mejor racha: 7 dias',
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyProgress(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '5/7 dias esta semana dentro del presupuesto',
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDayCircle(context, 'L', true),
                  _buildDayCircle(context, 'M', true),
                  _buildDayCircle(context, 'X', true),
                  _buildDayCircle(context, 'J', true),
                  _buildDayCircle(context, 'V', true),
                  _buildDayCircle(context, 'S', false),
                  _buildDayCircle(context, 'D', false),
                ],
              ),
              if (isDark) ...[
                const SizedBox(height: 10),
                Text(
                  '5/7 dias esta semana dentro del presupuesto',
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayCircle(BuildContext context, String day, bool completed) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final inactiveColor = isDark ? const Color(0xFF354158) : Colors.grey[300]!;

    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: completed ? Colors.green[600] : inactiveColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: completed
                ? const Icon(Icons.check, color: Colors.white, size: 20)
                : const Icon(Icons.close, color: Colors.white, size: 20),
          ),
        ),
        if (isDark) ...[
          const SizedBox(height: 6),
          Text(
            day,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11),
          ),
        ],
      ],
    );
  }

  Widget _buildAchievementsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(context, 'Retos activos'),
          const SizedBox(height: 12),
          _buildActiveChallenges(context),
          const SizedBox(height: 24),
          _buildSectionTitle(context, 'Insignias'),
          const SizedBox(height: 12),
          _buildBadges(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildActiveChallenges(BuildContext context) {
    return Column(
      children: [
        _buildChallengeCard(
          context,
          title: 'Ahorro semanal',
          description: 'Ahorra S/200 esta semana',
          progress: 0.75,
          progressText: 'S/150 / S/200',
          color: Colors.blue[600]!,
        ),
        const SizedBox(height: 12),
        _buildChallengeCard(
          context,
          title: 'Sin gastos impulsivos',
          description: 'Evita compras innecesarias por 5 dias',
          progress: 0.6,
          progressText: '3 o 5 dias',
          color: Colors.orange[600]!,
        ),
      ],
    );
  }

  Widget _buildChallengeCard(
    BuildContext context, {
    required String title,
    required String description,
    required double progress,
    required String progressText,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.flag, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              progressText,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadges(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBadge(context, Icons.star, 'Primer paso', Colors.amber[600]!, true),
            _buildBadge(context, Icons.trending_up, 'En ascenso', Colors.green[600]!, true),
            _buildBadge(context, Icons.emoji_events, 'Campeon', Colors.purple[600]!, true),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBadge(context, Icons.local_fire_department, 'En fuego', Colors.orange[600]!, false),
            _buildBadge(context, Icons.military_tech, 'Experto', Colors.blue[600]!, false),
            _buildBadge(context, Icons.diamond, 'Diamante', Colors.grey[400]!, false),
          ],
        ),
      ],
    );
  }

  Widget _buildBadge(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    bool isUnlocked,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: isUnlocked ? color.withOpacity(isDark ? 0.18 : 0.12) : theme.dividerColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: isUnlocked ? color : theme.dividerColor,
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            color: isUnlocked ? color : theme.textTheme.bodyMedium?.color?.withOpacity(0.55),
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isUnlocked
                ? theme.textTheme.bodyLarge?.color
                : theme.textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }
}
