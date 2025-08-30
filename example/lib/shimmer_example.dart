import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikit_lib.dart';

class ShimmerLoadingExample extends StatefulWidget {
  const ShimmerLoadingExample({Key? key}) : super(key: key);

  @override
  State<ShimmerLoadingExample> createState() => _ShimmerLoadingExampleState();
}

class _ShimmerLoadingExampleState extends State<ShimmerLoadingExample> {
  bool isLoading = true;
  var currentType = "1";
  List<Map<String, dynamic>> dataList = [
    {
      "title": "垂直列表",
      "type": "1",
    },
    {
      "title": "网格布局",
      "type": "2",
    },
    {
      "title": "自定义占位",
      "type": "3",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shimmer Demo"),
        actions: [
          SelectionMenu(
              popWidth: 200,
              popHeight: 160,
              buttonBuilder: (show) {
                return Container(
                  width: 200,
                  height: 35,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.setAlpha(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text("示例加载"),
                );
              },
              selectorBuilder: (context) {
                return Bubble(
                  radius: 12,
                  arrowWidth: 20,
                  arrowHeight: 12,
                  direction: BubbleArrowDirection.top,
                  arrowShape: BubbleArrowShape.triangle,
                  arrowPositionPercent: 0.3,
                  arrowAdaptive: true,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Colors.blue, Colors.purple]),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12, width: 1),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 2)),
                    ],
                  ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListView.separated(
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          final item = dataList[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                currentType = item["type"];
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              height: 35,
                              width: 300,
                              alignment: Alignment.center,
                              child: Text(
                                item["title"],
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
                    ),
                  );
              }),
          KitSwitch(
              isOpen: isLoading,
              isInnerStyle: true,
              activeColor: Colors.red,
              onChange: (v) {
                setState(() {
                  isLoading = v;
                });
              }),
          hGap(16),
        ],
      ),
      body: currentType == "1"
          ? _buildShimmerList()
          : currentType == "2"
              ? _buildShimmerGrid()
              : currentType == "3"
                  ? _buildShimmerCustomPlaceHolder()
                  : Container(),
    );
  }

  Widget _buildShimmerList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("📄 文本段落示例", style: TextStyle(fontSize: 20)),
        vGap(8),
        AutoShimmerList(
          isLoading: isLoading,
          direction: ShimmerListDirection.vertical,
          children: List.generate(
            20,
            (i) => Text("这是一段示例文本 $i", style: const TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🖼️ 网格布局示例", style: TextStyle(fontSize: 20)),
        vGap(8),
        AutoShimmerList(
          isLoading: isLoading,
          direction: ShimmerListDirection.grid,
          crossAxisCount: 10,
          spacing: 20,
          children: List.generate(
            20,
            (i) => Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text("网格 $i"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerCustomPlaceHolder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("⚙️ 自定义占位示例", style: TextStyle(fontSize: 20)),
        vGap(8),
        Shimmer(
          isLoading: isLoading,
          builder: (context) => Container(
            height: 80,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.network(
                          'https://docs.flutter.dev/cookbook'
                          '/img-files/effects/split-check/Avatar1.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("这是一段标题内容",
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    Text("很长很长的描述内容很长很长的描述内容很长很长的描述内容很长很长的描述内容很长很长的描述内容",
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                  ],
                )
              ],
            ),
          ),
          placeholderBuilder: (context) => Container(
            height: 80,
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 240,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: 350,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
