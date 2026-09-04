import 'package:flutter/material.dart';
import 'package:monify_app_mobile/data/services/local_app_store.dart';
import 'package:monify_app_mobile/themes/normal_theme.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  DateTime? _birthDate;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: NormalTheme.background,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 14, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: _isLoading ? null : () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_rounded),
              tooltip: 'Volver',
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
              decoration: BoxDecoration(
                color: NormalTheme.gold,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Crea tu cuenta',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/Monify_Logo_Recortado.png',
                        height: 74,
                        semanticLabel: 'Logo de Monify',
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Empieza a cuidar tu dinero desde hoy.',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            const Text(
              'Tus datos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: NormalTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Esta aplicación está disponible solo para mayores de 18 años.',
              style: TextStyle(fontSize: 14, color: NormalTheme.textSecondary),
            ),
            const SizedBox(height: 22),
            _FormField(
              controller: _nameController,
              label: 'Nombre completo',
              hint: '¿Cómo te llamamos?',
              icon: Icons.person_outline_rounded,
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),
            _FormField(
              controller: _emailController,
              label: 'Correo electrónico',
              hint: 'nombre@correo.com',
              icon: Icons.mail_outline_rounded,
              type: TextInputType.emailAddress,
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),
            _buildBirthDateField(),
            const SizedBox(height: 16),
            _FormField(
              controller: _passwordController,
              label: 'Contraseña',
              hint: 'Mínimo 6 caracteres',
              icon: Icons.lock_outline_rounded,
              obscure: !_showPassword,
              enabled: !_isLoading,
              suffix: IconButton(
                icon: Icon(
                  _showPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: () => setState(() => _showPassword = !_showPassword),
              ),
            ),
            const SizedBox(height: 16),
            _FormField(
              controller: _confirmPasswordController,
              label: 'Confirmar contraseña',
              hint: 'Repite tu contraseña',
              icon: Icons.verified_user_outlined,
              obscure: !_showConfirmPassword,
              enabled: !_isLoading,
              suffix: IconButton(
                icon: Icon(
                  _showConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: () => setState(
                  () => _showConfirmPassword = !_showConfirmPassword,
                ),
              ),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: NormalTheme.dangerSoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      color: NormalTheme.danger,
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: NormalTheme.danger),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _register,
                child: _isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Crear mi cuenta'),
              ),
            ),
            const SizedBox(height: 14),
            Center(
              child: TextButton(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
                child: const Text('Ya tengo una cuenta'),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _buildBirthDateField() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Fecha de nacimiento',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      const SizedBox(height: 8),
      InkWell(
        onTap: _isLoading ? null : _selectBirthDate,
        borderRadius: BorderRadius.circular(16),
        child: InputDecorator(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.cake_outlined),
          ),
          child: Text(
            _birthDate == null
                ? 'Selecciona tu fecha de nacimiento'
                : _formatDate(_birthDate!),
            style: TextStyle(
              color: _birthDate == null
                  ? NormalTheme.textSecondary
                  : NormalTheme.textPrimary,
            ),
          ),
        ),
      ),
    ],
  );

  Future<void> _selectBirthDate() async {
    final today = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate:
          _birthDate ?? DateTime(today.year - 18, today.month, today.day),
      firstDate: DateTime(1900),
      lastDate: today,
      helpText: 'FECHA DE NACIMIENTO',
    );
    if (date != null) setState(() => _birthDate = date);
  }

  Future<void> _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _birthDate == null) {
      setState(
        () => _errorMessage = 'Completa todos los campos para continuar.',
      );
      return;
    }
    if (!_isAdult(_birthDate!)) {
      setState(
        () =>
            _errorMessage = 'Debes tener 18 años o más para crear una cuenta.',
      );
      return;
    }
    if (!email.contains('@')) {
      setState(() => _errorMessage = 'Ingresa un correo electrónico válido.');
      return;
    }
    if (password.length < 6) {
      setState(
        () => _errorMessage = 'La contraseña debe tener al menos 6 caracteres.',
      );
      return;
    }
    if (password != _confirmPasswordController.text) {
      setState(() => _errorMessage = 'Las contraseñas no coinciden.');
      return;
    }
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await LocalAppStore.instance.register(
        nombre: name,
        correo: email,
        password: password,
      );
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Cuenta creada'),
          content: const Text(
            'Tu cuenta está lista. Ya puedes iniciar sesión.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continuar'),
            ),
          ],
        ),
      );
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (error) {
      if (mounted) {
        setState(
          () =>
              _errorMessage = error.toString().replaceFirst('Exception: ', ''),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  bool _isAdult(DateTime birthDate) {
    final today = DateTime.now();
    var age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age >= 18;
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.type,
    this.obscure = false,
    this.enabled = true,
    this.suffix,
  });
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? type;
  final bool obscure;
  final bool enabled;
  final Widget? suffix;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        keyboardType: type,
        obscureText: obscure,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          suffixIcon: suffix,
        ),
      ),
    ],
  );
}
