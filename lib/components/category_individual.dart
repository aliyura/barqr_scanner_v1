import 'package:flutter/material.dart';
import 'package:barqr_scanner/components/themes.dart';
import 'package:barqr_scanner/components/generator.dart';
import 'themes.dart';

class CategoryButton extends StatelessWidget {
  final icon;
  final title;
  final ontap;

  CategoryButton({this.icon, this.title, this.ontap});

  @override
  Widget build(BuildContext context) {
    return 
    InkWell(
      onTap: (){
         Generator(context:context).requestDialog(this.title);
      },
      child:
    Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 5.0,
        ),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 46.0),
              decoration: BoxDecoration(
                color: AppTheme.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: ListTile(
                        title: Text(
                          title,
                          style: TextStyle(
                            color: AppTheme.background,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          "Generate QR Code for " + title+"",
                          style: TextStyle(
                              color: AppTheme.dark_grey, fontSize: 16),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                          padding: EdgeInsets.only(left: 18),
                          width: 50,
                          child:
                              Divider(height: 10, color: AppTheme.nearlyBlack)),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 16.0, right: 20),
                alignment: FractionalOffset.center,
                height: 50,
                width: 42,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      //                   <--- left side
                      color: AppTheme.nearlyBlack.withOpacity(0.5),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.nearlyBlack.withOpacity(0.5),
                )),
          ],
        ))
    );
  }
}
