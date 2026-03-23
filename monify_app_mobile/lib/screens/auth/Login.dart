import 'package:flutter/material.dart';
import 'package:monify_app_mobile/screens/Loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override 
  State<LoginPage> createState()  => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  final String EmailInput = 'hola@gmail.com';
  final String PasswordInput = '123456';



  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopSection(),
            _buildLoginForm(),
          ],
        ),
      ),
    );
  }



  Widget _buildTopSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 80.0, bottom: 40.0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[600],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.monetization_on,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Monify',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Controla tus gastos en segundos',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          )
        ],
      ),
    );
  }


  Widget _buildLoginForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bienvenido',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ingresa a tu cuenta para continuar',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 30),
          _buildEmailInputField(),
          const SizedBox(height: 20),
          _buildPasswordInputField(),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Olvidaste tu password?',
                style: TextStyle(color: Colors.green[600]),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildLoginButton(),
          const SizedBox(height: 20),
          _buildSignUpSection(),
          const SizedBox(height: 30),
          _buildDemoInfo(),
        ],
      ),
    );
  }


  Widget _buildEmailInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Correo electronico',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'tu@email.com',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.green[600]!),
            ),
            prefixIcon: const Icon(Icons.email, color: Colors.grey),
          ),
        ),
      ],
    );
  }


  Widget _buildPasswordInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contraseña',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            hintText: '********',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.green[600]!),
            ),
            prefixIcon: const Icon(Icons.lock, color: Colors.grey),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _validateLogin, 
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[600],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Iniciar Sesion',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }



  Widget _buildSignUpSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No tienes cuenta?',
          style: TextStyle(color: Colors.grey[600]),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Registrate',
            style: TextStyle(
              color: Colors.green[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildDemoInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.green[600]!, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Cuenta Demo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Usuario: demo@monify.com',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );    
  }



  void _validateLogin() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showAlert('Por favor, completa todos los campos');
      return;
    }


    if (email == EmailInput && password == PasswordInput ) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoadingScreen(userName: 'Fernando')),
      );
    } else {
      _showAlert('Información incorrecta');
    }
  }


  void _showAlert(String message) {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alerta'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }



  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}