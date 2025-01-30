import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sl_salt/routes/route_name.dart';

class Datainputpage extends StatefulWidget {
  const Datainputpage({super.key});

  @override
  State<Datainputpage> createState() => _DatainputpageState();
}

class _DatainputpageState extends State<Datainputpage> {
  // Controllers for the input fields
  final TextEditingController morningReading1 = TextEditingController();
  final TextEditingController morningReading2 = TextEditingController();
  final TextEditingController eveningReading1 = TextEditingController();
  final TextEditingController eveningReading2 = TextEditingController();
  final TextEditingController dailyRainfall = TextEditingController();

  // Initial date as the current date
  DateTime selectedDate = DateTime.now();

  // Method to pick a date using the calendar popup
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000), // Earliest date selectable
      lastDate: DateTime(2100), // Latest date selectable
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

  @override
  Widget build(BuildContext context) {
    // Get current date in desired format
    String currentDate = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Input'),
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
            const Text(
              'Morning Readings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: morningReading1,
              decoration: const InputDecoration(
                labelText: 'Morning Reading 1',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: morningReading2,
              decoration: const InputDecoration(
                labelText: 'Morning Reading 2',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Evening Readings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: eveningReading1,
              decoration: const InputDecoration(
                labelText: 'Evening Reading 1',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: eveningReading2,
              decoration: const InputDecoration(
                labelText: 'Evening Reading 2',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Daily Rainfall',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: dailyRainfall,
              decoration: const InputDecoration(
                labelText: 'Rainfall (in mm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Save logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data Saved!')),
                    );
                  },
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Edit logic
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
