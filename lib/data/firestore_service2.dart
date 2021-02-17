


import 'package:body1/models/sales.dart';
import 'package:body1/models/sell.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreService2{
   static final FirestoreService2 _firestoreService2 = FirestoreService2._internal();
  final Firestore _db = Firestore.instance;






  FirestoreService2._internal();


  factory FirestoreService2() {
    return _firestoreService2;
  }
  Stream<List<Sales>>getSales() {
    return _db
        .collection('sales').orderBy('createdAt',descending: true).snapshots().map(
            (snapshot)=>snapshot.documents.map(
              (doc) => Sales.fromMap(doc.data,doc.documentID),
        ).toList()
    );
  }
  Future<void> addSales(Sales sale){
    return _db.collection('sales').add(sale.toMap());
  }
  Future<void> deleteStock(String id) {
    return _db.collection('stocks').document(id).delete();
  }
  Future<void> updateStock(Sales sales){
    return _db.collection('stocks').document(sales.id).updateData(sales.toMap());
  }
  Future<void> setData(Stock stock){
    return _db.collection('stocks').document(stock.id).setData(stock.toMap());
  }
  Future salesData ({String title,int price,int amount,DateTime createdAt,int totalsale})async{
    return _db.collection('sales').document().setData({'title':title,'price':price,'amount':amount,'createdAt':createdAt,'totalsale':totalsale},merge:true);
  }
  Future<void> setStock(Stock stock) {
    return _db.collection('stocks').document().setData(stock.toMap());
  }
   Stream<List<Sales>>getSales2() {
     return _db
         .collection('sales').orderBy('createdAt',descending: true).limit(4).snapshots().map(
             (snapshot)=>snapshot.documents.map(
               (doc) => Sales.fromMap(doc.data,doc.documentID),
         ).toList()
     );
   }
   Stream<List<Sales>>getTotalSales() {
     return _db
         .collection('sales').orderBy('createdAt',descending: true).snapshots().map(
             (snapshot)=>snapshot.documents.map(
               (doc) => Sales.fromMap(doc.data,doc.documentID),
         ).toList()
     );
   }
}