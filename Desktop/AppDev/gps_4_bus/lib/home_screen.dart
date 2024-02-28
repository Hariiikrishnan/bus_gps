import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';
import 'package:web_socket_channel/io.dart';

import 'dart:convert';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

late String busNo;
double? latitude;
double? longitude;
bool isGpsLoaded = false;

class _HomeScreenState extends State<HomeScreen> {
  final channel = IOWebSocketChannel.connect(url);
  // StreamSubscription<Position>? positionStream;

  String _locationData = 'Waiting for location updates...';

  // static String url = 'ws://172.20.10.6:3000';
  // static String url = 'ws://192.168.43.59:3000';
  // static String url = 'ws://192.168.125.196:3000';

  // static String url = 'ws://whale-app-vj3tz.ondigitalocean.app/';
  static String url = 'ws://192.168.61.196:5000/';
  void sendNumberToServer(int number) {
    final data = {
      'type': 'number',
      'number': number,
    };
    channel.sink.add(jsonEncode(data));
    // channel.sink.close(); // Close the channel after sending the number
  }

  void sendMessageToSpecificNumber(int targetNumber, String message) {
    final data = {
      'type': 'message',
      'targetNumber': targetNumber,
      'message': message,
    };
    channel.sink.add(data.toString());
    channel.sink.close(); // Close the channel after sending the message
  }

  Future<void> getLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      print(permission);

      Position position = await Geolocator.getCurrentPosition(
          // forceAndroidLocationManager: Platform.isAndroid,
          desiredAccuracy: LocationAccuracy.best);
      print(position);
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
        isGpsLoaded = true;
      });
    } catch (e) {
      print(e);
    }
  }

  // Location location = Location();
  void getPermission() async {
    // await getLocation();
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    print(permission);
  }

  void getLocationChange(busNo) async {
    late LocationSettings locationSettings;

    if (Platform.isAndroid) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
        // forceLocationManager: true,
        intervalDuration: const Duration(seconds: 1),
      );
    } else if (Platform.isIOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,

        // pauseLocationUpdatesAutomatically: true,
      );
    }

    // polyline.clear();
    try {
      print("Start live Track");
      StreamSubscription<Position> positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position? position) {
        // print(position);
        setState(() {
          latitude = position!.latitude;
          longitude = position.longitude;
          _sendLocationUpdates(int.parse(busNo));

          isGpsLoaded = true;
        });

        print("Maari");
        // print(position == null
        //     ? 'Unknown'
        //     : '${position.latitude.toString()}, ${position.longitude.toString()}');
      });
    } catch (e) {
      print(e);
    }
  }

  void startListening() {
    print("Work ??");
    channel.stream.listen((jsonData) {
      try {
        // String message = utf8.decode(data);
        // String message = jsonDecode(data);
        Map<String, dynamic> message = json.decode(jsonData);
        Map<String, dynamic> latData = json.decode(message['message']);
        print("inge");
        // print(jsonDecode(message));
        print(message);
        print(latData['latitude']);
        // print(message.toString());
        // print(message[10]);
        // print(message[18]);
        print(message['message']);
        setState(() {
          // _locationData = message;
          latitude = latData['latitude'];
          longitude = latData['longitude'];

          isGpsLoaded = true;
          print(isGpsLoaded);
        });
        print("Received message: $message");
      } catch (e) {
        print("Error in handling message: $e");
      }
    }, onError: (error) {
      print("Socket error: $error");
    }, onDone: () {
      print("Socket connection closed");
    });
  }

  _sendLocationUpdates(int number) async {
    print("here");
    if (channel.sink != null) {
      // channel.sink.readyState == WebSocketChannelState.open)
      // Send location updates to the server
      // channel.stream.listen((event) {
      //   print('got message');
      // });

      await channel.ready; // ready is a future

      print('WS connected');

      final data1 = {
        'type': 'number',
        'number': number,
      };
      final data2 = {
        'type': 'message',
        'targetNumber': number,
        'message': '{"latitude": ${latitude}, "longitude": ${longitude}}',
      };
      print(data2);
      // channel.sink.add(jsonEncode(data1));
      channel.sink.add(jsonEncode(data2));

      // channel.sink.add('{"latitude": ${latitude}, "longitude": ${longitude}}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
  }

  @override
  void dispose() {
    channel.sink.close();
    // positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Act Like Gps"),
              onPressed: () => showDialog<String>(
                // print("pressed");
                // getLocationChange();
                // print("Called");
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text("Enter Bus No. or Name"),
                  content: TextField(
                    decoration: const InputDecoration(
                      // suffixIcon: Icon(
                      //   Icons.search_rounded,
                      // ),
                      // suffixIconColor: Colors.black,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 19,
                      ),
                      filled: true,
                      // labelText: "Hello",
                      // hintText: 'Enter Bus No.',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 17.0),
                    onChanged: (value) {
                      // print(value);
                      setState(() {
                        busNo = value;
                      });
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                        print(busNo);

                        getLocationChange(busNo);
                        // _sendLocationUpdates(int.parse(busNo));

                        // sendNumberToServer(int.parse(busNo));
                        // getLocationChange();
                        // getLocationPackage();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                  insetPadding: MediaQuery.viewInsetsOf(context),
                ),
              ),
            ),

            Text(isGpsLoaded ? '$latitude , $longitude' : "Loading",
                style: TextStyle(color: Colors.black)),
            Text(
              'Location Updates: $_locationData',
              style: TextStyle(fontSize: 20),
            ),

            TextButton(
                onPressed: () {
                  setState(() {
                    isGpsLoaded = false;
                  });
                },
                child: Icon(
                  Icons.close,
                ))
            // StreamBuilder(
            //   stream: channel.stream,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       // Handle the received message here
            //       return Center(
            //         child: Text(
            //           'Received: ${snapshot.data}',
            //           style: TextStyle(fontSize: 20),
            //         ),
            //       );
            //     } else if (snapshot.hasError) {
            //       return Center(
            //         child: Text(
            //           'Error: ${snapshot.error}',
            //           style: TextStyle(fontSize: 20),
            //         ),
            //       );
            //     } else {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
