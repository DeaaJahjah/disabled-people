import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaoled_people/features/auth/models/charity.dart';

class CharitiesDbServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<List<Charity>> getAll() async {
    List<Charity> charities = [];

    var query = await _db.collection('users').where('user_type', isEqualTo: 'charityOrg').get();

    for (var doc in query.docs) {
      charities.add(Charity.fromFirestore(doc));
    }

    return charities;
  }
}
