import 'package:barqr_scanner/components/category_individual.dart';
import 'package:barqr_scanner/components/themes.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CategoryView extends StatefulWidget {
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  String generatorData;
  @override
  void initState() {
    generatorData = "None";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 120,
      padding: EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Create QR code for your brand",
                        style: TextStyle(fontSize: 20),
                      ),
                      Divider()
                    ])),
            Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height / 1.4,
                child: ListView(children: <Widget>[
                  CategoryButton(
                    icon: Icons.link,
                    title: 'Link',
                  ),
                  CategoryButton(
                    icon: Icons.text_format,
                    title: 'Text',
                  ),
                  CategoryButton(
                    icon: Icons.phone,
                    title: 'Phone',
                  ),
                  CategoryButton(
                    icon: Icons.email,
                    title: 'Email',
                  ),
                  CategoryButton(
                    icon: Icons.person,
                    title: 'Username',
                  ),
                  CategoryButton(
                    icon: Icons.lock,
                    title: 'Password',
                  ),
                  CategoryButton(
                    icon: Icons.description,
                    title: 'Credentials',
                  )
                ])),
          ]),
    );
  }
}
