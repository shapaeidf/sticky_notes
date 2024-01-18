import 'package:flutter/material.dart';
import 'package:sticky_notes/data/Note.dart';
import 'package:sticky_notes/providers.dart';

class NoteEditPage extends StatefulWidget {
  static const routeName = '/edit';

  final int? index; //null값 허용으로 새 노트 생성 시 인덱스 정보를 넘기지 않아도 되도록

  const NoteEditPage(this.index, {super.key});

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  Color color = Note.colorDefault;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final noteIndex = widget.index;
    if (noteIndex != null) {
      final note = noteManager().getNote(noteIndex);
      titleController.text = note.title;
      bodyController.text = note.body;
      color = note.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('노트 편집'),
        actions: [
          IconButton(
            onPressed: _displayColorSelectionDialog,
            icon: const Icon(Icons.color_lens),
            tooltip: '배경색 선택',
          ),
          IconButton(
            onPressed: _saveNote,
            icon: const Icon(Icons.save),
            tooltip: '저장',
          )
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          color: color,
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '제목 입력',
                  ),
                  maxLines: 1,
                  style: const TextStyle(fontSize: 20.0),
                  controller: titleController,
                ),
                const SizedBox(height: 8.0),
                TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '노트 입력',
                  ),
                  maxLines: null,
                  keyboardType:
                      TextInputType.multiline, //본문 입력 할 때 엔터 누르면 다음 줄로 이동
                  controller: bodyController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _displayColorSelectionDialog() {
    FocusManager.instance.primaryFocus
        ?.unfocus(); //다이얼로그 표시 전 소프트키보드가 내려갈 수 있도록

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('배경색 선택'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('없음'),
                onTap: () => _applyColor(Note.colorDefault),
              ),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Note.colorRed),
                title: const Text('빨간색'),
                onTap: () => _applyColor(Note.colorRed),
              ),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Note.colorOrange),
                title: const Text('주황색'),
                onTap: () => _applyColor(Note.colorOrange),
              ),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Note.colorYello),
                title: const Text('노란색'),
                onTap: () => _applyColor(Note.colorYello),
              ),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Note.colorLime),
                title: const Text('라임색'),
                onTap: () => _applyColor(Note.colorLime),
              ),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Note.colorBlue),
                title: const Text('파란색'),
                onTap: () => _applyColor(Note.colorBlue),
              )
            ],
          ),
        );
      },
    );
  }

  void _applyColor(Color newColor) {
    setState(() {
      Navigator.pop(context);
      color = newColor;
    });
  }

  void _saveNote() {
    if (bodyController.text.isNotEmpty) {
      final note = Note(
        bodyController.text,
        title: titleController.text,
        color: color,
      );

      final noteIndex = widget.index;
      if (noteIndex != null) {
        //노트 수정
        noteManager().updateNote(noteIndex, note);
      } else {
        noteManager().addNote(note);
      }

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('노트를 입력하세요.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
