import 'package:fluent_ui/fluent_ui.dart';
import '../class/note.dart'; // Import the Note class

class FilesPage extends StatelessWidget {
  final List<Note> notes;
  final List<String> noteTitles; // Note titles might be redundant if you use Note objects
  final Function(String) onNoteSelected;
  final Function(String) onNoteDeleted;

  const FilesPage({
    super.key,
    required this.notes,
    required this.noteTitles,
    required this.onNoteSelected,
    required this.onNoteDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: Text(note.title, style: const TextStyle(fontSize: 16)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Button(
                child: const Text('Open'),
                onPressed: () => onNoteSelected(note.id),
              ),
              const SizedBox(width: 8),
              Button(
                child: const Text('Delete'),
                onPressed: () => onNoteDeleted(note.id),
              ),
            ],
          ),
        );
      },
    );
  }
}
