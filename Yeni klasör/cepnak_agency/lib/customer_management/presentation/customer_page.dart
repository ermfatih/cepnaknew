import 'package:cepnak_agency/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerPage extends ConsumerWidget {
  const CustomerPage({super.key});
  static String get routeName => 'customer';
  static String get routeLocation => '/$routeName';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text('Customer Page'.i18n);
  }
}
