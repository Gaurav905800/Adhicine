import 'package:adhicine/data/data.dart';
import 'package:adhicine/model/medicine_model.dart';
import 'package:adhicine/pages/profile_page.dart';
import 'package:adhicine/services/medicine_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MedicineService _medicineService = MedicineService();
  final data = Data();

  Stream<List<MedicineModel>> _fetchMedicines() {
    return FirebaseFirestore.instance.collection('medicines').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => MedicineModel.fromMap(doc.data()))
            .toList());
  }

  void _deleteMedicine(String id) async {
    await _medicineService.deleteMedicine(id);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Medicine deleted successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: StreamBuilder<List<MedicineModel>>(
                stream: _fetchMedicines(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Something went wrong! Try again later.",
                        style: GoogleFonts.lato(
                          color: Colors.redAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        "No medicines added yet.",
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    );
                  }

                  final medicines = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: medicines.length,
                    itemBuilder: (context, index) {
                      final medicine = medicines[index];
                      return Dismissible(
                        key: Key(medicine.id),
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          color: Colors.redAccent,
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          _deleteMedicine(medicine.id);
                        },
                        child: _buildMedicineCard(medicine, index),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi Harry!',
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Text('5 Medicines Left', style: GoogleFonts.lato())
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.medical_information,
                  size: 30,
                  color: Color.fromARGB(255, 69, 118, 230),
                ),
              ),
              const SizedBox(width: 20),
              Hero(
                tag: 'hero',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      await Future.delayed(Duration(microseconds: 20));
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfilePageM(),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/profile_image.jpeg'),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMedicineCard(MedicineModel medicine, int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      color: data.colorsList[index],
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Color(int.parse(medicine.color)),
          child: const Icon(Icons.medical_services, color: Colors.white),
        ),
        title: Text(
          medicine.name,
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              medicine.frequency,
              style: GoogleFonts.lato(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              medicine.timesADay,
              style: GoogleFonts.lato(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        trailing: Icon(
          Icons.notifications_none,
          size: 30,
          color: Color(int.parse(medicine.color)),
        ),
      ),
    );
  }
}
