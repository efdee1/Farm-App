import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:body1/data/firestore_service.dart';
import 'package:body1/data/firestore_service2.dart';
import 'package:body1/models/sell.dart';
import 'package:body1/models/stocks.dart';
import 'package:body1/pages/SellAndBuy.dart';
import 'package:body1/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewSellPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,

        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder:(context)=> HomePage()),);
          },
        ),
        title: Text('SELL',
          style: TextStyle(
            color: Colors.black,
          ),
          textAlign:TextAlign.center,
        ),
      ),
      body: StreamBuilder(
            stream:FirestoreService().getStocks(),
            builder:(BuildContext context, AsyncSnapshot<List<Stocks >>snapshot){
              if (snapshot.hasError || !snapshot.hasData )
            return CircularProgressIndicator();
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  Stocks stock = snapshot.data[index];
                return Card(
                  color: Colors.red[300],
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: ListTile(
                    contentPadding:  EdgeInsets.fromLTRB(18,0,8,0),

                    title:Text('Stocks Available',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text('Title: ${stock.title} \nprice: \$${stock.price}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    isThreeLine: true,
                    onTap: ()=>Navigator.push(
                      context,MaterialPageRoute(
                      builder: (_) => SellPage(stock: stock,),
                    ),
                    ),
                  ),
                );
              },
            );
          }
      ),
    );
  }
}

