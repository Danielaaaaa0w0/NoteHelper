import 'package:fluent_ui/fluent_ui.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import '../note.dart'; // Import the Note class
import '../theme.dart';

class HomePage extends StatefulWidget {
  final List<Note> notes;
  final List<String> openTabs;
  final Function(String) onNoteClose;

  const HomePage({
    super.key,
    required this.notes,
    required this.openTabs,
    required this.onNoteClose,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

// 利用 HomePage 顯示多個 AppFlowyEditor，_HomePageState 會根據 notes 和 openTabs 來建立 TabView
class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.notes.isEmpty) {
      return const ScaffoldPage(
        content: Center(
          child: Text('Welcome! Click "Add Note" to create your first note.'),
        ),
      );
    }

    return ScaffoldPage(
      content: TabView(
        currentIndex: selectedIndex,
        onChanged: (index) => setState(() => selectedIndex = index),
        tabs: widget.notes.where((note) => widget.openTabs.contains(note.id)).map((note) {
          // final index = widget.notes.indexOf(note);
          return Tab(
            text: Text(note.title),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppFlowyEditor(
                editorState: note.editorState,
                editorStyle: isDarkTheme(context) ? customizeEditorStyle() : const EditorStyle.desktop(),
              ),
            ),
            closeIcon: const Icon(FluentIcons.chrome_close),
            onClosed: () {
              widget.onNoteClose(note.id);
              setState(() {
                widget.openTabs.remove(note.id);
                if (selectedIndex > 0 && selectedIndex >= widget.openTabs.length) {
                  selectedIndex = widget.openTabs.length - 1;
                }
              });
            },
          );
        }).toList(),
        showScrollButtons: true,
        onNewPressed: null,
      ),
    );
  }
}
