import 'package:sticky_notes/data/Note.dart';

class NoteManager {
  final List<Note> _notes = [];

  //노트 추가
  void addNote(Note note) {
    _notes.add(note);
  }

  //노트 삭제
  void deleteNote(int index) {
    _notes.removeAt(index);
  }

  //노트 정보 반환
  Note getNote(int index) {
    return _notes[index];
  }

  //모든 노트 반환
  List<Note> listNotes() {
    return _notes;
  }

  //노트 업데이트
  void updateNote(int index, Note note) {
    _notes[index] = note;
  }
}
