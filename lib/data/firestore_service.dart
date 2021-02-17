
import 'package:body1/models/stocks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  final String id;
  FirestoreService({this.id});
  Firestore _db = Firestore.instance;

 Stream<List<Stocks>>getStocks() {
   return _db
       .collection('stocks').orderBy('title',descending: true).snapshots().map(
         (snapshot)=>snapshot.documents.map(
               (doc) => Stocks.fromMap(doc.data,doc.documentID),
         ).toList()
   );
 }
 Future<void> addStocks(Stocks stocks){
   return _db.collection('stocks').add(stocks.toMap());
 }
 Future<void> deleteStocks(String id) {
   return _db.collection('stocks').document(id).delete();
 }
 Future<void> updateStocks(Stocks stocks){
   return _db.collection('stocks').document(stocks.id).updateData(stocks.toMap());
 }
  Future updateAmount(int amount)async{
    return _db.collection('stocks').document(id).setData({'amount':amount},merge:true);
  }
}