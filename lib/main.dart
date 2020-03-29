import 'package:flutter/material.dart';
import 'dart:io';
import 'package:barqr_scanner/components/themes.dart';
import 'package:barqr_scanner/screens/about.dart';
import 'package:barqr_scanner/screens/feedback.dart';
import 'package:barqr_scanner/screens/invite_friend.dart';
import 'package:barqr_scanner/screens/rate_app.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'components/category.dart';
import 'components/history.dart';
import 'package:barqr_scanner/init.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BarQR Scanner',
      theme: ThemeData.light().copyWith(primaryColor: AppTheme.background),
      home: MyApp(),
    );
  }
}

enum AppState { free, scanned }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;
  AppState state;
  File imageFile;
  String description;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    AppManager manager = new AppManager(context: context);

    return Scaffold(
        backgroundColor: AppTheme.nearlyWhite,
        appBar: AppBar(
          title: Text("BarQR Scanner"),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FeedbackScreen()));
              },
              icon: Icon(Icons.message),
              label: Text("Feedback", style: TextStyle(
                fontSize: 20
              )),
              textColor: AppTheme.white,
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: UserAccountsDrawerHeader(
                  accountName: Text('barqr scanner v0.0.1'),
                  accountEmail: Text('info@barqrscanner.com'),
                  currentAccountPicture: GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: AppTheme.nearlyBlack.withOpacity(0.7),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(color: AppTheme.background),
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    title: Text('Home'),
                    leading: Icon(Icons.home),
                  )),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutScreen()));
                  },
                  child: ListTile(
                    title: Text('About'),
                    leading: Icon(Icons.help),
                  )),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeedbackScreen()));
                  },
                  child: ListTile(
                    title: Text('Feedback'),
                    leading: Icon(Icons.message),
                  )),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InviteFriend()));
                  },
                  child: ListTile(
                    title: Text('Invite Friend'),
                    leading: Icon(Icons.share),
                  )),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReateAppScreen()));
                  },
                  child: ListTile(
                    title: Text('Reate App'),
                    leading: Icon(Icons.star),
                  )),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.home, size: 30, color: AppTheme.white),
            GestureDetector(
              onTap: () {
                manager.scanBarQR();
              },
              child: Icon(Icons.camera_alt, size: 30, color: AppTheme.white),
            ),
            GestureDetector(
              onTap: () {
                manager.pickImage();
              },
              child: Icon(Icons.image, size: 30, color: AppTheme.white),
            ),
            Icon(Icons.playlist_add_check, size: 40, color: AppTheme.white),
          ],
          color: AppTheme.background,
          buttonBackgroundColor: AppTheme.background,
          backgroundColor: AppTheme.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 400),
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
          },
        ),
        body: Container(
          child: Center(
            child: ListView(
              children: <Widget>[
                currentPage == 0
                    ? CategoryView()
                    : currentPage == 3 ? HistoryView() : SizedBox()
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.background,
          onPressed: () {
            if (state == AppState.free)
              manager.scanBarQR();
          },
          child: _buildButtonIcon(),
        ));
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(Icons.add_a_photo);
    else if (state == AppState.scanned)
      return Icon(Icons.save_alt);
    else
      return Container();
  }
}
