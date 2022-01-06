import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

const package = 'saturn';
const assetsNameAvatar = 'images/default_avatar.png';
const assetsNameAvatarBlue = 'assets/images/default_avatar_blue.png';
const assetsNameAvatarRect = 'assets/images/default_avatar_rect.png';
const assetsNameShark = 'assets/images/default_shark.png';

class WebAvatarPage extends StatelessWidget {
  const WebAvatarPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Avatar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text('基础展示'),
          _buildBasic(),
          SizedBox(height: 20),
          Text('展示类型'),
          _buildType(),
          SizedBox(height: 20),
          Text('头像组合'),
          _buildList(),
        ],
      ),
    );
  }

  Widget _buildList() {
    return Container(
      height: 288.0,
      color: STColor.fourRankGrey,
      padding: EdgeInsets.all(40),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          STAvatar(
            datas: [
              STAvatarData(
                content: '我',
                backgroundColor: STColor.firRankBlue,
                color: Colors.white,
                borderColor: Colors.white,
              ),
              STAvatarData(
                iconData: STIcons.commonly_user,
                backgroundColor: STColor.assistRed,
                color: Colors.white,
                borderColor: Colors.white,
              ),
              STAvatarData(
                iconData: STIcons.commonly_user,
                backgroundColor: Color(0xFF49C564),
                color: Colors.white,
                borderColor: Colors.white,
              ),
              STAvatarData(
                iconData: STIcons.commonly_user,
                backgroundColor: STColor.secRankBlue,
                color: Colors.white,
                borderColor: Colors.white,
              ),
            ],
            size: STAvatarSize.second,
          ),
          STAvatar(
            datas: [
              STAvatarData(
                content: '我',
                backgroundColor: STColor.firRankBlue,
                color: Colors.white,
                borderColor: Colors.white,
              ),
              STAvatarData(
                iconData: STIcons.commonly_user,
                backgroundColor: STColor.assistRed,
                color: Colors.white,
                borderColor: Colors.white,
              ),
              STAvatarData(
                iconData: STIcons.commonly_user,
                backgroundColor: Color(0xFF49C564),
                color: Colors.white,
                borderColor: Colors.white,
              ),
              STAvatarData(
                iconData: STIcons.commonly_user,
                backgroundColor: Colors.pink,
                color: Colors.white,
                borderColor: Colors.white,
              ),
              STAvatarData(
                iconData: STIcons.commonly_user_outline,
                backgroundColor: Colors.yellow,
                color: Colors.white,
                borderColor: Colors.white,
              ),
            ],
            size: STAvatarSize.min,
          ),
          STAvatar(
            datas: [
              STAvatarData(
                content: '我',
                backgroundColor: STColor.firRankBlue,
                color: Colors.white,
                borderColor: Colors.white,
              ),
              STAvatarData(
                iconData: STIcons.commonly_user,
                backgroundColor: STColor.assistRed,
                color: Colors.white,
                borderColor: Colors.white,
              ),
              STAvatarData(
                iconData: STIcons.commonly_user,
                backgroundColor: Color(0xFF49C564),
                color: Colors.white,
                borderColor: Colors.white,
              ),
              STAvatarData(
                iconData: STIcons.commonly_user,
                backgroundColor: Colors.pink,
                color: Colors.white,
                borderColor: Colors.white,
              ),
              STAvatarData(
                iconData: STIcons.commonly_user,
                backgroundColor: Colors.yellow,
                color: Colors.white,
                borderColor: Colors.white,
              ),
              STAvatarData(
                iconData: STIcons.commonly_user,
                backgroundColor: Colors.purple,
                color: Colors.white,
                borderColor: Colors.white,
              ),
            ],
            size: STAvatarSize.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildType() {
    return Container(
      height: 144.0,
      padding: EdgeInsets.all(40),
      color: STColor.fourRankGrey,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        scrollBehavior: STCustomScrollBehavior(),
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              children: [
                STAvatar(
                  datas: [
                    STAvatarData(
                      iconData: STIcons.commonly_user,
                      backgroundColor: STColor.thrRankGrey,
                      color: Colors.white,
                    ),
                  ],
                  size: STAvatarSize.max,
                ),
                SizedBox(width: 52),
                STAvatar(
                  datas: [
                    STAvatarData(
                      iconData: STIcons.commonly_user,
                      backgroundColor: STColor.firRankBlue,
                      color: Colors.white,
                    ),
                  ],
                  size: STAvatarSize.max,
                ),
                SizedBox(width: 52),
                STAvatar(
                  datas: [
                    STAvatarData(
                      content: '用户名',
                      color: Colors.black,
                      backgroundColor: STColor.thrRankGrey,
                    ),
                  ],
                  size: STAvatarSize.max,
                ),
                SizedBox(width: 52),
                STAvatar(
                  datas: [
                    STAvatarData(
                      content: '用户名',
                      color: Colors.white,
                      backgroundColor: STColor.firRankBlue,
                    ),
                  ],
                  size: STAvatarSize.max,
                ),
                SizedBox(width: 52),
                STAvatar(
                  datas: [
                    STAvatarData(
                      image: AssetImage(
                        assetsNameShark,
                      ),
                    ),
                  ],
                  size: STAvatarSize.max,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasic() {
    return Container(
      height: 288.0,
      color: STColor.fourRankGrey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                STAvatar(
                  datas: [
                    STAvatarData(
                      iconData: STIcons.commonly_user,
                      backgroundColor: STColor.thrRankGrey,
                      color: Colors.white,
                    ),
                  ],
                  size: STAvatarSize.max,
                ),
                Spacer(),
                STAvatar(
                  datas: [
                    STAvatarData(
                      iconData: STIcons.commonly_user,
                      backgroundColor: STColor.thrRankGrey,
                      color: Colors.white,
                    ),
                  ],
                  size: STAvatarSize.secondary,
                ),
                Spacer(),
                STAvatar(
                  datas: [
                    STAvatarData(
                      iconData: STIcons.commonly_user,
                      backgroundColor: STColor.thrRankGrey,
                      color: Colors.white,
                    ),
                  ],
                  size: STAvatarSize.second,
                ),
                Spacer(),
                STAvatar(
                  datas: [
                    STAvatarData(
                      iconData: STIcons.commonly_user,
                      backgroundColor: STColor.thrRankGrey,
                      color: Colors.white,
                    ),
                  ],
                  size: STAvatarSize.min,
                ),
                Spacer(),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                STAvatar(
                  datas: [
                    STAvatarData(
                      iconData: STIcons.commonly_user,
                      backgroundColor: STColor.thrRankGrey,
                      color: Colors.white,
                    ),
                  ],
                  size: STAvatarSize.max,
                  clip: STAvatarClip.rect,
                ),
                Spacer(),
                STAvatar(
                  datas: [
                    STAvatarData(
                      iconData: STIcons.commonly_user,
                      backgroundColor: STColor.thrRankGrey,
                      color: Colors.white,
                    ),
                  ],
                  size: STAvatarSize.secondary,
                  clip: STAvatarClip.rect,
                ),
                Spacer(),
                STAvatar(
                  datas: [
                    STAvatarData(
                      iconData: STIcons.commonly_user,
                      backgroundColor: STColor.thrRankGrey,
                      color: Colors.white,
                    ),
                  ],
                  size: STAvatarSize.second,
                  clip: STAvatarClip.rect,
                ),
                Spacer(),
                STAvatar(
                  datas: [
                    STAvatarData(
                      iconData: STIcons.commonly_user,
                      backgroundColor: STColor.thrRankGrey,
                      color: Colors.white,
                    ),
                  ],
                  size: STAvatarSize.min,
                  clip: STAvatarClip.rect,
                ),
                Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
