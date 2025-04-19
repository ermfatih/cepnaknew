import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';


class FreightMapComponent extends ConsumerStatefulWidget {
  final double latitude;
  final double longitude;
  final bool isDestination;
  final double longitudeDestination;
  final double latitudeDestination;
  const FreightMapComponent({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.isDestination,
    required this.latitudeDestination,
    required this.longitudeDestination,
  });

  @override
  ConsumerState<FreightMapComponent> createState() =>
      FreightMapComponentState();
}

class FreightMapComponentState extends ConsumerState<FreightMapComponent> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  Set<Marker> markers = <Marker>{};

  late LatLng startLocation;
  @override
  void initState() {
    super.initState();
    startLocation = LatLng(
      widget.latitude,
      widget.longitude,
    );
    markers = {
      Marker(
        markerId: const MarkerId('location'),
        position: LatLng(widget.latitude, widget.longitude),
        onTap: () {},
      ),
      Marker(
        markerId: const MarkerId('location'),
        position: LatLng(widget.latitudeDestination, widget.longitudeDestination),
        onTap: () {},
      ),
    };
  }



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 200.h,
      child: GoogleMap(
        indoorViewEnabled: true,
        rotateGesturesEnabled: true,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: startLocation,
          zoom: 1.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
      ),
    );
  }
}
