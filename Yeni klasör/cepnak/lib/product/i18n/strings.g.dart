import 'package:i18n_extension/i18n_extension.dart';

const agentRequest='Acentaya Talep Gönder';
const buttonGoHome='Anasayfaya Git';
const buttonText = "buttonText";
const textWelcome = "textWelcome";
const createAccount="createAccount";
const welcome="welcome";
const name="name";
const phoneNumber="phoneNumber";
const haveAccount="haveAccount";
const login="login";
const enterCode='Enter code';

const notEmpty='The field cannot be left empty';
const shouldEmail='It should be in email format';
const selectCity='Select a city';
const searchCity='Search for a city';
const letsStart='Lets Start';
const sendCode='We have sent a 4-digit code to your phone';
const sendAgain='Send Again';
const cancel='Cancel';
const send='Send';
const remainingTime='Remaining time';
const second='second';
const sendRequest='Send Request';
const profile='Profil';

const showExpensive='Show Expensive';
const notification='Notification';
const darkTheme='Dark Theme';
const isBreak='Break';
const carDetails='Car Details';

const freightPosting='Taşıma İlanları';
const freightSelection='Taşıma Seçenekleri';
const invalid="Invalid username/password.";

extension Localization on String {

  static const _t = Translations.from("tr_tr", {

    invalid:{
      "tr_tr": "Geçersiz numara",
      "en_us": "Invalid username/password.",
    },
    freightPosting:{
      "tr_tr": "Taşıma ilanları",
      "en_us": "Freight Posting",
    },
    freightSelection:{
      "tr_tr": "Taşıma Seçenekleri",
      "en_us": "freight Selection",
    },
    profile:{
      "tr_tr": "Profil",
      "en_us": "Profile",
    },
    showExpensive:{
      "tr_tr": "Maliyeti Göster",
      "en_us": "Show Expensive",
    },
    notification:{
      "tr_tr": "Bildirimler",
      "en_us": "Notification",
    },
    isBreak:{
      "tr_tr": "Ara ver",
      "en_us": "Break",
    },
    darkTheme:{
      "tr_tr": "Dark Tema",
      "en_us": "Dark Theme",
    },
    carDetails:{
      "tr_tr": "Araç Detayları",
      "en_us": "Car Details",
    },
    sendRequest:{
      "tr_tr": "Talep Gönder",
      "en_us": "Send Request",
    },
    enterCode:{
      "tr_tr": "Kodu Giriniz",
      "en_us": "Enter Code",
    },
    second:{
      "tr_tr": "saniye",
      "en_us": "second",
    },
    remainingTime:{
      "tr_tr": "Kalan Süre",
      "en_us": "Remaining Time",
    },
    send:{
      "tr_tr": "Gönder",
      "en_us": "Send",
    },
    cancel:{
      "tr_tr": "İptal",
      "en_us": "cancel",
    },
    sendAgain:{
      "tr_tr": "Tekrar Gönder",
      "en_us": "Send Again",
    },
    sendCode:{
      "tr_tr": "Telefonunuza 4 haneli bir kod gönderdik",
      "en_us": "We have sent a 4-digit code to your phone",
    },
    letsStart:{
      "tr_tr": "Haydi Başlayalım",
      "en_us": "Lets Start",
    },
    notEmpty:{
      "tr_tr": "Bu alan boş bırakılamaz",
      "en_us": "The field cannot be left empty",
    },
    selectCity:{
      "tr_tr": "Şehir seçiniz",
      "en_us": "Select a city",
    },
    searchCity:{
      "tr_tr": "Şehir arayınız",
      "en_us": "Search for a city",
    },
    shouldEmail:{
      "tr_tr": "Email formatında olmalı",
      "en_us": "It should be in email format",
    },
    agentRequest:{
      "tr_tr": "Acentaya Talep Gönder",
      "en_us": "Send request agent",
    },

    buttonGoHome:{
      "tr_tr": "Anasayfaya Git",
      "en_us": "Go Home Page",
    },
    buttonText: {
      "tr_tr": "Giriş Yap",
      "en_us": "Login",
    },
    login: {
      "tr_tr": "Giriş Yap",
      "en_us": "Login",
    },
    haveAccount:{
      "tr_tr":"Hesabınız var mı?",
      "en_us":"Do you have account? Login"
    },
    textWelcome: {
      "tr_tr": "Hoşgeldiniz",
      "en_us": "Welcome",
    },
    createAccount:{
      "tr_tr":"Hesap Oluştur",
      "en_us":"Create Account"
    },
    welcome:{
      "tr_tr":"Hoşgeldiniz",
      "en_us":"welcome"
    },
    name:{
      "tr_tr":"isim Soyisim",
      "en_us":"Name Lastname"
    },
    phoneNumber:{
      "tr_tr":"Telefon Numarası",
      "en_us":"Phone Number"
    }
  });
  String get i18n => localize(this, _t);
}

