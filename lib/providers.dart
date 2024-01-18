//노트 매니저 저장공간

import 'package:sticky_notes/data/note_manager.dart';

NoteManager? _noteManager;

NoteManager noteManager() {
  //if (_noteManager == null) {
  //  _noteManager = NoteManager();
  //}
  _noteManager ??= NoteManager();

  return _noteManager!;
}
