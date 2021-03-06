import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/widgets.dart';
import 'business/shelf.dart';
import 'base/base.dart';
import 'business/read/read_page.dart';
import 'business/import/import_page.dart';
import 'business/rank/rank_page.dart';
import 'business/search/search_page.dart';

void initData() {
  ConfigManager();
}

void main() {
  initData();
  return runApp(MultiProvider(
    providers: [
      ListenableProvider<BookShelfManager>.value(value: BookShelfManager()),
      ListenableProvider<ThemeManager>.value(value: ThemeManager()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        title: '咕噜小说',
        home: HomePage(),
        theme: CupertinoThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: CupertinoColors.lightBackgroundGray),
        // routes: <String, WidgetBuilder>{
        //   "/reading": (context) => CupertinoPageRoute(
        //       builder: (_) =>
        //           ReadingPage(ModalRoute.of(context).settings.arguments)),
        //   "/import": (context) => ImportPage(),
        //   "/search": (context) =>
        //       SearchPage(ModalRoute.of(context).settings.arguments)
        // },
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case "/reading":
              builder = (_) => ReadingPage(settings.arguments);
              // builder = (_) => CupertinoPageScaffold(
              //       navigationBar: CupertinoNavigationBar(),
              //       child: Container(color: CupertinoColors.white),
              //     );
              break;
            case "/import":
              builder = (context) => ImportPage();
              break;
            case "/search":
              builder = (context) => SearchPage(settings.arguments);
          }
          return CupertinoPageRoute(builder: builder, settings: settings);
        });
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('res/shelf.png')),
              title: Text('书架'),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('res/search.png')),
              title: Text('书库'),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('res/mine.png')),
              title: Text('我的'),
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              switch (index) {
                case 0:
                  return ShelfPage();
                case 1:
                  return RankPage();
                default:
                  return ShelfPage();
              }
            },
          );
        });
  }
}
