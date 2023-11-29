import 'package:flutter/material.dart';

import 'package:transmo/constants.dart';

class SavedBusesTab extends StatefulWidget {
  const SavedBusesTab({super.key});

  @override
  State<SavedBusesTab> createState() => _SavedBusesTabState();
}

class _SavedBusesTabState extends State<SavedBusesTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      // alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("5 E", style: kSavedHeadText),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Route : Thiruverumbur to Chathram Bus Stand",
                          style: kSavedParaText),
                    ],
                  ),
                ),
                ClipOval(
                  child: Container(
                    color: Colors.red,
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Text(
                        "5m",
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("116 G", style: kSavedHeadText),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Route : Chathiram Bus Stand to V. Pallapatti",
                          style: kSavedParaText),
                    ],
                  ),
                ),
                ClipOval(
                  child: Container(
                    color: Colors.red,
                    height: 50,
                    width: 50,
                    // padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        "15m",
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("99 A", style: kSavedHeadText),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Route : Thottiyam to Chathram Bus Stand",
                          style: kSavedParaText),
                    ],
                  ),
                ),
                ClipOval(
                  child: Container(
                    color: Colors.red,
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Text(
                        "10m",
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("17 A", style: kSavedHeadText),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Route : Chathiram Bus Stand to Ponmalai",
                          style: kSavedParaText),
                    ],
                  ),
                ),
                ClipOval(
                  child: Container(
                    color: Colors.red,
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Text(
                        "5m",
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
