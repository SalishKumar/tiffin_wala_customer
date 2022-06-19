import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tiffin_wala_customer/src/view_model/address_view_model.dart';
import 'package:tiffin_wala_customer/src/views/address_view.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;

class Maps extends StatefulWidget {
  static const routeName = '/maps';
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();
  late LatLng _center = LatLng(data.lat, data.long);
  MapType _type = MapType.normal;
  List<LatLng> markerList = [];
  Set<Marker> _markers = {};
  Set<Marker> markers = {};
  LatLng marker = LatLng(data.lat, data.long);

  dragMarker(CameraPosition position) {
    markers = {};
    marker = LatLng(position.target.latitude, position.target.longitude);
    markers.add(Marker(
      markerId: MarkerId(marker.toString()),
      position: marker,
      icon: BitmapDescriptor.defaultMarker,
    ));
    setState(() {});
  }

  _markersOnMap(LatLng latlong) {
    markerList = [];
    _markers = {};
    markerList.add(LatLng(latlong.latitude, latlong.longitude));

    if (markerList != null) {
      for (int i = 0; i < markerList.length; i++) {
        _markers.add(Marker(
          markerId: MarkerId(markerList[i].toString()),
          position: markerList[i],
          icon: BitmapDescriptor.defaultMarker,
        ));
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    print('${data.lat} ${data.long}');
    markers.add(Marker(
      markerId: MarkerId(marker.toString()),
      position: marker,
      icon: BitmapDescriptor.defaultMarker,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: _center, zoom: 20),
              mapType: _type,
              markers: markers,
              onTap: (latlng) {
                _markersOnMap(latlng);
              },
              onCameraMove: (position) {
                dragMarker(position);
                print(position.target.longitude.toString() +
                    " " +
                    position.target.latitude.toString());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: InkWell(
          onTap: () async {
            List<Placemark> placemarks = await placemarkFromCoordinates(
                marker.latitude, marker.longitude);
            data.address =
                '${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}';
            data.lat = marker.latitude;
            data.long = marker.longitude;
            print(data.address);
            Navigator.pushReplacementNamed(context, AddressView.routeName);
          },
          child: CustomButton(
            width: width,
            title: "Select Address",
          )),
    );
  }
}
