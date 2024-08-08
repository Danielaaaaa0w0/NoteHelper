import 'package:fluent_ui/fluent_ui.dart';
import 'package:appflowy_editor/appflowy_editor.dart';

class FilesPage extends StatelessWidget {
  final List<EditorState> notes;
  final Function(int) onNoteSelected;
  final Function(int) onNoteDeleted;

  const FilesPage({
    super.key,
    required this.notes,
    required this.onNoteSelected,
    required this.onNoteDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: Text('Note ${index + 1}', style: const TextStyle(fontSize: 16)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Button(
                child: const Text('Open'),
                onPressed: () => onNoteSelected(index), // 點擊筆記重新打開
              ),
              const SizedBox(width: 8),
              Button(
                child: const Text('Delete'),
                onPressed: () => onNoteDeleted(index), // 刪除筆記
              ),
            ],
          ),
        );
      },
    );
  }
}
