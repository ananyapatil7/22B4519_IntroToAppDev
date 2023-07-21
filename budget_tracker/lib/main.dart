// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BudgetTracker(),
    );
  }
}

class EntriesPage extends StatefulWidget {
  Map<String, double> entries;
  final VoidCallback showPopup;

  EntriesPage({required this.entries, required this.showPopup});

  @override
  EntriesPageState createState() => EntriesPageState();
}

class EntriesPageState extends State<EntriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Budget Tracker',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.teal[100],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: SizedBox(
          width: 350.0,
          child: ListView.builder(
            itemCount: widget.entries.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  width: 100.0,
                  margin: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.teal[100],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        'Total:  $budget',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                int entryIndex = index - 1;
                String category = widget.entries.keys.elementAt(entryIndex);
                double amount = widget.entries.values.elementAt(entryIndex);

                return Container(
                  width: 100.0,
                  margin: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.teal[100],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              category,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            ),
                            Spacer(),
                            Text(
                              '$amount',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.showPopup();
          });
        },
        backgroundColor: Colors.teal[100],
        child: Icon(Icons.add),
      ),
    );
  }
}

class BudgetTracker extends StatefulWidget {
  @override
  BudgetTrackerState createState() => BudgetTrackerState();
}

double budget = 0;

class BudgetTrackerState extends State<BudgetTracker> {
  String category = '';

  Map<String, double> entry = {};

  void addEntry(String category, double income) {
    setState(() {
      budget += income;
      this.category = category;
    });
  }

  void showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController incomeController = TextEditingController();
        String? selectedCategory;

        List<String> categories = [
          'Salary',
          'Grocery',
          'Bills',
          'Other Expense',
          'Other Income'
        ];

        return AlertDialog(
          title: Text('Add Income or Expense'),
          content: SizedBox(
            height: 107,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  onChanged: (String? category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  items: categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Select Category',
                  ),
                ),
                TextField(
                  controller: incomeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Enter Amount', fillColor: Colors.teal[100]),
                  cursorColor: Colors.teal[100],
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
              child: SizedBox(
                height: 40.0,
                width: 40.0,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  backgroundColor: Colors.teal[100],
                  child: Icon(Icons.close),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
              child: SizedBox(
                height: 40.0,
                width: 40.0,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(
                      () {
                        double income =
                            double.tryParse(incomeController.text) ?? 0.0;

                        if (selectedCategory == 'Grocery' ||
                            selectedCategory == 'Bills' ||
                            selectedCategory == 'Other Expense') income *= -1;

                        addEntry(category, income);
                        entry[selectedCategory!] = income;
                      },
                    );

                    Navigator.of(context).pop();
                  },
                  backgroundColor: Colors.teal[100],
                  child: Icon(Icons.check),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void navigateToEntriesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EntriesPage(
          entries: entry,
          showPopup: showPopup,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Budget Tracker',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.teal[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.person, size: 100.0),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'WELCOME BACK!',
                  style: TextStyle(fontSize: 50.0),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    width: 300.0,
                    decoration: BoxDecoration(
                      color: Colors.teal[100],
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(flex: 1),
                          Text(
                            'Total:  $budget',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,
                            ),
                          ),
                          Spacer(flex: 1),
                          IconButton(
                            onPressed: () {
                              navigateToEntriesPage();
                            },
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showPopup();
        },
        backgroundColor: Colors.teal[100],
        child: Icon(Icons.add),
      ),
    );
  }
}
