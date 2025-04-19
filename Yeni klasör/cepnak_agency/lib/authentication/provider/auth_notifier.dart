import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:cepnak_agency/authentication/data/parse_agent_repository.dart';
import 'package:cepnak_agency/authentication/domain/agent.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';
import '../../../../theme.dart';
import '../../core/domain/address_domain.dart';
import '../../core/presentation/widget/app_loading_widget.dart';
import '../application/authtication_provider.dart';
import '../application/verification_form_provider.dart';
import 'auth_state.dart';

bool isChangeStateFromSupScriptionUser = false;
bool isChangeStateFromSupScriptionSettings = false;
final golbalKeyEdiSecurityCodeFormProfileFormProvider = Provider<GlobalKey>((ref) => GlobalKey());
final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
Future<void> registerDeviceForPushNotifications(ParseUser user) async {
  /*ParseInstallation installation = await ParseInstallation.currentInstallation();
  String? token;
  token = await FirebaseMessaging.instance.getToken();
  if (token != null) {
    installation.set('deviceToken', token);
    installation.set('user', user);
    await installation.create();
  }*/
}

class AuthNotifier extends AsyncNotifier<AuthState> {
  ParseUser? currentParseUser;
  final List<String> scopes = <String>[
    'email',
    'https:' //www.googleapis.com/auth/contacts.readonly’,
  ];
  late GoogleSignIn _googleSignIn;
  GoogleSignInAccount? _googleCurrentUser;
  bool _googleIsAuthorized = false;
  StreamSubscription<GoogleSignInAccount?>? googleSubscription;
  Subscription? userSubscription;

  @override
  FutureOr<AuthState> build() async {
    ParseUser? user = await ParseUser.currentUser();
    if (user == null) {
      _googleSignIn = GoogleSignIn(
        scopes: scopes,
      );
      googleSubscription = _googleSignIn.onCurrentUserChanged
          .listen((GoogleSignInAccount? account) async {
        bool isAuthorized = account != null;
        if (kIsWeb && account != null) {
          isAuthorized = await _googleSignIn.canAccessScopes(scopes);
        }
        _googleCurrentUser = account;
        _googleIsAuthorized = isAuthorized;
        if (isAuthorized) {
          googleLogin();
        } else {
          await handleAuthorizeScopes();
        }
      });
      _googleSignIn.signInSilently();
      return const AuthState(
        status: AuthStatus.unAuthrized,
      );
    } else {
      try {
        currentParseUser = user;
        final queryBuilder = QueryBuilder<Agent>(Agent.clone())
          ..includeObject(["*"])
          ..whereEqualTo("owner", user);
        final response = await queryBuilder.first();
        if (response != null) {
          Agent currentUser = response;
          if (currentUser.fullName.isEmpty) {
            return AuthState(
                status: AuthStatus.unAuthrized, agent: currentUser);
          } else {
            if (currentUser.isActive == false) {
              BotToast.showText(
                  text:
                      "Your account has been suspended by the administration. For more information, please contact technical support."
                          .i18n,
                  contentColor: ref.read(appColorLightProvider).redish);
              return AuthState(
                  status: AuthStatus.unAuthrized, agent: currentUser);
            } else {
              await registerDeviceForPushNotifications(user);
              //await startUserSubscription(currentParseUser);
              BotToast.closeAllLoading();
              return AuthState(
                status: AuthStatus.authrized,
                agent: currentUser,
              );
            }
          }
        } else {
          return AuthState(
              status: AuthStatus.unAuthrized, username: user.username);
        }
      } catch (e) {
        user.logout();
        return const AuthState(
          status: AuthStatus.unAuthrized,
        );
      }
    }
  }

  Future logout() async {
    ParseUser? user = await ParseUser.currentUser();
    user?.logout();
    // await _handleSignOut();
    if (_googleCurrentUser != null) {
      _googleSignIn.signOut();
    }
    state = const AsyncData(AuthState(
      status: AuthStatus.unAuthrized,
    ));
  }

//phone login

  sendOTP() async {
    BotToast.showLoading();
    final authForm = ref.watch(authFormProvider);
    String? phoneNumber =
        (authForm.control("phone") as FormControl<PhoneNumber>)
            .value
            ?.international;
    if (phoneNumber == null || phoneNumber.isEmpty) {
      BotToast.closeAllLoading();
      BotToast.showText(
          text: "Please make sure to verify your phone number".i18n,
          contentColor: ref.read(appColorLightProvider).redish);
      state = const AsyncValue.data(AuthState(status: AuthStatus.unAuthrized));
    } else {
      //final ParseCloudFunction function = ParseCloudFunction('sendSMSOtp');
      /*final Map<String, String> params = <String, String>{
        'phoneNumber': phoneNumber
      };*/
      //final response = await function.execute(parameters: params);
      if (true) {
        BotToast.closeAllLoading();
        state =
            const AsyncValue.data(AuthState(status: AuthStatus.verfication));
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(
            text:
                "An error occurred while sending the verification number. Please make sure to connect to the Internet and verify the phone number"
                    .i18n,
            contentColor: ref.read(appColorLightProvider).redish);
        state =
            const AsyncValue.data(AuthState(status: AuthStatus.unAuthrized));
      }
    }
  }
  changePhoneNumber() {
    state = const AsyncValue.data(AuthState(status: AuthStatus.unAuthrized,agent: null,username: null));
  }
  changeRegistrationState() {
    state = const AsyncValue.data(AuthState(status: AuthStatus.registration,agent: null,username: null));
  }

  phoneLogin() async {
    BotToast.showLoading();
    final verificationForm = ref.watch(verificationFormProvider);
    final authForm = ref.watch(authFormProvider);
    String? phoneNumber =
        (authForm.control("phone") as FormControl<PhoneNumber>)
            .value
            ?.international;
    String? code =
        (verificationForm.control("verification") as FormControl<String>).value;
    if (phoneNumber == null || code == null) {
      BotToast.closeAllLoading();
      BotToast.showText(
        text: "Please verify your phone number and verification code".i18n,
        contentColor: ref.read(appColorLightProvider).redish,
      );
    } else {
      final loginResponse = await ParseUser(phoneNumber,' ',null).login();
      if(loginResponse.success){
        BotToast.showText(text: 'asdasdasd');
        await _getUser(loginResponse, phoneNumber);
        BotToast.showText(text: 'başarılı');
      }else{
        BotToast.closeAllLoading();
        currentParseUser = null;
        BotToast.showText(
            text: "Check phone number there is a no account.".i18n,
            contentColor: ref.read(appColorLightProvider).redish);
        state = const AsyncValue.data(AuthState(
          status: AuthStatus.unAuthrized,
        ));
      }

    }
  }

  _getUser(ParseResponse loginResponse, String username) async {
    currentParseUser = loginResponse.result;
    final queryBuilder = QueryBuilder<Agent>(Agent.clone())
      ..includeObject(["*"])
      ..whereEqualTo("owner", loginResponse.result);
    final userResponse = await queryBuilder.first();
    if (userResponse != null) {
      print('null değil yani');
      Agent currentUser = userResponse;
      try {
        await registerDeviceForPushNotifications(loginResponse.result);
      } catch (e) {}
      //await startUserSubscription(currentParseUser);
      BotToast.closeAllLoading();
      state = AsyncValue.data(AuthState(
        status: AuthStatus.authrized,
        agent: currentUser,
      ));
    } else {
      BotToast.closeAllLoading();
      state = AsyncValue.data(
          AuthState(status: AuthStatus.registration, username: username));
    }
  }

  Future<bool> createAccount(FormGroup form) async {
    try {
      BotToast.showLoading();
      final profileForm = form;
      final authForm = ref.watch(authFormProvider);
      String phoneNumber =
          (authForm.control("phone") as FormControl<PhoneNumber>)
                  .value
                  ?.international ??
              '';
      final image = profileForm.control("image").value as ParseFileBase?;
      final email = profileForm.control("email").value as String;
      final phone = (profileForm.control("phone") as FormControl<PhoneNumber>)
              .value
              ?.international ??
          '';
      final gender = profileForm.control("gender").value as Gender;
      final country = profileForm.control("address.country").value;
      final city = profileForm.control("address.city").value;
      final userName = profileForm.control("userName").value;
      final district = profileForm.control("address.district").value;
      Agent user = Agent(
        location: ParseGeoPoint(latitude: 0,longitude: 0),
        parseUserName: currentParseUser?.username ?? phoneNumber,
        owner: currentParseUser!,
        userName: userName,
        fullName: profileForm.control("fullname").value,
        logo: image,
        address: Address(country: country, city: city, district: district),
        isActive: true,
        birthDate: profileForm.control("birthdate").value,
        email: email,
        //phoneNumber: currentParseUser?.username ?? phone,
        phone: currentParseUser?.username ?? phone,
        gender: gender.name,
      );
      final ParseResponse userResponse = await user.save();
      print('---------------');
      print(userResponse.error);
      print('---------------');
      if (userResponse.success) {
        final Agent currentUser = userResponse.result;

        BotToast.closeAllLoading();
        state = AsyncValue.data(AuthState(
            status: AuthStatus.authrized,
            agent: currentUser,
            ));
        return true;
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(
            text:
                "An error has occurred. Please check the data entered and the Internet connection."
                    .i18n,
            contentColor: ref.read(appColorLightProvider).redish);
        state = AsyncValue.data(AuthState(
            status: AuthStatus.registration, username: user.userName));
        return false;
      }
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(
          text:
              "An error has occurred. Please check the data entered and the Internet connection."
                  .i18n,
          contentColor: ref.read(appColorLightProvider).redish);
      state = AsyncValue.data(AuthState(
          status: AuthStatus.registration, username: state.value?.username));
      return false;
    }
  }

  googleLogin() async {
    BotToast.showLoading();
    var authentication = await _googleCurrentUser?.authentication;
    if (_googleCurrentUser != null && authentication != null) {
      try {
        final loginResponse = await ParseUser.loginWith(
            'google',
            google(authentication.accessToken ?? "",
                _googleCurrentUser?.id ?? "", authentication.idToken ?? ""),
            username: _googleCurrentUser?.email);
        await _getUser(
            loginResponse, _googleCurrentUser?.email ?? "some@g.com");
        BotToast.closeAllLoading();
      } catch (e) {}
    } else {
      BotToast.closeAllLoading();
      BotToast.showText(
          text:
              "An error has occurred. Please check the data entered and the Internet connection."
                  .i18n,
          contentColor: ref.read(appColorLightProvider).redish);
    }
  }

  Future<void> handleSignIn() async {
    BotToast.showWidget(
      toastBuilder: (cancelFunc) => const AppLoadingWidget(),
    );
    try {
      final response = await _googleSignIn.signIn();
      response;
      if (!_googleIsAuthorized) {
        BotToast.showText(
            text:
                "Please make sure you have internet and try again later.".i18n,
            contentColor: ref.read(appColorLightProvider).redish);
        await handleAuthorizeScopes();
      }
      BotToast.closeAllLoading();
    } catch (error) {
      BotToast.showText(
          text: "$error", contentColor: ref.read(appColorLightProvider).redish);
    }
    BotToast.closeAllLoading();
  }

  Future<void> handleAuthorizeScopes() async {
    BotToast.showWidget(
      toastBuilder: (cancelFunc) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: Text(
            'In order to be able to register with a Google account, we need some permissions'
                .i18n),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              cancelFunc();
            },
            child: Text(
              'Cancel'.i18n,
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
          TextButton(
            onPressed: () async {
              final bool isAuthorized =
                  await _googleSignIn.requestScopes(scopes);
              _googleIsAuthorized = isAuthorized;
              if (isAuthorized) {
                await googleLogin();
              }
              cancelFunc();
            },
            child: Text('Request permissions'.i18n),
          ),
        ],
      ),
    );
  }

  //Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Future<void> updateUser(FormGroup formGroup, BuildContext context) async {
    // Accessing and casting form control values to their respective types
    //final String fullName = formGroup.control('fullname').value as String;
    //final String userName = formGroup.control('userName').value as String;
    //final DateTime birthDate = formGroup.control('birthdate').value as DateTime;
    // final bool isEmail = formGroup.control('isEmail').value as bool;
    //final String nationality = formGroup.control('nationality').value as String;
    //final String language = formGroup.control('language').value as String;

// For the address group, access the FormGroup and then the individual controls
    //final FormGroup addressGroup = formGroup.control('address') as FormGroup;
    //final ParseGeoPoint location = addressGroup.control('location').value as ParseGeoPoint;
    //final String country = addressGroup.control('country').value as String;
    //final String city = addressGroup.control('city').value as String;
    //final String district = addressGroup.control('district').value as String;
    //final String? description =addressGroup.control('description').value as String?;

// For the optional group

    final Agent? agent = state.value?.agent;
    final String? phoneNumber=agent?.phone;
    final PhoneNumber? formPhone = formGroup.control('newPhone').value as PhoneNumber?;
    final String? companyName = formGroup.control('name').value as String?;
    final String? email = formGroup.control('email').value as String?;

    final ParseFileBase? photo = formGroup.control('image').value as ParseFileBase?;
    BotToast.showLoading();
    if (photo != null) {
      await photo.save();
    }
    //agent.set('fullName', state.value?.agent?.fullName);
    //agent.objectId = state.value?.agent?.objectId;
    //agent.set("parseUserName", state.value?.agent!.parseUserName);
    //agent.set("owner", state.value?.agent!.owner);
    //agent.set("name", companyName);
    //agent.set("email", email);
    //agent.set(key, value)
    //agent.set("logo", photo);
    final success = await ref.read(parseAgentRepositoryProvider).updateAgent(agent: agent?.copyWith(
      email: email,
      name: companyName,
      phone: formPhone ==null? phoneNumber:formPhone.international,
      logo: photo,
    ));

    BotToast.cleanAll();
    BotToast.closeAllLoading();

    if (success==true) {
      BotToast.showText(text: "Profile updated successfully".i18n);
      final context = ref.read(golbalKeyEdiSecurityCodeFormProfileFormProvider).currentContext;
      if (context != null && context.mounted) {
        Navigator.pop(context);
      }
    } else {
      BotToast.showText(text: "an error occurred".i18n);
    }

  }

  /*startUserSubscription(ParseUser? user) async {
    final LiveQuery liveQuery = LiveQuery(debug: false);
    QueryBuilder<Agent> query = QueryBuilder<Agent>(Agent.clone())
      ..whereEqualTo('owner', user)
      ..includeObject(["*"]);
    userSubscription = await liveQuery.client.subscribe(query);
    userSubscription?.on(LiveQueryEvent.update, (userUpdate) async {
      isChangeStateFromSupScriptionUser = true;
      final donor = await ref
          .read(parseAgentRepositoryProvider)
          .getAgentByOwner(user: user!);
      state = AsyncValue.data(AuthState(
        status: AuthStatus.authrized,
        agent: donor,
      ));
    });
  }*/
}
