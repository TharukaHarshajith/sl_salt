import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sl_salt/bloc/data/data_bloc.dart';
import 'package:sl_salt/routes/route_name.dart';

class Datainputpage extends StatefulWidget {
  const Datainputpage({super.key});

  @override
  State<Datainputpage> createState() => _DatainputpageState();
}

class _DatainputpageState extends State<Datainputpage> {
  final TextEditingController morningReading1Controller = TextEditingController();
  final TextEditingController morningReading2Controller = TextEditingController();
  final TextEditingController eveningReading1Controller = TextEditingController();
  final TextEditingController eveningReading2Controller = TextEditingController();
  final TextEditingController dailyRainfallController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  String get formattedDate {
    return DateFormat('dd MMM yyyy').format(selectedDate);
  }

  double _parseDouble(String value) {
    return double.tryParse(value) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final String boxName = ModalRoute.of(context)!.settings.arguments as String? ?? 'Unknown Box';
    print(boxName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Data Input - $boxName'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, RouteNames.home);
          },
        ),
        actions: [
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Morning Readings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: morningReading1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Morning Reading 1', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: morningReading2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Morning Reading 2', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            const Text('Evening Readings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: eveningReading1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Evening Reading 1', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: eveningReading2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Evening Reading 2', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            const Text('Daily Rainfall', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: dailyRainfallController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Rainfall (in mm)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      context.read<DataBloc>().add(
                            SaveDataEvent(
                              morningReading1: _parseDouble(morningReading1Controller.text),
                              morningReading2: _parseDouble(morningReading2Controller.text),
                              eveningReading1: _parseDouble(eveningReading1Controller.text),
                              eveningReading2: _parseDouble(eveningReading2Controller.text),
                              dailyRainfall: _parseDouble(dailyRainfallController.text),
                              pool: boxName,
                              dateOfReading: selectedDate,
                              user: user.uid, // Pass the logged-in user's ID
                            ),
                          );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data Saved!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error: No user logged in')),
                      );
                    }
                    print(boxName);
                  },
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Edit Mode Enabled!')),
                    );
                  },
                  child: const Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
