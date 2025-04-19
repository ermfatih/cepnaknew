
import 'package:cepnak/core/extensions/context_extensions.dart';
import 'package:cepnak/features/_components/button/green_elevated_button.dart';
import 'package:cepnak/features/_components/button/pink_elevated_button.dart';
import 'package:cepnak/features/_components/sized_box/custom_spacer.dart';
import 'package:cepnak/features/_components/text_field/custom_form_field.dart';
import 'package:cepnak/features/home/freights_detail/freights_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

class InvoiceCreationView extends StatefulWidget {
  const InvoiceCreationView({super.key});

  @override
  State<InvoiceCreationView> createState() => _InvoiceCreationViewState();
}

class _InvoiceCreationViewState extends State<InvoiceCreationView> {
  final form=FormGroup({
    'no':FormControl<String>( validators: [Validators.required, Validators.email,]),
    'amount':FormControl<String>(validators: [Validators.required,]),
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Fatura Kes')),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingLowAll,
          child: ReactiveForm(
            formGroup: form,
            child: Column(
              children: [
                SizedBox(height: 20.h,),
                CustomReactiveField(formControlName: 'no'),
                CustomReactiveField(formControlName: 'amount'),
                SizedBox(width: 30.w,),
                SizedBox(height: 30.h,),
                Center(child: GreenElevatedButton(text: 'Fatura Bilgilerini Kaydet',onPressed: () {
                  if(form.valid){
                    print('valide edildi');
                    print(form.value['no']);//form kontroller gibi
                  }
                  form.markAllAsTouched();

                },))
              ],
            ),
          ),
        ),
      ),
    );
  }
}


