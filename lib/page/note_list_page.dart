import 'package:flutter/material.dart';
import 'package:sticky_notes/data/Note.dart';
import 'package:sticky_notes/page/note_edit_page.dart';
import 'package:sticky_notes/page/note_view_page.dart';
import 'package:sticky_notes/providers.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  static const routeName = '/';

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sticky notes'),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        children: _buildCards(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: '새 노트',
        onPressed: () {
          Navigator.pushNamed(context, NoteEditPage.routeName).then(
            (_) {
              setState(() {});
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> _buildCards() {
    final notes = noteManager().listNotes();
    return List.generate(notes.length,
        (index) => _buildCard(index, notes[index])); //인덱스 정보 같이 받기
  }

  Widget _buildCard(int index, Note note) {
    return InkWell(
      child: Card(
        color: note.color,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title.isEmpty ? '(제목 없음)' : note.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Text(
                  note.body,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          NoteViewPage.routeName,
          arguments: index,
        ).then(
          (_) {
            setState(() {});
          },
        );
      },
    );
  }
}
