/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/core/data/agent_repository.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../authentication/domain/beneficiary.dart';
import '../../authentication/domain/document.dart';

final parseBeneficiaryRepositoryProvider =
Provider.autoDispose((ref) => ParseBeneficiaryRepository());
class ParseBeneficiaryRepository implements BeneficiaryRepository{
  @override
  Future<void> createBeneficiary({required Beneficiary beneficiary}) async{
    await beneficiary.create();
  }

  @override
  Future<void> updateBeneficiary({required Beneficiary beneficiary}) async{

  }

  @override
  Future<Beneficiary> getBeneficiary({required String id}) async{
    final beneficiary = QueryBuilder(Beneficiary.clone())..whereEqualTo('objectId', id);
    final response = await beneficiary.find();
    return response.first;
  }

  @override
  Future<Beneficiary> getBeneficiaryByOwner({required ParseUser user}) async {
    final beneficiary = QueryBuilder(Beneficiary.clone())
      ..whereEqualTo('owner', user);
    final response = await beneficiary.find();
    return response.first;
  }

  @override
  Future<void> updateBeneficiaryDocuments({required List<Document>? documents,required String beneficiaryId})async {
    var beneficiary=ParseObject('Beneficiary');
    beneficiary.objectId=beneficiaryId;
    documents?.forEach((element) async{
      await element.create();
      beneficiary.addRelation('documents', [element]);
      await beneficiary.update();
    });
  }

  @override
  Future<List<Document>?> getBeneficiaryDocuments({required String beneficiaryId})async {
    final queryBuilder = QueryBuilder<Document>(Document.clone())..whereRelatedTo('documents', 'Beneficiary', beneficiaryId);
    final response=await queryBuilder.query();
    if (response.success) {
      return response.results?.map((e) => e as Document).toList();
    } else {
      throw Exception('Error in Parse query: ${response.error!.message}');
    }
  }
}*/