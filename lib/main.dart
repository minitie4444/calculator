import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _currentInput = "0"; // What the user is typing
  String _previousInput = ""; // To store the value before an operation
  String _operation = ""; // The current operation (+, -, ×, ÷)

Widget _buildButton(String value) {
  return Expanded(
    child: ElevatedButton(
      onPressed: () {
        setState(() {
          // Handle number input
          if (value == "0" || value == "1" || value == "2" || value == "3" || 
              value == "4" || value == "5" || value == "6" || 
              value == "7" || value == "8" || value == "9") {
            if (_currentInput == "0") {
              _currentInput = value; // Replace 0 with the first number
            } else {
              _currentInput += value; // Append the number
            }
          }

          // Handle operations
          if (value == "+" || value == "-" || value == "×" || value == "÷") {
            _previousInput = _currentInput; // Store the first number
            _operation = value; // Store the operation
            _currentInput = "0"; // Reset for the next number
          }

          // Handle equals (=)
          if (value == "=") {
            if (_previousInput.isNotEmpty && _operation.isNotEmpty) {
              double num1 = double.parse(_previousInput);
              double num2 = double.parse(_currentInput);
              double result = 0;

              if (_operation == "+") {
                result = num1 + num2;
              } else if (_operation == "-") {
                result = num1 - num2;
              } else if (_operation == "×") {
                result = num1 * num2;
              } else if (_operation == "÷") {
                if (num2 != 0) {
                  result = num1 / num2;
                } else {
                  _currentInput = "Error"; // Handle division by zero
                  return;
                }
              }

              // Display the result
              _currentInput = result.toString();
              _previousInput = "";
              _operation = "";
            }
          }

          // Handle clear (C)
          if (value == "C") {
            _currentInput = "0";
            _previousInput = "";
            _operation = "";
          }
        });
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        value,
        style: TextStyle(fontSize: 40),
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "GESP CALCULATOR",
          style: TextStyle(
            color: Colors.pink,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              color: Colors.black,
              child: Text(
                _currentInput,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("÷"),
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("×"),
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-"),
                ],
              ),
              Row(
                children: [
                  _buildButton("C"),
                  _buildButton("0"),
                  _buildButton("="),
                  _buildButton("+"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}