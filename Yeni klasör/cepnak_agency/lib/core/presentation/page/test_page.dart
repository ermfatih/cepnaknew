// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:frontend/src/chat_management/application/start_chat_provider.dart';
// import 'package:frontend/src/chat_management/presentation/widget/select_file_menu.dart';
// import 'package:frontend/src/core/application/beneficiary_provider.dart';
// import 'package:frontend/src/core/presentation/widget/dynamic_button.dart';
// import 'package:frontend/src/core/presentation/widget/open_document_dialog.dart';
// import 'package:frontend/src/project_management/data/parse_project_repository.dart';
// import 'package:go_router/go_router.dart';
// import 'package:i18n_extension/default.i18n.dart';
// import '../../../../chat_management/presentation/page/chat_list_page.dart';
// import '../../../../chat_management/presentation/page/chat_page.dart';


// class TestPage extends ConsumerWidget {
//   const TestPage({super.key});
//   static String get routeName => "test-page";
//   static String get routePath => "/$routeName";
//   @override
//   Widget build(BuildContext context, ref) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         DynamicButton(title: 'Upload File'.i18n,onPressed: () {
//           openDocumentDialog(context,isVisible: true);
//         },),

//         DynamicButton(onPressed: () {
//           ShowMenu().selectFileDialog(context, ref);

//         },),
//         DynamicButton(width:200,title: 'Start Chat With Beneficiary1'.i18n,onPressed: () async{
//           final receiverBeneficiary=await ref.read(getBeneficiaryProvider('FHsgD9CACI').future);
//           await ref.read(startChatProvider(receiverBeneficiary).future).then((value) {
//             if(value!=null){
//               ref.read(chatProvider.notifier).state=value;
//               context.push("${ChatListPage.routePath}/${ChatPage.routeName}");
//             }
//           });
//         },),
//         Text('.............'*10,maxLines: 1),
//         SizedBox(
//           height: 380,
//           child: FutureBuilder(
//             future: ref.read(parseProjectRepositoryProvider).getProjectById(id:'ieCJPUamKg'),
//             builder: (context, snapshot) {
//             final donationsList=snapshot.data?.donations?.where((element) => element.donorId?.isAllowChatWithBeneficiary==true).toList();
//             final volunteerList=snapshot.data?.volunteerId;
//             final manager=snapshot.data?.managerId;
//             return Column(
//               children: [
//                 const Text('Donations'),
//                 Expanded(
//                   child: ListView.builder(
//                     padding: EdgeInsets.zero,
//                     itemCount: donationsList?.length??0,
//                     itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(donationsList?[index].donorId?.name ??''),
//                       trailing: ElevatedButton(onPressed: () async{
//                         await ref.read(startChatProvider(donationsList?[index].donorId).future).then((value) {
//                           if(value!=null){
//                             ref.read(chatProvider.notifier).state=value;
//                             context.push("${ChatListPage.routePath}/${ChatPage.routeName}");
//                           }
//                         });
//                       },child:const Text('Start Chat')),
//                     );
//                   },),
//                 ),
//                 const Text('Volunteers'),
//                 Expanded(
//                   child: ListView.builder(
//                     padding: EdgeInsets.zero,
//                     itemCount: volunteerList?.length??0,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(volunteerList?[index].name ??''),
//                         trailing: ElevatedButton(onPressed: () async{
//                           await ref.read(startChatProvider(volunteerList?[index]).future).then((value) {
//                             if(value!=null){
//                               ref.read(chatProvider.notifier).state=value;
//                               context.push("${ChatListPage.routePath}/${ChatPage.routeName}");
//                             }
//                           });

//                         },child:const Text('Start Chat')),
//                       );
//                     },),
//                 ),
//                 const Text('Manager'),
//                 ListTile(
//                   title: Text(manager?.managerName ??''),
//                   trailing: ElevatedButton(onPressed: () async{
//                     await ref.read(startChatProvider(manager).future).then((value) {
//                       if(value!=null){
//                         ref.read(chatProvider.notifier).state=value;
//                         context.push("${ChatListPage.routePath}/${ChatPage.routeName}");
//                       }
//                     });
//                   },child:const Text('Start Chat')),
//                 )
//               ],
//             );

//           },),
//         ),
//       ],
//     );
//   }
// }