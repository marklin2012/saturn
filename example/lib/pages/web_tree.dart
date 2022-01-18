import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

class WebTreePage extends StatefulWidget {
  const WebTreePage({Key key}) : super(key: key);

  @override
  _WebTreePageState createState() => _WebTreePageState();
}

class _WebTreePageState extends State<WebTreePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebTree'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBaisc(),
            SizedBox(height: 10),
            _buildOnCheck(),
            SizedBox(height: 10),
            _buildSearch(),
            SizedBox(height: 10),
            _buildCustomIcon(),
            SizedBox(height: 10),
            _buildCatalogue(),
            SizedBox(height: 10),
            _buildShowLine(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildBaisc() {
    return Container(
      color: STColor.fourRankGrey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('基础用法'),
          STTree(items: [
            STTreeData(title: '一级1', subs: [
              STTreeData(
                title: '二级1-1',
                subs: [
                  STTreeData(title: '三级1-1-1'),
                  STTreeData(title: '三级1-1-2'),
                  STTreeData(title: '三级1-1-3'),
                ],
              ),
              STTreeData(title: '二级1-2', subs: [
                STTreeData(title: '三级1-2-1'),
                STTreeData(title: '三级1-2-2'),
                STTreeData(title: '三级1-2-3'),
              ]),
              STTreeData(title: '二级1-3'),
            ]),
            STTreeData(title: '一级2'),
            STTreeData(title: '一级3'),
          ]),
        ],
      ),
    );
  }

  Widget _buildOnCheck() {
    return Container(
      color: STColor.fourRankGrey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('可选择'),
          STTree(checkable: true, items: [
            STTreeData(title: '一级1', subs: [
              STTreeData(
                title: '二级1-1',
                subs: [
                  STTreeData(title: '三级1-1-1'),
                  STTreeData(title: '三级1-1-2'),
                  STTreeData(title: '三级1-1-3'),
                ],
              ),
              STTreeData(title: '二级1-2', disabled: true, subs: [
                STTreeData(title: '三级1-2-1'),
                STTreeData(title: '三级1-2-2'),
                STTreeData(title: '三级1-2-3'),
              ]),
              STTreeData(title: '二级1-3'),
            ]),
            STTreeData(title: '一级2'),
            STTreeData(title: '一级3'),
          ]),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      color: STColor.fourRankGrey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('可搜索'),
          STTree(isSearh: true, items: [
            STTreeData(title: '一级1', subs: [
              STTreeData(
                title: '二级1-1',
                subs: [
                  STTreeData(title: '三级1-1-1'),
                  STTreeData(title: '三级1-1-2'),
                  STTreeData(title: '三级1-1-3'),
                  STTreeData(title: '三级1-1-4'),
                ],
              ),
              STTreeData(title: '二级1-2', subs: [
                STTreeData(title: '三级1-2-1'),
                STTreeData(title: '三级1-2-2'),
                STTreeData(title: '三级1-2-3'),
              ]),
              STTreeData(title: '二级1-3'),
            ]),
            STTreeData(title: '一级2'),
            STTreeData(title: '一级3'),
          ]),
        ],
      ),
    );
  }

  Widget _buildCustomIcon() {
    return Container(
      color: STColor.fourRankGrey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('自定义图标'),
          STTree(items: [
            STTreeData(title: '一级1', icon: STIcons.commonly_home, subs: [
              STTreeData(
                title: '二级1-1',
                icon: STIcons.commonly_addressbook,
                subs: [
                  STTreeData(
                    title: '三级1-1-1',
                    icon: STIcons.commonly_ashcan,
                  ),
                  STTreeData(
                    title: '三级1-1-2',
                    icon: STIcons.commonly_ashcan,
                  ),
                  STTreeData(
                    title: '三级1-1-3',
                    icon: STIcons.commonly_ashcan,
                  ),
                ],
              ),
              STTreeData(title: '二级1-2', icon: STIcons.commonly_bell, subs: [
                STTreeData(
                  title: '三级1-2-1',
                  icon: STIcons.commonly_ashcan,
                ),
                STTreeData(
                  title: '三级1-2-2',
                  icon: STIcons.commonly_ashcan,
                ),
                STTreeData(
                  title: '三级1-2-3',
                  icon: STIcons.commonly_ashcan,
                ),
              ]),
              STTreeData(
                title: '二级1-3',
                icon: STIcons.commonly_camera,
              ),
            ]),
            STTreeData(
              title: '一级2',
              icon: STIcons.commonly_comment,
            ),
            STTreeData(
              title: '一级3',
              icon: STIcons.commonly_mail,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildCatalogue() {
    return Container(
      color: STColor.fourRankGrey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('目录'),
          STTree(
            items: [
              STTreeData(
                title: '一级文件夹1',
                icon: STIcons.commonly_mail,
                subs: [
                  STTreeData(
                    title: '二级文件夹1-1',
                    icon: STIcons.commonly_form_outline,
                  ),
                  STTreeData(
                    title: '二级文件夹1-2',
                    icon: STIcons.commonly_form_outline,
                  ),
                ],
              ),
              STTreeData(
                title: '一级文件夹2',
                icon: STIcons.commonly_mail,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShowLine() {
    return Container(
      color: STColor.fourRankGrey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('基础用法'),
          STTree(
            showLine: true,
            items: [
              STTreeData(title: '一级1', subs: [
                STTreeData(
                  title: '二级1-1',
                  subs: [
                    STTreeData(title: '三级1-1-1'),
                    STTreeData(title: '三级1-1-2'),
                    STTreeData(title: '三级1-1-3'),
                  ],
                ),
                STTreeData(title: '二级1-2', subs: [
                  STTreeData(title: '三级1-2-1'),
                  STTreeData(title: '三级1-2-2'),
                  STTreeData(title: '三级1-2-3'),
                ]),
                STTreeData(title: '二级1-3'),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
