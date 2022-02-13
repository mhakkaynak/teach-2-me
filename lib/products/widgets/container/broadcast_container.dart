import 'package:flutter/widgets.dart';
import 'package:teach_2_me/core/extension/context_extension.dart';

class BroadcastContainer extends Container {
  // TODO:  delete or use
  BroadcastContainer({
    Key? key,
    required double width,
    required double height,
    required String teacherName,
    required String streamName,
    required BuildContext context,
    required Widget child,
  }) : super(
          key: key,
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: context.currentTheme.primaryColor,
              borderRadius: BorderRadius.circular(32)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(teacherName),
              SizedBox(
                width: width - 100,
                height: height - 100,
                child: child,
              ),
              Text(streamName)
            ],
          ),
        );
}
