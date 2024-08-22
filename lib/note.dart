import 'package:appflowy_editor/appflowy_editor.dart';

class Note {
  final String id; // 唯一标识符
  String title;
  EditorState editorState;

  Note({
    required this.id,
    required this.title,
    required this.editorState,
  });
}