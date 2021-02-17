import 'package:body1/data/firestore_service2.dart';
import 'package:body1/models/sales.dart';
import 'package:body1/models/stocks.dart';
import 'package:body1/pages/add_stock_page.dart';
import 'package:body1/pages/login_signUp_page.dart';
import 'package:body1/pages/sales_page.dart';
import 'package:body1/pages/stocks_page.dart';
import 'package:body1/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:body1/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'newsell_page.dart';
//import 'package:firebase_database/firebase_database.dart';



class HomePage extends StatefulWidget {
  //final Auth _firebaseAuth = Auth();

  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
  //String _formatdate = new DateFormat('HH:mm a , MM/dd/yyyy').format(createdAt);
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  // ignore: unused_field
  List<Stocks>_homeList;
  // ignore: unused_field
  List<Sales>_list;
  final Auth _firebaseAuth = Auth();

  //final FirestoreService _database = FirestoreService.;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  bool isCollapsed = true;
  double screenWidth ,screenHeight;
  final Duration duration= const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset>_slideAnimation;

  final Firestore db = Firestore.instance;

  int length = 0;
  double rate;

//  @override
//  void setState(fn) {
//    // TODO: implement setState
//    super.setState(fn);
//    rate = counter;
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    _homeList = new List();
//    _homeQuery = _database.refernce().child("home").orderByChild("userId").equalTo(widget.userId);

    _controller = AnimationController(vsync: this,duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end:0.6).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5   , end:1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin:Offset(-1,0) , end:Offset(0,0)).animate(_controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double counter = 0;
    Firestore.instance.collection('sales').snapshots().listen( (data){
      data.documents.forEach( (doc) {
        counter += (doc["totalsale"]
        );
      });
      setState( () {
        rate = counter;
      });
    });
    //final Auth _firebaseAuth = Auth();
    Size size = MediaQuery.of(context).size;
    screenWidth= size.width;
    screenHeight=size.height;
//    final _width =  MediaQuery.of(context).size.width;
//    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.teal[500],
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }



  signOut() async{
    try{
      await widget.auth.signOut();
      widget.logoutCallback();
    }catch(e){
      print (e);
    }
//    return _firebaseAuth.signOut();
  }




  Widget menu(context ){
    //final Auth _firebaseAuth = Auth();
    return SlideTransition(
      position:_slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left:16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: <Widget>[
                InkWell(
                  child: Text(
                    "STOCKS",
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 22
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context)
                    {return StockPage();}));
                  },
                ),

                SizedBox(height: 10 ),
                InkWell(
                  child: Text(
                    "SALES",
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 22
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context)
                    {return SellPage();}));
                  },
                ),

                SizedBox(height: 10 ),
                InkWell(
                  child: Text(
                    "SELL",
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 22
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context)
                    {return NewSellPage();}));
                  },
                ),
                SizedBox(height: 10 ),
                InkWell(
                  child: Text(
                    "ADD STOCK",
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 22
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context)
                    {return AddStocksPages();}));
                  },
                ),
                SizedBox(height: 10 ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context){
    //final _width =  MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom:0,
      right:  isCollapsed ? 0 :screenWidth*-0.4,
      left:  isCollapsed ? 0 :screenWidth*0.6,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: Colors.amber,
          child: Container(
            padding: const EdgeInsets.only(left:16, right: 16, top:48),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    InkWell(
                        child: Icon(Icons.menu,
                            size: 30,
                            color: Colors.black),onTap:(){
                        setState(() {
                          if(isCollapsed)
                            _controller.forward();
                          else
                            _controller.reverse();

                          isCollapsed = !isCollapsed;
                        });
                      } ,
                      ),

                    Text("Mercy & CO",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.teal[900]
                      ),
                    ),
                   FlatButton(
                     child: Container(
                       child: Text('Logout',
                         textAlign: TextAlign.end,
                         style:  TextStyle(fontSize: 24,color: Colors.teal[900],
                         ),
                       ),
                     ),
                     onPressed: signOut,
                   ),
                  ],
                ),

                SizedBox(height: 50),
                Container(
                  height: 200,
                  child: PageView(
                    controller: PageController(viewportFraction: 0.9),
                    scrollDirection: Axis.horizontal,
                    pageSnapping: true,
                    children: <Widget>[
                      StreamBuilder(
                         stream:FirestoreService2().getSales2(),
                          builder:(BuildContext context, AsyncSnapshot<List<Sales>>snapshot){
                            if (snapshot.hasError || !snapshot.hasData )
                              return CircularProgressIndicator();
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Container(
                            color: Colors.white,
                            child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index){
                             Sales sales = snapshot.data[index];
                              return Container(
                                child: Text('Sales: ${sales.title},\nPrice: \$${sales.price} \nAmount: ${sales.amount} \ntotalsale: \$${sales.totalsale}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                margin: EdgeInsets.fromLTRB(8,0,8,8),
                                color: Colors.teal,
                              );
                        },
                        )
                        ),
                      );
                    }
                      ),
                      Card(
                        child: Center(
                          child: Container(
                            color: Colors.white,
                            child: Text('TotalSales: \$$rate',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                            margin: EdgeInsets.all(25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: _height*0.02),
                Text("Transactions",
                  style:TextStyle(
                    fontSize: 24,
                    letterSpacing: 0.1
                  ),
                ),
                //SizedBox(height: 0.03),
                Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          title: "Stocks",
                          image: "assets/stocks.png",
                          press: () {Navigator.push(
                            context,MaterialPageRoute(builder: (context)
                          {return StockPage();
                          }),
                          );
                          },

                        ),
                        CategoryCard(
                          title: "Sales",
                          image: "assets/sales.png",
                          press: () {Navigator.push(
                              context,MaterialPageRoute(builder: (context)
                          {return SellPage();
                          })
                          );
                          },
                        ),
                        CategoryCard(
                          title: "Sell",
                          image: "assets/sell.png",
                          press: () {Navigator.push(
                            context,MaterialPageRoute(builder: (context)
                          {return NewSellPage();
                          })
                          );
                          },
                        ),
                        CategoryCard(
                          title: "Add Stocks",
                          image: "assets/add stock.png",
                          press: () {Navigator.push(
                              context,MaterialPageRoute(builder: (context)
                          {return AddStocksPages();
                          })
                          );
                          },
                        ),

                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final Function press;
  const CategoryCard({
    Key key, this.image, this.title, this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        //padding:EdgeInsets.all(0.25),
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [BoxShadow(offset: Offset(0, 17),
            blurRadius: 17,
            spreadRadius: -23,
            
          ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Image.asset(image,
                    height: 80,
                    width: 80,
                  ),
                  Spacer(),
                  Text(title,
                    textAlign: TextAlign.center,

                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



