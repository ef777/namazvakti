import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:async';
import 'dart:io';
import 'dart:math' show pi;
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:namazvakti/loadingind.dart';
import 'package:namazvakti/loerror.dart';



import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class QiblahView extends StatefulWidget {
  const QiblahView({key});

  @override
  State<QiblahView> createState() => _QiblahViewState();
}

final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

class _QiblahViewState extends State<QiblahView> {
 

  @override
  static const _insets = 16.0;
  late Orientation _currentOrientation;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _deviceSupport,
      builder: (_, AsyncSnapshot<bool?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return LoadingIndicator();
        if (snapshot.hasError) {
          print("hata error");

          return Center(
            child: Text("Error: ${snapshot.error.toString()}"),
          );
        }
        if (snapshot.data == null)
          return Center(
            child: Text("Error: ${snapshot.error.toString()}"),
          );
        if (snapshot.hasData) {
          print("data geldi");
          print(snapshot.data.toString());
        }
        if (snapshot.data == true) {
          print("data" + snapshot.data.toString());
          print("kıble tamam");
          return QiblahCompass();
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Desteklenmeyen Cihaz'),
                content: Text('Pusula Desteklenmiyor'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Tamam'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          });
          print("kıble hata");
          return QiblahMaps();
        }
      },
    );
  }
}

void showTopSnackBar(BuildContext context, Widget child) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold
      .showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 8),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          content: child,
        ),
      )
      .closed
      .then((reason) {
    if (reason != SnackBarClosedReason.action) {
      scaffold.hideCurrentSnackBar();
    }
  });
}

class QiblahCompass extends StatefulWidget {
  @override
  _QiblahCompassState createState() => _QiblahCompassState();
}


class _QiblahCompassState extends State<QiblahCompass> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  get stream => _locationStreamController.stream;

  @override
  void initState() {

    _checkLocationStatus();
    super.initState();
  }

  @override
  static const _insets = 16.0;
  bool _isLoaded = false;
  late Orientation _currentOrientation;

  double get _adWidth => MediaQuery.of(context).size.width - (2 * _insets);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentOrientation = MediaQuery.of(context).orientation;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          title: Text(
        'main.qibla_compass'.tr(),
      )),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 76),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: stream,
                    builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return LoadingIndicator();
                      if (snapshot.data!.enabled == true) {
                        switch (snapshot.data!.status) {
                          case LocationPermission.always:
                          case LocationPermission.whileInUse:
                            return QiblahCompassWidget();

                          case LocationPermission.denied:
                            return LocationErrorWidget(
                              error: "Location service permission denied",
                              callback: _checkLocationStatus,
                            );
                          case LocationPermission.deniedForever:
                            return LocationErrorWidget(
                              error: "Location service Denied Forever !",
                              callback: _checkLocationStatus,
                            );
                       
                          default:
                            return const SizedBox();
                        }
                      } else {
                        return LocationErrorWidget(
                          error: "Please enable Location service",
                          callback: _checkLocationStatus,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
               
              ],
            ),
          
          ],
        ),
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else
      _locationStreamController.sink.add(locationStatus);
  }

  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }
}

class QiblahCompassWidget extends StatelessWidget {
  final _compassSvg = Image.asset(
    'assets/compass_solid.png',
    fit: BoxFit.contain,
  );
  final _needleSvg = Image.asset(
    'assets/compass_main.png',
    fit: BoxFit.contain,
  );
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return LoadingIndicator();

        final qiblahDirection = snapshot.data!;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${qiblahDirection.qiblah.toStringAsFixed(1)}°",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 32,
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Transform.rotate(
                  angle: (qiblahDirection.direction * (pi / 180) * -1),
                  child: _compassSvg,
                ),
                Transform.rotate(
                  angle: (qiblahDirection.qiblah * (pi / 180) * -1),
                  alignment: Alignment.center,
                  child: _needleSvg,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class QiblahMaps extends StatefulWidget {
  static final meccaLatLong = const LatLng(21.422487, 39.826206);
  final meccaMarker = Marker(
    markerId: MarkerId("mecca"),
    position: meccaLatLong,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    draggable: false,
  );

  @override
  _QiblahMapsState createState() => _QiblahMapsState();
}

class _QiblahMapsState extends State<QiblahMaps> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng position = LatLng(36.800636, 34.180358);

  Future<Position?>? _future;
  final _positionStream = StreamController<LatLng>.broadcast();

  @override
  void initState() {
    print("harita kıble başladı");
    _future = _checkLocationStatus();
    super.initState();
  }

  @override
  void dispose() {
    _positionStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _future,
        builder: (_, AsyncSnapshot<Position?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return LoadingIndicator();
          if (snapshot.hasError) {
            print("has error");
            return LocationErrorWidget(
              error: snapshot.error.toString(),
            );
          }

          if (snapshot.data != null) {
            print(snapshot.data.toString() + "data geldi kıble harita");
            final loc =
                LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
            position = loc;
          } else {
            print("data gelmedi kıble harita");
            _positionStream.sink.add(position);
          }

          return StreamBuilder(
            stream: _positionStream.stream,
            builder: (_, AsyncSnapshot<LatLng> snapshot) => GoogleMap(
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              compassEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                target: position,
                zoom: 7,
              ),
              markers: Set<Marker>.of(
                <Marker>[
                  widget.meccaMarker,
                  Marker(
                    draggable: true,
                    markerId: MarkerId('Marker'),
                    position: position,
                    icon: BitmapDescriptor.defaultMarker,
                    onTap: _updateCamera,
                    onDragEnd: (LatLng value) {
                      position = value;
                      _positionStream.sink.add(value);
                    },
                    zIndex: 5,
                  ),
                ],
              ),
              circles: Set<Circle>.of([
                Circle(
                  circleId: CircleId("Circle"),
                  radius: 10,
                  center: position,
                  fillColor: Theme.of(context).primaryColorLight.withAlpha(100),
                  strokeWidth: 1,
                  strokeColor:
                      Theme.of(context).primaryColorDark.withAlpha(100),
                  zIndex: 3,
                )
              ]),
              polylines: Set<Polyline>.of([
                Polyline(
                  polylineId: PolylineId("Line"),
                  points: [position, QiblahMaps.meccaLatLong],
                  color: Theme.of(context).primaryColor,
                  width: 5,
                  zIndex: 4,
                )
              ]),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          );
        },
      ),
    );
  }

  Future<Position?> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled) {
      return await Geolocator.getCurrentPosition();
    }
    return null;
  }

  void _updateCamera() async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(position, 20));
  }
}
