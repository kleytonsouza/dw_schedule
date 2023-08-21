import 'package:dw_schedule/src/core/ui/constants.dart';
import 'package:dw_schedule/src/core/ui/schedule_icons.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final bool hideUploadButton;
  const AvatarWidget({super.key, this.hideUploadButton = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 102,
      height: 102,
      child: Stack(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstants.avatar),
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: Offstage(
              offstage: hideUploadButton,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: ColorsConstants.lightBlue,
                      width: 4,
                    ),
                    shape: BoxShape.circle),
                child: const Icon(
                  ScheduleIcons.addEmployee,
                  color: ColorsConstants.lightBlue,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
