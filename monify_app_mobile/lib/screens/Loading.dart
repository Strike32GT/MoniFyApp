import 'dart:async';

import 'package:flutter/material.dart';
import 'package:monify_app_mobile/screens/home.dart';

class LoadingScreen extends StatefulWidget {
  
  final String userName;
  const LoadingScreen({Key? key, this.userName = 'Usuario'}) : super(key: key);

  @override 
  State<LoadingScreen> createState() => _LoadingScreenState(); 
}


class  _LoadingScreenState extends State<LoadingScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));


    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller, curve: Curves.easeInOut,
      ));

      _controller.forward();

      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
          );
      });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _scaleAnimation, 
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green[600],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            AnimatedBuilder(
              animation: _fadeAnimation, 
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Bienvenido, ${widget.userName}!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),
            AnimatedBuilder(
              animation: _fadeAnimation, 
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Tu cuenta ha sido creada exitosamente',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green[600]!),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _fadeAnimation, 
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Configurando tu experiencia ...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}