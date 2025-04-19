// import 'dart:io';
// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shafak_donor/src/authentication/provider/auth_notifier.dart';
// import 'package:shafak_donor/src/core/application/file_picker_provider.dart';
// import 'package:shafak_donor/src/core/presentation/widget/dynamic_input.dart';
// import 'package:shafak_donor/src/core/presentation/widget/file_list_tile.dart';
// import 'package:shafak_donor/src/core/presentation/widget/document_drop_down_widget.dart';
// import 'package:shafak_donor/theme.dart';
// import 'package:go_router/go_router.dart';
// import 'package:i18n_extension/default.i18n.dart';
// import 'package:reactive_forms/reactive_forms.dart';
// import '../../../authentication/domain/document.dart';
// import '../../application/documents_provider.dart';
// import '../../application/picked_file_notifier.dart';
// import '../widget/choose_file_type_dialog.dart';
// import '../widget/dynamic_button.dart';

// class DocumentUploadingComponent extends ConsumerWidget {
//   const DocumentUploadingComponent(
//       {super.key,
//       this.isVisible,
//       this.onSubmit,
//       this.isEditProfile = true,
//       this.beneficiaryForm,
//       this.readOnly = false});
//   final bool? isVisible;
//   final void Function()? onSubmit;
//   final bool isEditProfile;
//   final bool readOnly;
//   final FormGroup? beneficiaryForm;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final colors = ref.read(appColorLightProvider);
//     final form = ref.watch(fileFormProvider);
//     final list = ref.watch(myDocumentsProvider);

//     return SingleChildScrollView(
//         physics: const ClampingScrollPhysics(),
//         child: ReactiveForm(
//           formGroup: form,
//           child: Column(
//             children: [
//               Visibility(
//                   visible: isVisible ?? false,
//                   child: Consumer(
//                     builder: (context, ref, child) {
//                       return ref.watch(authNotifierProvider).when(
//                             data: (auth) {
//                               if (auth.beneficiary?.documents == null) {
//                                 return const SizedBox(height: 0);
//                               }
//                               return Container(
//                                 decoration: BoxDecoration(
//                                     color: colors.orangish[200],
//                                     borderRadius: BorderRadius.all(
//                                         Radius.circular(16.r))),
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 8.w, vertical: 6.h),
//                                 margin: EdgeInsets.only(bottom: 20.h),
//                                 child: Column(
//                                   children: [
//                                     Text(
//                                         'Choose and Add a File from your Profile Documents:'
//                                             .i18n,
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .labelSmall),
//                                     SizedBox(height: 10.h),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         DocumentDropDownWidget(
//                                             width: 150.w,
//                                             height: 35.h,
//                                             placeholder: 'Choose One'.i18n,
//                                             urlList: auth.beneficiary?.documents
//                                                 ?.map((e) => e.description)
//                                                 .toList(),
//                                             control: 'profileDocument',
//                                             dropDownIdList: auth
//                                                 .beneficiary?.documents!
//                                                 .map((e) => e.objectId!)
//                                                 .toList()),
//                                         const Spacer(flex: 1),
//                                         DynamicButton(
//                                           title: 'Add',
//                                           onPressed: () {
//                                             if (form
//                                                 .control('profileDocument')
//                                                 .valid) {
//                                               final List<Document> list =
//                                                   auth.beneficiary?.documents ??
//                                                       [];
//                                               ref
//                                                   .read(myDocumentsProvider
//                                                       .notifier)
//                                                   .uploadFileFromPlatform(
//                                                       null, null,
//                                                       document: list[auth
//                                                           .beneficiary!
//                                                           .documents!
//                                                           .indexWhere((element) =>
//                                                               form
//                                                                   .control(
//                                                                       'profileDocument')
//                                                                   .value ==
//                                                               element
//                                                                   .objectId)]);
//                                             }
//                                             form
//                                                 .control('profileDocument')
//                                                 .markAsTouched();
//                                           },
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                             error: (error, stackTrace) => const Text('data'),
//                             loading: () => const Center(
//                                 child: CircularProgressIndicator()),
//                           );
//                     },
//                   )),
//               Container(
//                 padding: const EdgeInsets.only(
//                     top: 10, bottom: 10, left: 10, right: 10),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(16.r)),
//                     border: Border.all(color: colors.greyish)),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     DynamicButton(
//                       height: 30.h,
//                       width: double.infinity,
//                       title: 'Select File'.i18n,
//                       onPressed: () async {
//                         Platform.isIOS
//                             ? await buildShowDialog(context, ref)
//                             : await ref
//                                 .read(pickedFileProvider.notifier)
//                                 .pickFileFromFilePicker(context);
//                       },
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Text('File Description '.i18n,
//                               style: Theme.of(context).textTheme.labelSmall),
//                         ),
//                         Expanded(
//                             flex: 4,
//                             child: DynamicInput(
//                               height: 30,
//                               placeholder: 'Add your file description'.i18n,
//                               control: 'description',
//                             ))
//                       ],
//                     ),
//                     SizedBox(height: 5.h),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               flex: 2,
//                               child: Consumer(
//                                 builder: (context, ref, child) {
//                                   final file = ref.watch(pickedFileProvider);
//                                   return Text(
//                                     file?.name.toString() ?? '',
//                                     style:
//                                         Theme.of(context).textTheme.labelSmall,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   );
//                                 },
//                               ),
//                             ),
//                             const Spacer(),
//                             Expanded(
//                               child: Consumer(
//                                 builder: (context, ref, child) {
//                                   final file = ref.watch(pickedFileProvider);
//                                   return file == null
//                                       ? const SizedBox.shrink()
//                                       : DynamicButton(
//                                           title: 'Upload',
//                                           onPressed: () async {
//                                             if (form
//                                                 .control('description')
//                                                 .valid) {
//                                               final file =
//                                                   ref.watch(pickedFileProvider);
//                                               ref
//                                                   .read(myDocumentsProvider
//                                                       .notifier)
//                                                   .uploadFileFromPlatform(
//                                                       file,
//                                                       form
//                                                           .control(
//                                                               'description')
//                                                           .value);
//                                               form.reset();
//                                               ref
//                                                   .read(pickedFileProvider
//                                                       .notifier)
//                                                   .deleteFile();
//                                             }
//                                             form
//                                                 .control('description')
//                                                 .markAsTouched();
//                                           },
//                                         );
//                                 },
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 11),
//                 child: Divider(color: colors.orangish),
//               ),
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(7).h,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(16.r)),
//                     border: Border.all(color: colors.greyish)),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 5),
//                         child: Text('Current File List'.i18n,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .labelSmall
//                                 ?.copyWith(
//                                     color: colors.orangish,
//                                     fontWeight: FontWeight.bold)),
//                       ),
//                       SizedBox(
//                         height: 200.h,
//                         width: 300.w,
//                         child: ListView.builder(
//                           physics: const ClampingScrollPhysics(),
//                           padding: EdgeInsets.zero,
//                           itemCount: list.length,
//                           shrinkWrap: true,
//                           itemBuilder: (context, index) {
//                             return FileListTile(
//                               parseFileBase:
//                                   list[index].document?.parseFileBase,
//                               error: list[index].error,
//                               values: list[index].currentCount,
//                               size: list[index].document?.size ?? 0,
//                               description: list[index].document?.description,
//                             );
//                           },
//                         ),
//                       )
//                     ]),
//               ),
//               SizedBox(height: 15.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   DynamicButton(
//                     width: 100.w,
//                     height: 30.h,
//                     type: ButtonTypes.Danger,
//                     title: 'Close'.i18n,
//                     onPressed: () {
                     
//                       context.pop();
//                     },
//                   ),
//                   Visibility(
//                     visible: !readOnly,
//                     child: DynamicButton(
//                       width: 100.w,
//                       height: 30.h,
//                       title: 'Submit'.i18n,
//                       onPressed: () async {
//                         BotToast.showLoading();
//                         List<Document> documents = ref
//                             .read(myDocumentsProvider)
//                             .where((element) =>
//                                 element.error == null &&
//                                 element.currentCount == 1)
//                             .map((e) {
//                           return e.document!;
//                         }).toList();
                       
//                         if (isEditProfile) {
//                           beneficiaryForm?.control("documents").value =
//                               documents;
//                         }
//                         // ref
//                         // .read(myDocumentsProvider.notifier)
//                         // .deleteAllDocuments();
//                         if (context.mounted) {
//                           context.pop();
//                         }
//                         BotToast.closeAllLoading();
//                       },
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ));
//   }

//   Future<void> buildShowDialog(BuildContext context, WidgetRef ref) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return const ChooseFileTypeDialog();
//       },
//     );
//   }
// }
