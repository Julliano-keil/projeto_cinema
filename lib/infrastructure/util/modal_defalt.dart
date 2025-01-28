import 'package:flutter/material.dart';

///utility responsible for standardizing the modes
///
/// how to use:
///
/// 1: Pass context (required BuildContext context) -=-=
/// 2: a maximum size (required double maxHeight) -=-=
///3: pass a widget(required Widget widget)-=-=
modalDefault<T>({
  required BuildContext context,
  required double maxHeight,
  double? minHeight,
  bool? isCatcher = true,
  required Widget widget,
}) async {
  final returnValue = await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.black,
    useSafeArea: false,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: maxHeight,
      minHeight: minHeight ?? 0,
    ),
    scrollControlDisabledMaxHeightRatio: 1,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
    ),
    builder: (modalContext) {
      return Container(
        decoration: const BoxDecoration(
           // Cor da parte superior
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          border: Border(
            top: BorderSide(
              color: Colors.deepPurple
            )
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DetailsHeaderModal(),
            widget,
          ],
        ),
      );
    },
  );

  return returnValue;

}

///utility responsible for standardizing the modes
///
/// how to use:
///
/// 1: Pass context (required BuildContext context) -=-=
/// 2: a maximum size (required double maxHeight) -=-=
///3: pass a widget(required Widget widget)-=-=
modalDefault2<T>({
  required BuildContext context,
  required double maxHeight,
  double? minHeight,
  required Widget widget,
}) async {
  final returnValue = await showModalBottomSheet<T>(
    context: context,
    backgroundColor: Theme.of(context).cardColor,
    constraints: BoxConstraints(
      minHeight: minHeight ?? 0.0,
      maxHeight: maxHeight,
    ),
    scrollControlDisabledMaxHeightRatio: 1,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
    ),
    builder: (modalContext) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DetailsHeaderModal(),
          widget,
        ],
      );
    },

  );

  return returnValue;
}

/// modal header detail
class DetailsHeaderModal extends StatelessWidget {
  /// constructor
  const DetailsHeaderModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.deepPurple,
              ),
            ),
          )
        ],
      ),
    );
  }
}
