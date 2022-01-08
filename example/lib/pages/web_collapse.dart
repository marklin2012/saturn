import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

class WebCollapsePage extends StatefulWidget {
  const WebCollapsePage({Key key}) : super(key: key);

  @override
  _WebCollapsePageState createState() => _WebCollapsePageState();
}

class _WebCollapsePageState extends State<WebCollapsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('WebCollapse'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('基础用法'),
              _buildBasic(),
              SizedBox(height: 20),
              Text('手风琴'),
              _buildAccordion(),
              SizedBox(height: 20),
              Text('嵌套'),
              _buildNesting(),
              SizedBox(height: 20),
              Text('幽灵'),
              _buildGhost(),
              SizedBox(height: 20),
              Text('简洁'),
              _buildSimple(),
              SizedBox(height: 20),
              Text('禁用'),
              _buildDisable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasic() {
    return Container(
      color: STColor.fourRankGrey,
      padding: EdgeInsets.all(40.0),
      child: STCollapse(
        items: [
          STCollapseData(
              header: '杜甫',
              content:
                  '杜甫的思想核心是儒家的仁政思想，他有“致君尧舜上，再使风俗淳”的宏伟抱负。杜甫虽然在世时名声并不显赫，但后来声名远播，对中国文学和日本文学都产生了深远的影响。杜甫共有约1500首诗歌被保留了下来，大多集于《杜工部集》。'),
          STCollapseData(
              header: '李清照',
              content:
                  '李清照出生于书香门第，早期生活优裕，其父李格非藏书甚富，她小时候就在良好的家庭环境中打下文学基础。出嫁后与夫赵明诚共同致力于书画金石的搜集整理。金兵入据中原时，流寓南方，境遇孤苦。所作词，前期多写其悠闲生活，后期多悲叹身世，情调感伤。形式上善用白描手法，自辟途径，语言清丽。'),
          STCollapseData(
              header: '鲁迅',
              content:
                  '鲁迅一生在文学创作、文学批评、思想研究、文学史研究、翻译、美术理论引进、基础科学介绍和古籍校勘与研究等多个领域具有重大贡献。他对于五四运动以后的中国社会思想文化发展具有重大影响，蜚声世界文坛，尤其在韩国、日本思想文化领域有极其重要的地位和影响，被誉为“二十世纪东亚文化地图上占最大领土的作家”。'),
        ],
      ),
    );
  }

  Widget _buildAccordion() {
    return Container(
      color: STColor.fourRankGrey,
      padding: EdgeInsets.all(40.0),
      child: STCollapse(
        type: STCollapseType.accordion,
        items: [
          STCollapseData(
              header: '杜甫',
              content:
                  '杜甫的思想核心是儒家的仁政思想，他有“致君尧舜上，再使风俗淳”的宏伟抱负。杜甫虽然在世时名声并不显赫，但后来声名远播，对中国文学和日本文学都产生了深远的影响。杜甫共有约1500首诗歌被保留了下来，大多集于《杜工部集》。'),
          STCollapseData(
              header: '李清照',
              content:
                  '李清照出生于书香门第，早期生活优裕，其父李格非藏书甚富，她小时候就在良好的家庭环境中打下文学基础。出嫁后与夫赵明诚共同致力于书画金石的搜集整理。金兵入据中原时，流寓南方，境遇孤苦。所作词，前期多写其悠闲生活，后期多悲叹身世，情调感伤。形式上善用白描手法，自辟途径，语言清丽。'),
          STCollapseData(
              header: '鲁迅',
              content:
                  '鲁迅一生在文学创作、文学批评、思想研究、文学史研究、翻译、美术理论引进、基础科学介绍和古籍校勘与研究等多个领域具有重大贡献。他对于五四运动以后的中国社会思想文化发展具有重大影响，蜚声世界文坛，尤其在韩国、日本思想文化领域有极其重要的地位和影响，被誉为“二十世纪东亚文化地图上占最大领土的作家”。'),
        ],
      ),
    );
  }

  Widget _buildNesting() {
    return Container(
      color: STColor.fourRankGrey,
      padding: EdgeInsets.all(40.0),
      child: STCollapse(
        items: [
          STCollapseData(
            header: '杜甫',
            datas: [
              STCollapseData(
                  header: '杜甫',
                  content:
                      '杜甫的思想核心是儒家的仁政思想，他有“致君尧舜上，再使风俗淳”的宏伟抱负。杜甫虽然在世时名声并不显赫，但后来声名远播，对中国文学和日本文学都产生了深远的影响。杜甫共有约1500首诗歌被保留了下来，大多集于《杜工部集》。'),
              STCollapseData(
                  header: '李清照',
                  content:
                      '李清照出生于书香门第，早期生活优裕，其父李格非藏书甚富，她小时候就在良好的家庭环境中打下文学基础。出嫁后与夫赵明诚共同致力于书画金石的搜集整理。金兵入据中原时，流寓南方，境遇孤苦。所作词，前期多写其悠闲生活，后期多悲叹身世，情调感伤。形式上善用白描手法，自辟途径，语言清丽。'),
            ],
          ),
          STCollapseData(
              header: '李清照',
              content:
                  '李清照出生于书香门第，早期生活优裕，其父李格非藏书甚富，她小时候就在良好的家庭环境中打下文学基础。出嫁后与夫赵明诚共同致力于书画金石的搜集整理。金兵入据中原时，流寓南方，境遇孤苦。所作词，前期多写其悠闲生活，后期多悲叹身世，情调感伤。形式上善用白描手法，自辟途径，语言清丽。'),
          STCollapseData(
              header: '鲁迅',
              content:
                  '鲁迅一生在文学创作、文学批评、思想研究、文学史研究、翻译、美术理论引进、基础科学介绍和古籍校勘与研究等多个领域具有重大贡献。他对于五四运动以后的中国社会思想文化发展具有重大影响，蜚声世界文坛，尤其在韩国、日本思想文化领域有极其重要的地位和影响，被誉为“二十世纪东亚文化地图上占最大领土的作家”。'),
        ],
      ),
    );
  }

  Widget _buildGhost() {
    return Container(
      color: STColor.fourRankGrey,
      padding: EdgeInsets.all(40.0),
      child: STCollapse(
        type: STCollapseType.ghost,
        items: [
          STCollapseData(
              header: '杜甫',
              content:
                  '杜甫的思想核心是儒家的仁政思想，他有“致君尧舜上，再使风俗淳”的宏伟抱负。杜甫虽然在世时名声并不显赫，但后来声名远播，对中国文学和日本文学都产生了深远的影响。杜甫共有约1500首诗歌被保留了下来，大多集于《杜工部集》。'),
          STCollapseData(
              header: '李清照',
              content:
                  '李清照出生于书香门第，早期生活优裕，其父李格非藏书甚富，她小时候就在良好的家庭环境中打下文学基础。出嫁后与夫赵明诚共同致力于书画金石的搜集整理。金兵入据中原时，流寓南方，境遇孤苦。所作词，前期多写其悠闲生活，后期多悲叹身世，情调感伤。形式上善用白描手法，自辟途径，语言清丽。'),
          STCollapseData(
              header: '鲁迅',
              content:
                  '鲁迅一生在文学创作、文学批评、思想研究、文学史研究、翻译、美术理论引进、基础科学介绍和古籍校勘与研究等多个领域具有重大贡献。他对于五四运动以后的中国社会思想文化发展具有重大影响，蜚声世界文坛，尤其在韩国、日本思想文化领域有极其重要的地位和影响，被誉为“二十世纪东亚文化地图上占最大领土的作家”。'),
        ],
      ),
    );
  }

  Widget _buildSimple() {
    return Container(
      color: STColor.fourRankGrey,
      padding: EdgeInsets.all(40.0),
      child: STCollapse(
        type: STCollapseType.simple,
        items: [
          STCollapseData(
              header: '杜甫',
              content:
                  '杜甫的思想核心是儒家的仁政思想，他有“致君尧舜上，再使风俗淳”的宏伟抱负。杜甫虽然在世时名声并不显赫，但后来声名远播，对中国文学和日本文学都产生了深远的影响。杜甫共有约1500首诗歌被保留了下来，大多集于《杜工部集》。'),
          STCollapseData(
              header: '李清照',
              content:
                  '李清照出生于书香门第，早期生活优裕，其父李格非藏书甚富，她小时候就在良好的家庭环境中打下文学基础。出嫁后与夫赵明诚共同致力于书画金石的搜集整理。金兵入据中原时，流寓南方，境遇孤苦。所作词，前期多写其悠闲生活，后期多悲叹身世，情调感伤。形式上善用白描手法，自辟途径，语言清丽。'),
          STCollapseData(
              header: '鲁迅',
              content:
                  '鲁迅一生在文学创作、文学批评、思想研究、文学史研究、翻译、美术理论引进、基础科学介绍和古籍校勘与研究等多个领域具有重大贡献。他对于五四运动以后的中国社会思想文化发展具有重大影响，蜚声世界文坛，尤其在韩国、日本思想文化领域有极其重要的地位和影响，被誉为“二十世纪东亚文化地图上占最大领土的作家”。'),
        ],
      ),
    );
  }

  Widget _buildDisable() {
    return Container(
      color: STColor.fourRankGrey,
      padding: EdgeInsets.all(40.0),
      child: STCollapse(
        items: [
          STCollapseData(
              header: '杜甫',
              content:
                  '杜甫的思想核心是儒家的仁政思想，他有“致君尧舜上，再使风俗淳”的宏伟抱负。杜甫虽然在世时名声并不显赫，但后来声名远播，对中国文学和日本文学都产生了深远的影响。杜甫共有约1500首诗歌被保留了下来，大多集于《杜工部集》。'),
          STCollapseData(
              disabled: true,
              header: '李清照',
              content:
                  '李清照出生于书香门第，早期生活优裕，其父李格非藏书甚富，她小时候就在良好的家庭环境中打下文学基础。出嫁后与夫赵明诚共同致力于书画金石的搜集整理。金兵入据中原时，流寓南方，境遇孤苦。所作词，前期多写其悠闲生活，后期多悲叹身世，情调感伤。形式上善用白描手法，自辟途径，语言清丽。'),
          STCollapseData(
              disabled: true,
              header: '鲁迅',
              content:
                  '鲁迅一生在文学创作、文学批评、思想研究、文学史研究、翻译、美术理论引进、基础科学介绍和古籍校勘与研究等多个领域具有重大贡献。他对于五四运动以后的中国社会思想文化发展具有重大影响，蜚声世界文坛，尤其在韩国、日本思想文化领域有极其重要的地位和影响，被誉为“二十世纪东亚文化地图上占最大领土的作家”。'),
        ],
      ),
    );
  }
}
