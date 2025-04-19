import 'package:cepnak/product/constant/png_items.dart';
import 'package:flutter/cupertino.dart';

class FreightsStatesConstant{
  static const List<String> stateList=[
    'İş Alındı',
    'Yüklemeye Gidiliyor',
    'Yükleme Bekleniyor',
    'Yükleniyor',
    'Yüklendi',
    'Taşımada',
    'Alıcıya Ulaşıldı',
    'Boşaltma Bekleniyor',
    'Boşaltılıyor',
    'Boşaltıldı',
    'Teslimat Bitti',
    'Fatura Kesildi',
    'Ödeme Alındı',
    'İş Tamamlandı',
  ];
  static List<String> stateListPng=[
    PngItems.wait.pngPath,
    PngItems.freights.pngPath,
    PngItems.oldFreights.pngPath,
    PngItems.commission.pngPath,
    PngItems.locations.pngPath,
    PngItems.request.pngPath,
    PngItems.wait.pngPath,
    PngItems.wait.pngPath,
    PngItems.profile.pngPath,
    PngItems.home.pngPath,
    PngItems.wait.pngPath,
    PngItems.wait.pngPath,
    PngItems.wait.pngPath,
    PngItems.wait.pngPath,
  ];


}