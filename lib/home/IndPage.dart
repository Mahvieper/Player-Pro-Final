import 'package:flutter/material.dart';

class IndPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/homeBack.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(children: [
              Container(
                  margin: EdgeInsets.fromLTRB(30, MediaQuery.of(context).size.height *0.19,30,0),
                  decoration: BoxDecoration(
                      border:  Border.all(color: Colors.yellow)
                  ),
                  child: Wrap(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.yellow
                                )
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("TARGET",style: TextStyle(color: Colors.yellow,fontSize: 15),),
                            ),
                          ],),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black12
                        ),
                        child: Text("Values will be Entered here",style: TextStyle(color: Colors.white),),
                      )
                    ],

                  )
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, MediaQuery.of(context).size.height *0.02,30,0),
                  decoration: BoxDecoration(
                      border:  Border.all(color: Colors.yellow)
                  ),
                  child: Wrap(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.yellow
                                )
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("TECHNICAL",style: TextStyle(color: Colors.yellow,fontSize: 15),),
                            ),
                          ],),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black12
                        ),
                        child: Text("Values will be Entered here",style: TextStyle(color: Colors.white),),
                      )
                    ],

                  )
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, MediaQuery.of(context).size.height *0.02,30,0),
                  decoration: BoxDecoration(
                      border:  Border.all(color: Colors.yellow)
                  ),
                  child: Wrap(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.yellow
                                )
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("PHYSICAL",style: TextStyle(color: Colors.yellow,fontSize: 15),),
                            ),
                          ],),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black12
                        ),
                        child: Text("Values will be Entered here",style: TextStyle(color: Colors.white),),
                      )
                    ],

                  )
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, MediaQuery.of(context).size.height *0.02,30,0),
                  decoration: BoxDecoration(
                      border:  Border.all(color: Colors.yellow)
                  ),
                  child: Wrap(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.yellow
                                )
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("PSYCHOLOGICAL",style: TextStyle(color: Colors.yellow,fontSize: 15),),
                            ),
                          ],),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black12
                        ),
                        child: Text("Values will be Entered here",style: TextStyle(color: Colors.white),),
                      )
                    ],

                  )
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, MediaQuery.of(context).size.height *0.02,30,0),
                  decoration: BoxDecoration(
                      border:  Border.all(color: Colors.yellow)
                  ),
                  child: Wrap(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.yellow
                                )
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("SOCIAL",style: TextStyle(color: Colors.yellow,fontSize: 15),),
                            ),
                          ],),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black12
                        ),
                        child: Text("Values will be Entered here",style: TextStyle(color: Colors.white),),
                      )
                    ],

                  )
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, MediaQuery.of(context).size.height *0.02,30,0),
                  decoration: BoxDecoration(
                      border:  Border.all(color: Colors.yellow)
                  ),
                  child: Wrap(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.yellow
                                )
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("TACTICAL",style: TextStyle(color: Colors.yellow,fontSize: 15),),
                            ),
                          ],),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black12
                        ),
                        child: Text("Values will be Entered here",style: TextStyle(color: Colors.white),),
                      )
                    ],

                  )
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, MediaQuery.of(context).size.height *0.02,30,0),
                  decoration: BoxDecoration(
                      border:  Border.all(color: Colors.yellow)
                  ),
                  child: Wrap(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.yellow
                                )
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("INFORMATION",style: TextStyle(color: Colors.yellow,fontSize: 15),),
                            ),
                          ],),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black12
                        ),
                        child: Text("Values will be Entered here",style: TextStyle(color: Colors.white),),
                      )
                    ],

                  )
              ),
            ],),
          ),

        ],
      ),
    );
  }
}
