import 'package:flutter/material.dart';
import 'package:barqr_scanner/init.dart';
import 'package:barqr_scanner/components/themes.dart';
import 'dart:convert';

class HistoryView extends StatefulWidget {
  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<String> historyBase;
  AppManager manager;

  @override
  void initState() {
    manager = AppManager(context: context);
    historyBase = manager.getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 100,
      padding: EdgeInsets.all(15),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "QR Scanned History",
                        style: TextStyle(fontSize: 20),
                      ),
                      Divider()
                    ])),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 190,
              child: historyBase.length > 0
                  ? ListView.builder(
                      itemCount: historyBase.length,
                      itemBuilder: (context, idx) {
                        List histDump;
                        String hist = historyBase[idx];
                        if (hist != null) {
                          histDump = hist.split("~");
                        }

                        return histDump.length > 0
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0,
                                ),
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
                                child: ListTile(
                                  title: Text(histDump[0]),
                                  subtitle: Text(histDump[1],
                                      style: TextStyle(
                                          color: AppTheme.background)),
                                  trailing: InkWell(
                                      onTap: () {
                                        setState(() {
                                          historyBase.remove(hist);
                                          manager.resetHistory(
                                              historyBase.toList().toString());
                                        });
                                      },
                                      child: Icon(Icons.remove_circle)),
                                ))
                            : SizedBox();
                      })
                  : Container(
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          'No History Available',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )),
            ),
          ]),
    );
  }
}
