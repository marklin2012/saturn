import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/mobile/st_button/common.dart';

enum STImageScale {
  origin,
  scale1v1,
  scale3v2,
  scale4v3,
  scale16v9,
}

enum STImageType {
  nono,
  fail,
  custom,
  loading,
  loadingGrey,
}

const assetsPackage = 'saturn';
const assetsNameAvatar = 'images/default_avatar.png';
const assetsNameLogo = 'images/default_logo.png';
const assetsNameTeam = 'images/default_team.png';
const assetsNameHolder = 'images/default_placeholder.png';

class STImage extends StatelessWidget {
  const STImage({
    Key? key,
    this.fit,
    this.width,
    this.iconWidth,
    this.scale,
    this.assetsName,
    this.package,
    this.isCircle = false,
    this.radius = 4.0,
    this.backgroundColor,
    this.type,
    this.customChild,
  }) : super(key: key);

  final BoxFit? fit;
  final double? width;
  final double? iconWidth;
  final STImageScale? scale;
  final String? assetsName;
  final String? package;
  final bool isCircle;
  final double? radius;
  final Color? backgroundColor;
  final STImageType? type;
  final Widget? customChild;

  const STImage.avatar({
    Key? key,
    this.fit = BoxFit.cover,
    this.width = 50,
    this.iconWidth = 50,
    this.scale = STImageScale.origin,
    this.assetsName = assetsNameAvatar,
    this.package = assetsPackage,
    this.isCircle = true,
    this.radius,
    this.backgroundColor,
    this.type = STImageType.nono,
    this.customChild,
  }) : super(key: key);

  const STImage.logo({
    Key? key,
    this.fit = BoxFit.cover,
    this.width = 50,
    this.iconWidth = 50,
    this.scale = STImageScale.origin,
    this.assetsName = assetsNameLogo,
    this.package = assetsPackage,
    this.isCircle = true,
    this.radius,
    this.backgroundColor,
    this.type = STImageType.nono,
    this.customChild,
  }) : super(key: key);

  const STImage.team({
    Key? key,
    this.fit = BoxFit.cover,
    this.width = 50,
    this.iconWidth = 50,
    this.scale = STImageScale.origin,
    this.assetsName = assetsNameTeam,
    this.package = assetsPackage,
    this.isCircle = true,
    this.radius,
    this.backgroundColor,
    this.type = STImageType.nono,
    this.customChild,
  }) : super(key: key);

  const STImage.holder({
    Key? key,
    this.fit = BoxFit.cover,
    this.width,
    required this.iconWidth,
    this.scale = STImageScale.origin,
    this.assetsName = assetsNameHolder,
    this.package = assetsPackage,
    this.isCircle = false,
    this.radius = 4.0,
    this.backgroundColor = STColor.backgroundColor,
    this.type = STImageType.nono,
    this.customChild,
  }) : super(key: key);

  const STImage.diffType({
    Key? key,
    this.fit = BoxFit.cover,
    required this.width,
    this.type = STImageType.nono,
    this.scale = STImageScale.scale3v2,
    this.isCircle = false,
    this.radius = 4.0,
    this.backgroundColor = STColor.backgroundColor,
    this.iconWidth,
    this.assetsName,
    this.package,
    this.customChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(isCircle ? (width ?? iconWidth)! / 2 : 4.0),
        color: backgroundColor,
      ),
      width: scale == STImageScale.origin
          ? width ?? iconWidth
          : iconWidth ?? width,
      height: scale == STImageScale.origin ? width ?? iconWidth : _getHeight(),
      child: _buildDiffenceType(),
    );
  }

  double? _getHeight() {
    final _scaleW = iconWidth ?? width;
    double? _height;
    switch (scale) {
      case STImageScale.scale1v1:
        _height = _scaleW;
        break;
      case STImageScale.scale3v2:
        _height = (_scaleW! * 2 / 3).floorToDouble();
        break;
      case STImageScale.scale4v3:
        _height = (_scaleW! * 3 / 4).floorToDouble();
        break;
      case STImageScale.scale16v9:
        _height = (_scaleW! * 9 / 16).floorToDouble();
        break;
      default:
        _height = null;
        break;
    }
    return _height;
  }

  Widget _buildDiffenceType() {
    switch (type) {
      case STImageType.nono:
        return _buildNoType();
      case STImageType.loading:
        return _buildLoadingType();
      case STImageType.fail:
        return _buildFailType();
      case STImageType.custom:
        return _buildCustomType();
      default:
        return Container();
    }
  }

  Widget _buildNoType() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(isCircle ? iconWidth! / 2 : 4.0),
      child: Image.asset(
        assetsName!,
        width: iconWidth,
        height: _getHeight(),
        fit: fit,
        alignment: fit == BoxFit.none ? Alignment.centerLeft : Alignment.center,
        package: package,
      ),
    );
  }

  Widget _buildLoadingType() {
    return const Center(
      child: STLoading(text: '', alwaysLoading: true),
    );
  }

  Widget _buildFailType() {
    return const Center(
      child: Text(
        '加载失败',
        style: TextStyle(
          color: STColor.thrRankGrey,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildCustomType() {
    if (customChild == null) return _buildFailType();
    return Center(
      child: customChild,
    );
  }
}
