import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class RegisterService{
  ParseUser? _currentUser;

  Future<void> createUser({required String userName,required String phoneNumber,required String city})async{
    final user=await ParseUser.createUser(phoneNumber,' ');
    final response =await user.signUp(allowWithoutEmail: true);
    if(response.success){
      final carriers=ParseObject('carriers')
        ..set('userId',user.objectId)
        ..set('phoneNumber', phoneNumber)
        ..set('name', userName)..set('city', city)
        ..set('isBreak', false);

      await carriers.save();
    }else{
      throw response.error!.message;
    }
  }
  void logout()async{
    _currentUser = await ParseUser.currentUser() as ParseUser?;
    await _currentUser?.logout();
  }


  Future<ParseUser?> getUser() async {
    _currentUser = await ParseUser.currentUser() as ParseUser?;
    return _currentUser;
  }


  Future<bool> hasUserLogged() async {
    ParseUser currentUser = await ParseUser.currentUser() as ParseUser;
    final ParseResponse? parseResponse =
    await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }


  Future<ParseResponse> login({required String phone})async{
    ParseUser user=ParseUser(phone ,' ', null);
    final response=await user.login();
    return response;
  }
}