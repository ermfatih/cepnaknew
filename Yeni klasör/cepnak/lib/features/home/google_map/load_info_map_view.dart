import 'package:cepnak/features/home/freights/freights_model.dart';
import 'package:cepnak/features/home/freights/freights_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LoadInfoMapView extends StatefulWidget {
  LoadInfoMapView({super.key});

  @override
  State<LoadInfoMapView> createState() => _LoadInfoMapViewState();
}

class _LoadInfoMapViewState extends State<LoadInfoMapView> {
  Freight? _freightsModel;
  late double sourceLatitude;
  late double sourceLongitude;
  late double destinationLatitude;
  late double destinationLongitude;

  FreightsViewModel _freightsViewModel=Get.find();
  late final CameraPosition sourceCameraPosition;
  late final CameraPosition destinationCameraPosition;
  @override
  void initState() {
    super.initState();
    _freightsModel=_freightsViewModel.freightModel;
    sourceLatitude =_freightsModel?.source?.location?.latitude ?? 0;
    sourceLongitude=_freightsModel?.source?.location?.longitude ?? 0;
    sourceCameraPosition=CameraPosition(
        target: LatLng(sourceLatitude,sourceLongitude),
        zoom: 15
    );
    destinationLatitude=_freightsModel?.destination?.location?.latitude ?? 0;
    destinationLongitude=_freightsModel?.destination?.location?.longitude ?? 0;
    destinationCameraPosition=CameraPosition(target: LatLng(destinationLatitude,destinationLongitude));

  }
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingActionButton: FloatingActionButton(onPressed: () {},),
      appBar: AppBar(),
      body: GoogleMap(
        initialCameraPosition: sourceCameraPosition,
        onMapCreated: (controller) {
          mapController=controller;
        },
        markers:_createMarker(),
      ),
    );
  }

  Set<Marker> _createMarker(){
    return <Marker>[
      Marker(markerId: MarkerId('1'),
        position: sourceCameraPosition.target,
          infoWindow: InfoWindow(title: 'Kaynak')
      ),
      Marker(markerId: MarkerId('2'),
        position:destinationCameraPosition.target,
        infoWindow: InfoWindow(title: 'Hedef')
      )
    ].toSet();
  }
}
