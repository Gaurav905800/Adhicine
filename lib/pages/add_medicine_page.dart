import 'package:adhicine/data/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adhicine/model/medicine_model.dart';
import 'package:adhicine/services/medicine_services.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final TextEditingController _medicineNameController = TextEditingController();
  int totalCount = 1;
  double sliderValue = 1;
  String frequency = 'Everyday';
  String timesADay = 'Three Time';
  int selectedCompartment = 1;
  String selectedType = 'Tablet';
  String selectedFoodInstruction = 'Before Food';
  final MedicineService _medicineService = MedicineService();
  final Data data = Data();
  Color selectedColor = Colors.blue.shade200;

  void _addMedicine() async {
    if (_medicineNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a medicine name')),
      );
      return;
    }

    try {
      MedicineModel medicine = MedicineModel(
        id: FirebaseFirestore.instance.collection('medicines').doc().id,
        name: _medicineNameController.text,
        compartment: selectedCompartment,
        color: selectedColor.value.toString(),
        type: selectedType,
        quantity: totalCount,
        totalCount: sliderValue.toInt(),
        frequency: frequency,
        timesADay: timesADay,
        startDate: Timestamp.now(),
        endDate: Timestamp.now(),
        dosage: '',
      );

      await _medicineService.addMedicine(medicine);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Medicine added successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding medicine: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Medicines',
          style: GoogleFonts.lato(),
        ),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _medicineNameController,
                decoration: InputDecoration(
                  hintText: 'Search Medicine Name',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Compartment',
                style: GoogleFonts.lato(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Wrap(
                spacing: 8.0,
                children: List.generate(6, (index) {
                  return ChoiceChip(
                    label: Text('${index + 1}'),
                    selected: selectedCompartment == index + 1,
                    selectedColor: Color.fromARGB(255, 69, 118, 230),
                    backgroundColor: Colors.white,
                    onSelected: (selected) {
                      setState(() {
                        selectedCompartment = index + 1;
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 16),
              Text(
                'Colour',
                style: GoogleFonts.lato(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Wrap(
                spacing: 8.0,
                children: data.colorsList.map((color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 2),
                      child: CircleAvatar(
                        backgroundColor: color,
                        radius: 20,
                        child: selectedColor == color
                            ? Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text(
                'Type',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['Tablet', 'Capsule', 'Cream', 'Liquid', 'Injection']
                    .map((type) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedType = type;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.medical_services,
                          size: 40,
                          color: selectedType == type
                              ? Colors.pinkAccent.shade200
                              : Colors.pink.shade200,
                        ),
                        Text(
                          type,
                          style: GoogleFonts.lato(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text(
                'Quantity',
                style: GoogleFonts.lato(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Take 1/2 Pill',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: Color.fromARGB(255, 69, 118, 230)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (totalCount > 1) totalCount--;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        '$totalCount',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 69, 118, 230),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            totalCount++;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Total Count',
                style: GoogleFonts.lato(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Slider(
                value: sliderValue,
                min: 1,
                max: 100,
                divisions: 100,
                thumbColor: Color.fromARGB(255, 69, 118, 230),
                label: sliderValue.round().toString(),
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
              ),
              SizedBox(height: 10),
              Text(
                'Frequency of Days',
                style: GoogleFonts.lato(fontSize: 16),
              ),
              DropdownButton<String>(
                value: frequency,
                borderRadius: BorderRadius.circular(12),
                dropdownColor: Colors.white,
                items: ['Everyday', 'Alternate Days', 'Custom'].map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    frequency = value!;
                  });
                },
              ),
              SizedBox(height: 10),
              Text(
                'How many times a Day',
                style: GoogleFonts.lato(fontSize: 16),
              ),
              DropdownButton<String>(
                value: timesADay,
                borderRadius: BorderRadius.circular(12),
                dropdownColor: Colors.white,
                items: ['One Time', 'Two Time', 'Three Time'].map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    timesADay = value!;
                  });
                },
              ),
              SizedBox(height: 10),
              Text(
                'Food Instruction',
                style: GoogleFonts.lato(fontSize: 16),
              ),
              Wrap(
                spacing: 8.0,
                children:
                    ['Before Food', 'After Food', 'Before Sleep'].map((e) {
                  return ChoiceChip(
                    label: Text(e),
                    selected: selectedFoodInstruction == e,
                    onSelected: (selected) {
                      setState(() {
                        selectedFoodInstruction = e;
                      });
                    },
                    selectedColor: Color.fromARGB(255, 69, 118, 230),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: selectedFoodInstruction == e
                          ? Colors.white
                          : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _addMedicine,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 69, 118, 230),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'Add',
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
