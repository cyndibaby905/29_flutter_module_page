import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';



void main() => runApp(_widgetForRoute(window.defaultRouteName));
const platform = MethodChannel('samples.chenhang/navigation');


Widget _widgetForRoute(String route) {
  switch (route) {
    default:
      return MaterialApp(
        theme: ThemeData(
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        })),
        home:DefaultPage(showBack: true),
      );
  }
}

class PageA extends StatelessWidget {
  bool showBack;
  PageA({ Key key, this.showBack=false }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.greenAccent,
            appBar: AppBar(title: Text("Flutter Page A")),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Page A',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  RaisedButton(
                    child: Text("Go Native Page"),
                    onPressed: ()=>platform.invokeMethod('openNativePage')
                  )
                ],
              ),
            )
    );
  }
}

class DefaultPage extends StatelessWidget {

  bool showBack;
  DefaultPage({Key key, this.showBack=false }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.redAccent,
        appBar: AppBar(
            title: Text("Flutter Default Page"),
            leading: !showBack?null:IconButton(icon:Icon(Icons.arrow_back), onPressed:() => platform.invokeMethod('closeFlutterPage')
            )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Text(
                'Default Page',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              RaisedButton(
                  child: Text("Go Page A"),
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => PageA())),
              )

            ],
          ),
        )

    );
  }
}