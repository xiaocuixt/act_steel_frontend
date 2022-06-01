import 'package:act_steel_frontend/helpers/app_bar_helper.dart';
import 'package:act_steel_frontend/views/memos/create_memo.dart';
import 'package:act_steel_frontend/views/memos/memo_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const BottomNavigationBarItem navItem = BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Act Steel',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Builder(builder: (BuildContext context) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(46),
                child: AppBarHelper(title: "Act Manage System")),
            body: HomePageBody(),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                openDialog();
              },
              isExtended: true,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              icon: Icon(Icons.edit),
              label: Text('New Memo'),
            ),
          );
        }));
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("New memo"),
            content: CreateMemo(),
          ));
}

class HomePageBody extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
        child: MemoList());
  }
}
