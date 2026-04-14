import 'package:flutter/material.dart';
import 'package:monify_app_mobile/screens/widgets/expense_keypad.dart';

class AddExpenseModal extends StatefulWidget {
  const AddExpenseModal({Key? key}) : super(key: key);

  @override
  State<AddExpenseModal> createState() => _AddExpenseModalState();


}

class _AddExpenseModalState extends State<AddExpenseModal> {
  String _amount = '0.00';
  String _selectedCategory = 'Comida';
  final TextEditingController _descriptionController = TextEditingController();


  final List<Map<String,dynamic>> _categories = [
    {'label': 'Comida', 'icon' : Icons.fastfood},
    {'label': 'Transportes', 'icon' : Icons.directions_bus},
    {'label': 'Compras', 'icon' : Icons.shopping_bag},
    {'label': 'Salud', 'icon' : Icons.medication},
  ];


  void _onKeyPressed(String key) {
    setState(() {
      if (key == '.') {
        if(_amount.contains('.')) return;
        _amount += '.';
        return;
      }


      if(_amount == '0.00' || _amount == '0') {
        _amount = key;
      } else {
        _amount += key;
      }
    });
  }


  void _onBackspace() {
    setState(() {
      if (_amount.isNotEmpty) {
        _amount = _amount.substring(0, _amount.length -1);
      }

      if (_amount.isEmpty) {
        _amount = '0.00';
      }
    });
  }


  void _saveExpense() {
    final description = _descriptionController.text.trim();


    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text('Gasto agregado'),
        content: Text(
          'Monto: S/ $_amount'
          'Categoria: $_selectedCategory'
          'Descripcion: ${description.isEmpty ? "Sin Descripcion" : description}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          )
        ],
      )
    );
  }



  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        )
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Nuevo gasto',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'S/ $_amount',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D2433),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'CATEGORIA',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 86,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category['label'];


                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category['label']!;
                      });
                    },
                    child: Container(
                      width: 72,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFFFF1F1) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? Colors.redAccent : Colors.grey.shade200,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category['icon']! as IconData,
                            size: 22,
                            color: isSelected ? Colors.redAccent : Colors.grey[700],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            category['label']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              color: isSelected ? Colors.redAccent : Colors.grey[700],
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Descripcion (opcional)',
                filled: true,
                fillColor: Colors.grey[50],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(height: 18),
            ExpenseKeypad(
              value: _amount, 
              onlyKeyPressed: _onKeyPressed, 
              onBackspace: _onBackspace,
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _saveExpense,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[100],
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Agregar Gasto',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}