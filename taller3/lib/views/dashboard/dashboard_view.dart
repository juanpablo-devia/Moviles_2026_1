import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_icons.dart';
import '../../themes/app_theme.dart';
import '../../widgets/dashboard_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D1A),
        elevation: 0,
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flag, color: AppTheme.secondaryColor),
            SizedBox(width: 8),
            Text(
              'Colombia API',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
              ).createShader(bounds),
              child: const Text(
                'Datos Abiertos de\nColombia',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Explora la información del país',
              style: TextStyle(color: Colors.white60, fontSize: 16),
            ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
              children: [
                DashboardCard(
                  icon: AppIcons.departments,
                  title: 'Departamentos',
                  subtitle: '32 departamentos',
                  accentColor: const Color(0xFF00E5FF),
                  route: '/departments',
                  onTap: () => context.go('/departments'),
                ),
                DashboardCard(
                  icon: AppIcons.presidents,
                  title: 'Presidentes',
                  subtitle: 'Historia presidential',
                  accentColor: const Color(0xFF7C4DFF),
                  route: '/presidents',
                  onTap: () => context.go('/presidents'),
                ),
                DashboardCard(
                  icon: AppIcons.naturalAreas,
                  title: 'Áreas Naturales',
                  subtitle: 'Parques y reservas',
                  accentColor: const Color(0xFF00E57A),
                  route: '/natural-areas',
                  onTap: () => context.go('/natural-areas'),
                ),
                DashboardCard(
                  icon: AppIcons.attractions,
                  title: 'Atracciones',
                  subtitle: 'Turismo nacional',
                  accentColor: const Color(0xFFFF4081),
                  route: '/touristic',
                  onTap: () => context.go('/touristic'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
