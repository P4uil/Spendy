import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  int selectedSegment = 0; // 0 - Income, 1 - Expense
  String selectedCategory = "Salary"; // Начальная категория

  final Map<int, List<Map<String, dynamic>>> categories = {
    0: [
      // Для "Income"
      {"name": "Salary", "icon": CupertinoIcons.money_dollar_circle_fill},
      {"name": "Loan", "icon": CupertinoIcons.building_2_fill},
      {"name": "Investments", "icon": CupertinoIcons.chart_bar_alt_fill},
      {"name": "Other", "icon": CupertinoIcons.question_circle_fill},
    ],
    1: [
      // Для "Expense"
      {"name": "Food", "icon": CupertinoIcons.cart_fill},
      {"name": "Transport", "icon": CupertinoIcons.car_detailed},
      {"name": "Shopping", "icon": CupertinoIcons.bag_fill},
      {"name": "Entertainment", "icon": CupertinoIcons.film_fill},
      {"name": "Other", "icon": CupertinoIcons.question_circle_fill},
    ],
  };

  final TextEditingController noteController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedCategory = categories[selectedSegment]![0]["name"] as String;
  }

  @override
  void dispose() {
    noteController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Add Transaction",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Выбор категории с иконками
            Padding(
              padding: EdgeInsets.all(1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Заголовок "Transaction Type"
                  Text(
                    "Transaction Type",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Переключатель Income / Expense
                  Padding(
                    padding: EdgeInsets.zero,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: double.infinity,
                        child: CupertinoSegmentedControl<int>(
                          borderColor: Colors.transparent,
                          selectedColor: selectedSegment == 0
                              ? Colors.indigo[400]
                              : Colors.red[900],
                          unselectedColor: Colors.white,
                          padding: EdgeInsets.zero,
                          children: {
                            0: _buildSegment("Income", selectedSegment == 0),
                            1: _buildSegment("Expense", selectedSegment == 1),
                          },
                          groupValue: selectedSegment,
                          onValueChanged: (value) {
                            setState(() {
                              selectedSegment = value;
                              selectedCategory =
                                  categories[selectedSegment]!.first["name"];
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24),

                  // Заголовок "Category"
                  Text(
                    "Category",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Выбор категории
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 12), // Смещение текста влево
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedCategory,
                                icon: Icon(CupertinoIcons.chevron_down,
                                    size: 20, color: Colors.grey.shade600),
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                items: categories[selectedSegment]!
                                    .map<DropdownMenuItem<String>>((category) =>
                                        DropdownMenuItem<String>(
                                          value: category["name"] as String,
                                          child: Row(
                                            children: [
                                              Icon(category["icon"] as IconData,
                                                  color: Colors.blueGrey),
                                              SizedBox(width: 8),
                                              Text(category["name"] as String),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategory = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            // Карточка с полями (Note, Amount, Date)
            _buildDetailsCard(),

            SizedBox(height: 20),

            // Кнопка сохранения
            Center(child: _buildSaveButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField("Note", CupertinoIcons.pencil, noteController),
          SizedBox(height: 14),
          _buildTextField(
              "Amount", CupertinoIcons.money_dollar, amountController,
              isNumber: true),
          SizedBox(height: 14),
          _buildDatePicker(),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String hint, IconData icon, TextEditingController controller,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueGrey),
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      ),
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(CupertinoIcons.calendar, color: Colors.blueGrey),
            SizedBox(width: 8),
            Text(
              "Date: ${selectedDate.toLocal()}".split(' ')[0],
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity, // Растягиваем кнопку на всю ширину
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10),
          backgroundColor: Colors.indigo[400],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          print("Transaction Saved");
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            "Save Transaction",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildSegment(String text, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

// Виджет для сегментного переключателя
Widget _buildSegment(String text, bool isSelected) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(vertical: 12),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: isSelected ? Colors.white : Colors.black,
      ),
    ),
  );
}
