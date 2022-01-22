import 'package:flutter_test/flutter_test.dart';

import 'package:localfire/localfire.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('localfire', () {
    final db = LocalFire.instance;
    test('creates an instance', () {
      expect(db, LocalFire.instance);
    });
    test('creates some collections and documents', () {
      final col = db.collection('mypath');
      final expectedCol = LocalFire.instance.collection('mypath');
      expect(col, expectedCol);
      final doc = db.collection('mypath').doc();
      final expectedDoc = LocalFire.instance.collection('mypath').doc(doc.id);
      expect(doc, expectedDoc);
      final newCol = col.doc(doc.id).collection('childpath');
      final expectedNewCol = LocalFire.instance
          .collection('mypath')
          .doc(doc.id)
          .collection('childpath');
      expect(newCol, expectedNewCol);
      expect(newCol.parent, col);
      expect(newCol.parent?.path, col.path);
      final newDoc = newCol.doc('8rvf1dfxw');
      // final expectedNewDoc = db
      //     .collection('mypath')
      //     .doc(doc.id)
      //     .collection('childpath')
      //     .doc('8rvf1dfxw');
      // expect(newDoc, expectedNewDoc);
    });
    test('creates and updates data', () async {
      Map<String, dynamic> data = {
        'id': '0002',
        'displayName': {'test': 'Chuyen'},
        'value': 'teste',
      };
      final doc = db.collection('Users').doc('002');
      await doc.set(data, merge: true);
      data['value'] = '2';
      await doc.update(data);
      await doc.set(data);
      final expectedDoc = db.collection('Users').doc(doc.id);
      expect(doc, expectedDoc);
      final expectedData = await doc.get();
      expect(data, expectedData);
    });
  });
}
