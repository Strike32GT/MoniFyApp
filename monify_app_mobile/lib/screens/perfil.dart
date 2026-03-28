import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
    const ProfilePage({Key? key}) : super(key: key);


    @override 
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[50],
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        _buildHeader(),
                        _buildUserProfileCard(),
                        _buildCurrentStreakCard(),
                        _buildWeeklyProgress(),
                        _buildAchievementsSection(),
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
                        'MI ESPACIO',
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
                                'Perfil & Logros',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            IconButton(
                                icon: Icon(Icons.settings, color: Colors.grey[600]),
                                onPressed: () {},
                            )
                        ],
                    ),
                ],
            ),
        );
    }


    Widget _buildUserProfileCard() {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Card(
                color: Colors.green[600],
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Row(
                                children: [
                                    Stack(
                                        children: [
                                            CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.green[400],
                                                child: const Text(
                                                    'F',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 28,
                                                        fontWeight: FontWeight.bold,
                                                    ),
                                                ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Container(
                                                    padding: const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                    ),
                                                    child: Text(
                                                        '4',
                                                        style: TextStyle(
                                                            color: Colors.green[600],
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                        ),
                                                    ),
                                                ),
                                            )
                                        ],
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                                const Text(
                                                    'Fernando Mas',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                    ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                    'maspinto@gmail.com',
                                                    style: TextStyle(
                                                        color: Colors.white.withOpacity(0.8),
                                                        fontSize: 14,
                                                    ),
                                                ),
                                                const SizedBox(height: 8),
                                                const Text(
                                                    'Nivel 4 - Ahorrador Pro',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    const Text(
                                        'Progreso a nivel 5',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                        ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                        height: 8,
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: 0.625,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(4),
                                                ),
                                            ),
                                        ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                        '1,250 / 2,000XP',
                                        style: TextStyle(
                                            color: Colors.white.withOpacity(0.8),
                                            fontSize: 12,
                                        ),
                                    ),
                                ],
                            ),
                        ],
                    ),
                    ),
            ),
        );
    }



    Widget _buildCurrentStreakCard() {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            const Text(
                                'Racha actual',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                                children: [
                                    Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                            color: Colors.orange[100],
                                            shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                            Icons.local_fire_department,
                                            color: Colors.orange[600],
                                            size: 32,
                                        ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                                const Text(
                                                    '3 dias',
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight: FontWeight.bold,
                                                    ),
                                                ),
                                                const Text(
                                                    'dentro del presupuesto',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                ],
                            ),
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
                                                '¡Sigue así! Solo 4 días más para tu próximo logro',
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
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }



    Widget _buildWeeklyProgress() {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        children: [
                            const Text(
                                '5/7 días esta semana dentro del presupuesto',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                     _buildDayCircle('L', true),
                                    _buildDayCircle('M', true),
                                    _buildDayCircle('X', true),
                                    _buildDayCircle('J', true),
                                    _buildDayCircle('V', true),
                                    _buildDayCircle('S', false),
                                    _buildDayCircle('D', false),
                                ],
                            )
                        ],
                    ),
                ),
            ),
        );
    }



    Widget _buildDayCircle(String day, bool completed) {
        return Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: completed ? Colors.green[600] : Colors.grey[300],
                shape: BoxShape.circle,
            ),
            child: Center(
                child: completed
                ? Icon(Icons.check, color: Colors.white, size: 20)
                : Icon(Icons.close, color: Colors.white, size: 20)
            ),
        );
    }


    Widget _buildAchievementsSection() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Retos activos'),
            const SizedBox(height: 12),
            _buildActiveChallanges(),
            const SizedBox(height: 24),
            _buildSectionTitle('Insignias'),
            const SizedBox(height: 12),
            _buildBadges(),
          ],
        ),
      );
    }

    Widget _buildSectionTitle(String title) {
      return Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      );
    }



    Widget _buildActiveChallanges() {
      return Column(
        children: [
          _buildChallangeCard(
            title: 'Ahorro semanal',
            description: 'Ahorra S/200 esta semana',
            progress: 0.75,
            progressText: 'S/150 / S/200',
            color: Colors.blue[600]!
          ),
          const SizedBox(height: 12),
          _buildChallangeCard(
            title: 'Sin gastos Impulsivos',
            description: 'Evita compras innecesarias por 5 dias',
            progress: 0.6,
            progressText: '3 o 5 dias',
            color: Colors.orange[600]!
          ),
        ],
      );
    }


    Widget _buildChallangeCard({required String title, required String description, required double progress, required String progressText, required Color color}) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                    child: Icon(Icons.flag, color: color, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: FractionallySizedBox(
                      alignment: AlignmentGeometry.centerLeft,
                      widthFactor: progress,
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    progressText,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }


    Widget _buildBadges() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBadge(Icons.star, 'Primer paso', Colors.amber[600]!, true),
              _buildBadge(Icons.trending_up, 'En ascenso', Colors.green[600]!, true),
               _buildBadge(Icons.emoji_events, 'Campeon', Colors.purple[600]!, true),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               _buildBadge(Icons.local_fire_department, 'En fuego', Colors.orange[600]!, false),
               _buildBadge(Icons.military_tech, 'Experto', Colors.blue[600]!, false),
               _buildBadge(Icons.diamond, 'Diamante', Colors.grey[400]!, false),
            ],
          ),
        ],
      );
    }


    Widget _buildBadge(IconData icon, String title, Color color, bool isUnlocked) {
      return Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isUnlocked ? color.withOpacity(0.2) : Colors.grey[200],
              shape: BoxShape.circle,
              border: Border.all(
                color: isUnlocked ? color : Colors.grey[300]!,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: isUnlocked ? color : Colors.grey[400],
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isUnlocked ? Colors.black87 : Colors.grey[500],
            ),
          ),
        ],
      );
    } 






    //

}