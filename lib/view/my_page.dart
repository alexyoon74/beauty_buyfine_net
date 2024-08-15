import 'package:beauty_buyfine_net/components/sliver_appbar_func.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  MyPage({super.key});
  final SliverAppbarFunc sliverAppbarFunc = SliverAppbarFunc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sliverAppbarFunc.topMenu(context: context),
      body: CustomScrollView(
        slivers: [
          sliverAppbarFunc.listSliverAppbar(
            context: context,
            pageType: 'my',
            title: '找',
            lottieFileName: 'me2.json',
            isNeedBottomAppbar: false,
          ),
          SliverList.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                    width: double.infinity,
                    height: 200,
                    color: Colors.pink[100],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
