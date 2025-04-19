import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../theme.dart';
import '../../domain/navigation_item.dart';

class CustomBottomAppBar extends ConsumerWidget {
  const CustomBottomAppBar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorProvider = ref.read(appColorLightProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 25, left: 5, right: 5).h,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          color: colorProvider.whiteish,
          border:
              Border.all(width: 1.w, color: colorProvider.whiteish.shade100),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          child: _buildNavigationRow(ref, context),
        ),
      ),
    );
  }
}

Widget _buildNavigationRow(WidgetRef ref, BuildContext context) {
  final activeButtonIndex = ref.watch(activeButtonIndexProvider);
  final themeColors = Theme.of(context).colorScheme;
  List<Widget> buildNavItems(List<NavigatorItem> items) {
    return List.generate(items.length, (index) {
      final isSelected = activeButtonIndex == index;
      final color = isSelected ? themeColors.secondary : themeColors.secondary;
      return Expanded(
        child: InkWell(
          onTap: () {
            ref.read(activeButtonIndexProvider.notifier).state = index;
            context.go(items[index].initialLocation.toString());
          },
          child: IconButtonWithDescription(
            icon: Icon(
              items[index].iconName,

              color: color,
              size: 25.sp,
            ),
            description: items[index].description,
            color: color,
            isActive: isSelected,
          ),
        ),
      );
    });
  }

  return SizedBox(
    height: 59.h,
    width: 389.w,
    child: Row(
      children: [
        ...buildNavItems(bottonNavigationList),
      ],
    ),
  );
}
class IconButtonWithDescription extends StatelessWidget {
  final Widget icon;
  final String description;
  final Color color;
  final bool isActive;

  const IconButtonWithDescription({
    super.key,
    required this.icon,
    required this.description,
    required this.color,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (isActive)
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: color,
              height: 1.h,
              width: 53.w,
            ),
          ),
        Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              icon,
              SizedBox(
                height: 8.h,
              ),
              if(isActive) Text(description , style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color,fontSize: 10.r),),
            ]),
      ],
    );
  }
}