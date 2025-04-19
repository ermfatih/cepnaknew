import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/home/freights/freights_view.dart';
import 'package:cepnak/features/home/old_freights/old_freights_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OldFreights extends StatefulWidget {
  const OldFreights({super.key});

  @override
  State<OldFreights> createState() => _OldFreightsState();
}

class _OldFreightsState extends State<OldFreights> {
  final OldFreightsViewModel _viewModel=Get.put(OldFreightsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Teslim Edilen İşler')),
      body: FutureBuilder(
        future: _viewModel.getOldFreights(),
        builder: (context,snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: context.paddingLowHorizontal,
                child: Column(
                  children: [
                    FreightPosting(
                      agentName: snapshot.data?[index].name,
                      deliveryDate: snapshot.data?[index].deliveryDate,
                      price: snapshot.data?[index].price.toString(),
                      sourceName:snapshot.data?[index].source?.name ,
                      destinationName:snapshot.data?[index].destination?.name ,
                      onTap: () {
                        /*showDialog(context: context, builder: (context) {
                        return const OldFreightsAlert();
                        },);*/
                      },
                    )
                  ],
                ),
              );
            },);
        }
      ),
    );
  }
}
