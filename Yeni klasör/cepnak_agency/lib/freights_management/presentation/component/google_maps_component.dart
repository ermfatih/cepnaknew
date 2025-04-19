import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../application/freight_form.dart';


class GoogleMapsComponent extends ConsumerStatefulWidget {
  final double latitude;
  final double longitude;
  final bool isDestination;
  const GoogleMapsComponent({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.isDestination,
  });

  @override
  ConsumerState<GoogleMapsComponent> createState() =>
      GoogleMapsComponentState();
}

class GoogleMapsComponentState extends ConsumerState<GoogleMapsComponent> {
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
    };
  }

  void _updateMarker(double latitude, double longitude) {
    if(widget.isDestination){
      ref.read(destinationLocationProvider.notifier).state = LatLng(latitude, longitude);
    }else{
      ref.read(sourceLocationProvider.notifier).state = LatLng(latitude, longitude);
    }

    setState(() {
      markers = {
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: LatLng(latitude, longitude),
          onTap: () {},
        ),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 400,
      child: GoogleMap(
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
        onTap: (latLng) {
          _updateMarker(latLng.latitude, latLng.longitude);
        },
        markers: markers,
      ),
    );
  }
}
