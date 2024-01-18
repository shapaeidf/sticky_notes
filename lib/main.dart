import 'package:flutter/material.dart';
import 'package:sticky_notes/page/note_edit_page.dart';
import 'package:sticky_notes/page/note_list_page.dart';
import 'package:sticky_notes/page/note_view_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      // initialRoute: NoteListPage.routeName, //첫 페이지 (home과 함께 사용 불가.)
      // routes: {
      //   NoteListPage.routeName: (context) => const NoteListPage(),
      //   NoteEditPage.routeName: (context) => const NoteEditPage(),
      //   NoteViewPage.routeName: (context) {
      //     //인덱스 정보를 함께 넘겨주어야 함. 호출할 때 받은 arguments 인자로부터 받을 수 있음.
      //     final index =
      //         ModalRoute.of(context)!.settings.arguments as int; //int 타입으로
      //     return NoteViewPage(index);
      //   },
      // },
      initialRoute: NoteListPage.routeName,
      routes: {
        NoteListPage.routeName: (context) => const NoteListPage(),
        NoteEditPage.routeName: (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          final index =
              args != null ? args as int : null; //인덱스를 추출할지, null값으로 둘지.
          return NoteEditPage(index);
        },
        NoteViewPage.routeName: (context) {
          final index = ModalRoute.of(context)!.settings.arguments as int;
          return NoteViewPage(index);
        }
      },
    );
  }
}
