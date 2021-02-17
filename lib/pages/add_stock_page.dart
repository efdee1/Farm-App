import 'package:body1/data/firestore_service.dart';
import 'package:body1/data/firestore_service2.dart';
import 'package:body1/models/sell.dart';
import 'package:body1/models/stocks.dart';
import 'package:body1/pages/SellAndBuy.dart';
import 'package:body1/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_stock_details_page.dart';

class AddStocksPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder:(context)=> HomePage()),);
          },
        ),
        title: Text('Add Stocks',
          style: TextStyle(
            color: Colors.black,
          ),
          textAlign:TextAlign.center,
        ),
      ),
      body: Card(
        color: Colors.pinkAccent,
        shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: StreamBuilder(
            stream:FirestoreService().getStocks(),
            builder:(BuildContext context, AsyncSnapshot<List<Stocks >>snapshot){
              if (snapshot.hasError || !snapshot.hasData )
            return CircularProgressIndicator();
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  Stocks stocks = snapshot.data[index];
                  return Card(
                    color: Colors.white,
                    shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: ListTile(
                      contentPadding:  EdgeInsets.fromLTRB(18,0,8,0),
                      title:Text('Add Stocks ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ) ,
                      subtitle: Text('${stocks.title} \nprice: \$${stocks.price}',
                          style: TextStyle(
                            color: Colors.black
                          ),
                      ),
                      isThreeLine: true,
                      onTap: ()=>Navigator.push(
                        context,MaterialPageRoute(
                        builder: (_) => AddStocksDetailPage(stock: stocks),
                      ),
                      ),
                    ),
                  );
                },
              );
            }
        ),
      ),
    );
  }
}

