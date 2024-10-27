import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LoanCalculatorProvider(),
      child: LoanCalculatorApp(),
    ),
  );
}

class LoanCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Loan Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoanCalculatorScreen(),
    );
  }
}

class LoanCalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loanProvider = Provider.of<LoanCalculatorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: const Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Center(
            child: Text(
              'Loan Calculator',
              style: TextStyle(
                fontFamily: 'CeraPro',
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: const Text(
                'Enter amount',
                style: TextStyle(
                  fontFamily: 'CeraPro',
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
              hint: 'Amount',
              onChanged: (value) {
                loanProvider.updateAmount(value);
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              'Enter number of months',
              style: TextStyle(
                fontFamily: 'CeraPro',
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
            Column(
              children: [
                Slider(
                  min: 1,
                  max: 60,
                  value: loanProvider.months.toDouble(),
                  divisions: 59,
                  label: '${loanProvider.months.toInt()} months',
                  onChanged: (value) {
                    loanProvider.updateMonths(value.toInt());
                  },
                  activeColor: const Color.fromARGB(255, 0, 26, 255),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1 month',
                      style: TextStyle(
                        fontFamily: 'CeraPro',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '60 months',
                      style: TextStyle(
                        fontFamily: 'CeraPro',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            CustomTextField(
              label: const Text(
                'Enter % per month',
                style: TextStyle(
                  fontFamily: 'CeraPro',
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
              hint: 'Percent',
              onChanged: (value) {
                loanProvider.updatePercent(value);
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
            ),
            const SizedBox(height: 20),

            // display result
            if (loanProvider.result != null)
              Padding(
                padding: const EdgeInsets.only(top: 64.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 238, 237, 237),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 238, 237, 237),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(12)),
                          ),
                          child: const Center(
                            child: Text(
                              'You will pay the approximate amount monthly:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'CeraPro',
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity, // full width
                          padding: const EdgeInsets.all(16.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12)),
                          ),
                          child: Center(
                            child: Text(
                              '${loanProvider.result?.toStringAsFixed(2) ?? "0.00"} €',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontFamily: 'CeraPro',
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 0, 26, 255),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 24),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  loanProvider.calculateMonthlyPayment();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 26, 255),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  minimumSize:
                      const Size(double.infinity, 48), // button to full width
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Calculate',
                  style: TextStyle(
                    fontFamily: 'CeraPro',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
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

class CustomTextField extends StatelessWidget {
  final Widget label;
  final String hint;
  final ValueChanged<String> onChanged;
  final List<TextInputFormatter> inputFormatters;

  const CustomTextField({
    required this.label,
    required this.hint,
    required this.onChanged,
    required this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label,
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontFamily: 'CeraPro',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 223, 214, 214)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 54, 53, 53), width: 2),
            ),
          ),
          onChanged: onChanged,
          inputFormatters: inputFormatters,
        ),
      ],
    );
  }
}

class LoanCalculatorProvider with ChangeNotifier {
  double _amount = 0;
  int _months = 1;
  double _percent = 0;
  double? result;

  void updateAmount(String value) {
    _amount = double.tryParse(value) ?? 0;
    notifyListeners();
  }

  void updateMonths(int value) {
    _months = value;
    notifyListeners();
  }

  void updatePercent(String value) {
    _percent = double.tryParse(value) ?? 0;
    notifyListeners();
  }

  void calculateMonthlyPayment() {
    if (_amount > 0 && _months > 0 && _percent > 0) {
      double monthlyRate = _percent / 100;
      result = (_amount * monthlyRate) / (1 - pow((1 + monthlyRate), -_months));
      notifyListeners();
    }
  }

  int get months => _months;
}
