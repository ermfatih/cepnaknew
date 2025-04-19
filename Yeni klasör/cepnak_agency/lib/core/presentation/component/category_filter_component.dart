/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shafak_donor/src/authentication/application/authtication_provider.dart';
import 'package:shafak_donor/src/authentication/provider/auth_notifier.dart';
import 'package:shafak_donor/src/core/presentation/widget/main_drop_down_search_widget.dart';
import 'package:shafak_donor/theme.dart';
import 'package:i18n_extension/default.i18n.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../theme.dart';

class CategoryFilterComponent extends ConsumerWidget {
  const CategoryFilterComponent(
      {super.key, required this.colors, this.isLiveFilter = false});
  final AppColor colors;
  final bool isLiveFilter;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: ReactiveFormConsumer(
            builder: (context, formGroup, child) {
              final data = ref.read(authNotifierProvider).value?.settings;
              List<String> categoryList = ['All'];
              if (data != null) {
                categoryList
                    .addAll(data.sysProjects.map((e) => e.name).toList());
              }
              return MainDropdownSearchWidget(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    borderSide: BorderSide(color: colors.greyish.shade200)),
                radius: 8.r,
                onDismissed: () {
                  formGroup.control('subCategory').reset();
                  if (isLiveFilter) ref.read(refreshProvider.notifier).state++;
                },
                textAlign: TextAlign.center,
                width: 338.w,
                height: 20.h,
                prefixIcon: Icon(Icons.filter_alt_outlined, size: 18.sp),
                popupPropsIsMenu: true,
                search: false,
                formControlName: 'category',
                placeholder: 'Category'.i18n,
                item: categoryList,
              );
            },
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Align(
          alignment: Alignment.center,
          child: ReactiveFormConsumer(
            builder: (context, formGroup, child) {
              final data = ref.read(authNotifierProvider).value?.settings;
              Map<String, List<String>> categoryMap = {};
              if (data != null) {
                for (var sysSubCategory in data.sysSubCategory) {
                  String category = sysSubCategory.type;
                  String subCategory = sysSubCategory.name;
                  if (categoryMap.containsKey(category)) {
                    categoryMap[category]!.add(subCategory);
                  } else {
                    categoryMap[category] = [subCategory];
                  }
                }
              }
              List<String> subCategoryList = ['All'];
              subCategoryList.addAll(categoryMap[formGroup
                          .control("category")
                          .value
                          .toString()
                          .toLowerCase()]
                      ?.toList() ??
                  []);
              return MainDropdownSearchWidget(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      borderSide: BorderSide(color: colors.greyish.shade200)),
                  onDismissed: () {
                    if (isLiveFilter) {
                      ref.read(refreshProvider.notifier).state++;
                    }
                  },
                  textAlign: TextAlign.center,
                  width: 338.w,
                  height: 20.h,
                  prefixIcon: Icon(Icons.filter_alt_outlined, size: 18.sp),
                  popupPropsIsMenu: true,
                  search: false,
                  formControlName: 'subCategory',
                  placeholder: 'Sub Category',
                  item: categoryMap[formGroup
                              .control("category")
                              .value
                              .toString()
                              .toLowerCase()] !=
                          null
                      ? subCategoryList
                      : []);
            },
          ),
        ),
      ],
    );
  }
}*/
