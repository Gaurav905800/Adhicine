import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/medicine_model.dart';

class MedicineService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = "medicines";

  Future<void> addMedicine(MedicineModel medicine) async {
    await _firestore
        .collection(collectionName)
        .doc(medicine.id)
        .set(medicine.toMap());
  }

  Future<List<MedicineModel>> getMedicines() async {
    QuerySnapshot snapshot = await _firestore.collection(collectionName).get();
    return snapshot.docs
        .map((doc) => MedicineModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteMedicine(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }
}
