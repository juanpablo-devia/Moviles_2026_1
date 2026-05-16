import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/universidad.dart';

class UniversidadService {
  final CollectionReference _col =
      FirebaseFirestore.instance.collection('universidades');

  Stream<List<Universidad>> getUniversidades() {
    return _col.orderBy('nombre').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => Universidad.fromMap(
                    doc.data() as Map<String, dynamic>,
                    doc.id,
                  ))
              .toList(),
        );
  }

  Future<void> crearUniversidad(Universidad universidad) {
    return _col.add(universidad.toMap());
  }

  Future<void> eliminarUniversidad(String id) {
    return _col.doc(id).delete();
  }
}
