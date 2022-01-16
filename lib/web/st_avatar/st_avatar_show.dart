import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/web/st_avatar/st_avatar.dart';

class STAvatarShow extends StatelessWidget {
  const STAvatarShow({
    Key? key,
    required this.data,
  }) : super(key: key);

  final STAvatarData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: STColor.firRankFont,
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              color: STColor.firRankBlue,
              child: _buildImage(context),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: data.backgroundColor,
        image: data.image != null
            ? DecorationImage(
                image: data.image!,
                fit: BoxFit.cover,
              )
            : null,
        borderRadius: BorderRadius.circular(
          data.borderRadius ?? 4.0,
        ),
        border: Border.all(
          color: data.borderColor ?? Colors.transparent,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (data.iconData != null)
            Center(
              child: Icon(
                data.iconData,
                color: data.color,
                size: MediaQuery.of(context).size.width - 2,
              ),
            ),
          if (data.content != null)
            Text(
              data.content ?? '',
              style: TextStyle(
                fontSize: data.fontSize,
                color: data.color,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
    );
  }
}
