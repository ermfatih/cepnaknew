import 'dart:io';

import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/home/profile/profile_view_model.dart';
import 'package:cepnak/product/constant/png_items.dart';
import 'package:cepnak/product/i18n/strings.g.dart';
import 'package:cepnak/product/models/carrier_model.dart';
import 'package:cepnak/product/navigate/navigate_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileViewModel _viewModel=Get.put(ProfileViewModel());
  Carrier? carrierModel;
  File? file;
  void getCarrier()async{
    carrierModel=await _viewModel.getCarrier();
  }
  @override
  void initState() {
    super.initState();
    getCarrier();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(profile.i18n),),
      body: SingleChildScrollView(
        child:
        Column(
          children: [
            Container(width: 1.sw,height: 200.h,decoration: BoxDecoration(color: Color(0xff2AA14A), borderRadius: BorderRadius.vertical(bottom: Radius.circular(80.r))),child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(radius: 50.r,backgroundImage: file!=null ? Image.file(file!).image :null),
                    Positioned(bottom: 0,right: 0,child: IconButton(onPressed: () async{
                      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.image);
                      if (result != null) {
                        setState(() {
                          file = File(result.files.single.path!);
                        });
                      } else {
                      }
                    },icon: Icon(Icons.edit,color: Colors.black),)),
                  ],
                ),
                Text(carrierModel?.name ?? '',style: context.myTextTheme.headlineMedium),
                //Text('Güven Puanı',style: context.myTextTheme.headlineSmall,)
              ],
            ),),
            Padding(
              padding: context.paddingLowAll,
              child: ReactiveForm(
                formGroup: _viewModel.form,
                child: Column(
                    children: [
                      ProfileTool(pngItem: PngItems.notification,text: notification.i18n,isOpenButton: true,formControlName: 'notification'),
                      ProfileTool(pngItem: PngItems.expensive,text: showExpensive.i18n,isOpenButton: true,formControlName: 'showExpensive',onChanged: (p0) {
                        _viewModel.changeShowExpensive();
                      },),
                      ProfileTool(pngItem: PngItems.moon,text: darkTheme.i18n,isOpenButton: true,formControlName: 'darkTheme'),
                      ProfileTool(pngItem: PngItems.bed,text: isBreak.i18n,isOpenButton: true,formControlName: 'isBreak',onChanged: (p0) {
                        _viewModel.changeBreak();
                      },),
                      ProfileTool(pngItem: PngItems.car,text: carDetails.i18n,isOpenButton: false,onTap: () {
                        NavigatorManager.instance.pushToPage(NavigatesRoutes.carView);
                      },),
                      ElevatedButton(onPressed: () async{
                        ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
                        await currentUser?.logout();
                        if(context.mounted){
                          NavigatorManager.instance.pushReplacement(NavigatesRoutes.login);
                        }
                      }, child: Text('Çıkış Yap'))
                    ]),
              ),
            ),
          ],
        )
      ),
    );
  }
}

class ProfileTool extends StatelessWidget {
  const ProfileTool({super.key, this.pngItem, this.text, this.isOpenButton, this.onTap, this.formControlName, this.onChanged,});
  final PngItems? pngItem;
  final String? text;
  final bool? isOpenButton;
  final void Function()? onTap;
  final String? formControlName;
  final void Function(FormControl<bool>)? onChanged;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        height: 52.h,
        width: context.myWidth,
        decoration:
        BoxDecoration(
          border: Border.all(width: 1.w,color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pngItem==null? const SizedBox.shrink():
              Padding(
                padding: EdgeInsets.only(left: 15.w,bottom: 10.h,top: 10.h),
                child: Image.asset(pngItem!.pngPath),
              ),
              Text(text ?? '',style: context.myTextTheme.headlineSmall,),
              isOpenButton==null ||isOpenButton== false? SizedBox(height: 35.h,width: 79.w,) : ReactiveSwitch(formControlName: formControlName,onChanged: onChanged)
            ]),
      ),
    );
  }
}


