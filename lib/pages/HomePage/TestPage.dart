import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              //headerSilverBuilder only accepts slivers
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('My Top Widget'),
                  ),
                  TabBar(
                    tabs: [
                      Tab(child: Text('Available')),
                      Tab(child: Text('Taken')),
                    ],
                  ),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              // I wrapped large widgets in the SingleChildScrollView
              SingleChildScrollView(
                child: Text('1') /*Very large widget*/,
              ),
              Text('2'),
            ],
          ),
        ),
      ),
    );
  }
}
