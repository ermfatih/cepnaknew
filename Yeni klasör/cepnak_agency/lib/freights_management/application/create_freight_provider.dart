import 'package:bot_toast/bot_toast.dart';
import 'package:cepnak_agency/authentication/provider/auth_notifier.dart';
import 'package:cepnak_agency/core/domain/address_domain.dart';
import 'package:cepnak_agency/freights_management/data/parse_freights_repository.dart';
import 'package:cepnak_agency/freights_management/domain/destination_model.dart';
import 'package:cepnak_agency/freights_management/domain/freight.dart';
import 'package:cepnak_agency/freights_management/domain/source_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';
import '../../authentication/domain/agent.dart';
import 'freight_form.dart';

final createFreightProvider=FutureProvider.autoDispose((ref) async{
  final repo=ref.read(parseFreightRepositoryProvider);
  final agent=ref.watch(authNotifierProvider).value?.agent;
  final form=ref.watch(createFreightForm);
  final source=Source(
    name: form.control('source.name').value,
    phone1: (form.control('source.phone1').value as PhoneNumber?)?.international,
    location:form.control('source.location').value ,
    address: Address(
      city: form.control('source.address.city').value,
      country:form.control('source.address.country').value ,
      description: form.control('source.address.description').value,
      district:form.control('source.address.district').value,
    ),
  );
  final destination=Destination(
    name: form.control('destination.name').value,
    phone1: (form.control('destination.phone1').value as PhoneNumber?)?.international,
    location:form.control('destination.location').value ,
    address: Address(
      city: form.control('destination.address.city').value,
      country:form.control('destination.address.country').value ,
      description: form.control('destination.address.description').value,
      district:form.control('destination.address.district').value ,
    ),
  );

  BotToast.showLoading();
  final response=await destination.create();
  final response2=await source.create();
  await repo.createFreights(freightModel: Freight(
    agentId: agent ?? Agent.clone(),
    name: form.control('name').value,
    cargoType: form.control('cargoType').value,
    commission: form.control('commission').value,
    deliveryDate:form.control('deliveryDate').value,
    startDate:form.control('startDate').value ,
    price: form.control('price').value,
    distance: form.control('distance').value,
    weight: form.control('weight').value,
    destination: response.result,
    source: response2.result,
  ));
  BotToast.closeAllLoading();
});