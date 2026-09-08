import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:monify_app_mobile/data/services/local_app_store.dart';
import 'package:monify_app_mobile/screens/auth/CreateAccount.dart';
import 'package:monify_app_mobile/screens/home.dart';
import 'package:monify_app_mobile/themes/normal_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showLoginForm = false;
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NormalTheme.background,
      body: SafeArea(
        child: _showLoginForm ? _buildLoginForm() : _buildWelcome(),
      ),
    );
  }

  Widget _buildWelcome() => SingleChildScrollView(
    key: const ValueKey('welcome'),
    padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
    child: Column(
      children: [
        const SizedBox(height: 28),
        Image.asset(
          'assets/Monify_Logo_Recortado.png',
          height: 220,
          semanticLabel: 'Logo de Monify',
        ),
        const SizedBox(height: 12),
        const Text(
          'Monify',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            height: 1.08,
            fontWeight: FontWeight.w800,
            color: NormalTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Organiza tus gastos y avanza hacia tus metas.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: NormalTheme.textSecondary),
        ),
        const SizedBox(height: 30),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: NormalTheme.gold,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: NormalTheme.gold.withOpacity(.30),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '¡Bienvenido a Monify!',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 5),
              const Text(
                'Elige cómo quieres continuar.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _openLoginForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: NormalTheme.primaryGreenDark,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Iniciar sesión'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CreateAccount()),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: NormalTheme.textPrimary,
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    backgroundColor: Colors.white,
                  ),
                  child: const Text('Crear una cuenta'),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _buildLoginForm() => SingleChildScrollView(
    key: const ValueKey('loginForm'),
    padding: const EdgeInsets.fromLTRB(24, 30, 24, 32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: _isLoading ? null : _returnToWelcome,
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: 'Volver',
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 28),
        const Text(
          'Hola de nuevo',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          'Ingresa tus datos para continuar con tus finanzas.',
          style: TextStyle(fontSize: 15, color: NormalTheme.textSecondary),
        ),
        const SizedBox(height: 28),
        _AuthField(
          controller: _emailController,
          label: 'Correo electrónico',
          hint: 'nombre@correo.com',
          icon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
          enabled: !_isLoading,
        ),
        const SizedBox(height: 16),
        _AuthField(
          controller: _passwordController,
          label: 'Contraseña',
          hint: '••••••••',
          icon: Icons.lock_outline_rounded,
          obscureText: !_isPasswordVisible,
          enabled: !_isLoading,
          onSubmitted: (_) => _login(),
          suffix: IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            onPressed: () =>
                setState(() => _isPasswordVisible = !_isPasswordVisible),
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 16),
          _MessageBox(message: _errorMessage!),
        ],
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _login,
            child: _isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : const Text('Iniciar sesión'),
          ),
        ),
        const SizedBox(height: 18),
        Center(
          child: TextButton(
            onPressed: _isLoading
                ? null
                : () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CreateAccount()),
                  ),
            child: const Text('¿Aún no tienes una cuenta? Regístrate'),
          ),
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final coinHeight = (constraints.maxWidth * .56).clamp(190.0, 250.0);
            return SizedBox(
              key: const ValueKey('coin-rive-animation'),
              width: double.infinity,
              height: coinHeight,
              child: Semantics(
                label: 'Moneda animada de Monify',
                child: const RepaintBoundary(child: _CoinRiveAnimation()),
              ),
            );
          },
        ),
      ],
    ),
  );

  void _openLoginForm() {
    setState(() => _showLoginForm = true);
  }

  void _returnToWelcome() {
    setState(() => _showLoginForm = false);
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Completa tu correo y contraseña.');
      return;
    }
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final user = await LocalAppStore.instance.login(email, password);
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder<void>(
          pageBuilder: (_, _, _) =>
              Home(userName: user.nombre, userEmail: user.correo),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
        (_) => false,
      );
    } catch (_) {
      if (mounted) {
        setState(() => _errorMessage = 'Correo o contraseña incorrectos.');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class _CoinRiveAnimation extends StatefulWidget {
  const _CoinRiveAnimation();

  @override
  State<_CoinRiveAnimation> createState() => _CoinRiveAnimationState();
}

class _CoinRiveAnimationState extends State<_CoinRiveAnimation> {
  Artboard? _artboard;
  SingleAnimationPainter? _painter;
  File? _riveFile;

  @override
  void initState() {
    super.initState();
    _loadCoin();
  }

  Future<void> _loadCoin() async {
    try {
      final file = await File.asset(
        'assets/river/coin.riv',
        riveFactory: Factory.flutter,
      );
      if (file == null) return;
      final artboard = file.defaultArtboard();
      if (artboard == null) {
        file.dispose();
        return;
      }
      final painter = SingleAnimationPainter('anim19', fit: Fit.contain);
      if (!mounted) {
        painter.dispose();
        artboard.dispose();
        file.dispose();
        return;
      }

      setState(() {
        _riveFile = file;
        _artboard = artboard;
        _painter = painter;
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    _painter?.dispose();
    _artboard?.dispose();
    _riveFile?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final artboard = _artboard;
    final painter = _painter;
    if (artboard == null || painter == null) {
      return const Center(
        child: Icon(
          Icons.monetization_on_rounded,
          size: 118,
          color: NormalTheme.gold,
          semanticLabel: 'Moneda de Monify',
        ),
      );
    }

    return RiveArtboardWidget(artboard: artboard, painter: painter);
  }
}

class _AuthField extends StatelessWidget {
  const _AuthField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.suffix,
    this.onSubmitted,
  });
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final Widget? suffix;
  final ValueChanged<String>? onSubmitted;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enabled,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          suffixIcon: suffix,
        ),
      ),
    ],
  );
}

class _MessageBox extends StatelessWidget {
  const _MessageBox({required this.message});
  final String message;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: NormalTheme.dangerSoft,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        const Icon(Icons.error_outline_rounded, color: NormalTheme.danger),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(color: NormalTheme.danger),
          ),
        ),
      ],
    ),
  );
}
