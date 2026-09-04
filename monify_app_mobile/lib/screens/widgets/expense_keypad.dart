import 'package:flutter/material.dart';
import 'package:monify_app_mobile/themes/normal_theme.dart';

class ExpenseKeypad extends StatelessWidget {
  final String value;
  final void Function(String key) onlyKeyPressed;
  final VoidCallback onBackspace;

  const ExpenseKeypad({
    Key? key,
    required this.value,
    required this.onlyKeyPressed,
    required this.onBackspace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow(['1', '2', '3']),
        const SizedBox(height: 10),
        _buildRow(['4', '5', '6']),
        const SizedBox(height: 10),
        _buildRow(['7', '8', '9']),
        const SizedBox(height: 10),
        _buildLastRow(),
      ],
    );
  }

  Widget _buildRow(List<String> keys) {
    return Row(
      children: keys.map((key) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _buildKeyButton(
              label: key,
              onTap: () => onlyKeyPressed(key),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLastRow() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _buildKeyButton(
              label: '.',
              onTap: () => onlyKeyPressed('.'),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _buildKeyButton(
              label: '0',
              onTap: () => onlyKeyPressed('0'),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _buildBackspaceButton(),
          ),
        ),
      ],
    );
  }

  Widget _buildKeyButton({required String label, required VoidCallback onTap}) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF0F2F1),
          foregroundColor: NormalTheme.textPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onBackspace,
        style: ElevatedButton.styleFrom(
          backgroundColor: NormalTheme.dangerSoft,
          foregroundColor: NormalTheme.danger,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Icon(Icons.backspace_outlined, size: 24),
      ),
    );
  }
}
