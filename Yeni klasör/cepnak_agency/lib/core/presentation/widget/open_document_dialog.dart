// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:reactive_forms/reactive_forms.dart';
// import 'package:shafak_donor/src/core/presentation/component/document_uploading_component.dart';

// Future<void> openDocumentDialog(BuildContext context,
//     {bool? isVisible = false,
//     bool isEditProfile = true,
//     FormGroup? form,
//     bool readOnly = false,
//     }) async {
//   await showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20))),
//         backgroundColor: Colors.white,
//         alignment: Alignment.center,
//         contentPadding: const EdgeInsets.all(15).h,
//         content: DocumentUploadingComponent(
//           isVisible: isVisible,
//           isEditProfile: isEditProfile,
//           beneficiaryForm: form,
//           readOnly: readOnly,
//         ),
//       );
//     },
//   );
// }
