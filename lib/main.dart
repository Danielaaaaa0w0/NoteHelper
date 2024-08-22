// ignore_for_file: sized_box_for_whitespace

import 'package:fluent_ui/fluent_ui.dart';
import 'page/home_page.dart';
import 'page/files_page.dart';
import 'page/settings_page.dart';
import 'class/note.dart'; // Import the Note class
import 'package:appflowy_editor/appflowy_editor.dart';
import 'theme.dart';
import 'theme_notifier.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return FluentApp(
          title: 'NoteHelper',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeNotifier.themeMode,
          home: const MainPage(),
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentPage = 0;
  List<Note> notes = []; // Use Note objects for notes
  List<String> openTabs = []; // Track open tabs by note IDs

  void _addNote() async {
    String? noteTitle = await _showAddNoteDialog();
    if (noteTitle != null && noteTitle.isNotEmpty) {
      final newNote = Note(
        id: DateTime.now().toString(), // Unique ID for the note
        title: noteTitle,
        editorState: EditorState.blank(withInitialText: true),
      );
      setState(() {
        notes.add(newNote);
        openTabs.add(newNote.id);
        _currentPage = 0;
      });
    }
  }

  Future<String?> _showAddNoteDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String noteTitle = '';
        return Center(
          child: Container(
            height: 200, // Set dialog height
            child: ContentDialog(
              title: const Text('Enter Note Title'),
              content: TextBox(
                onChanged: (value) => noteTitle = value,
                placeholder: 'Note Title',
                maxLines: 1, // Single line text box
                maxLength: 20,
              ),
              actions: [
                Button(
                  child: const Text('Create'),
                  onPressed: () {
                    Navigator.pop(context, noteTitle);
                  },
                ),
                Button(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _removeNoteFromList(String id) {
    setState(() {
      notes.removeWhere((note) => note.id == id);
      openTabs.remove(id);
    });
  }

  void _selectNoteInFiles(String id) {
    if (!openTabs.contains(id)) {
      setState(() {
        openTabs.add(id);
      });
    }
    setState(() {
      _currentPage = 0;
    });
  }

  void _closeTab(String id) {
    setState(() {
      openTabs.remove(id);
    });
  }

  @override
  Widget build(BuildContext context) => NavigationView(
    appBar: NavigationAppBar(
      title: Container(
        margin: const EdgeInsets.only(left: 20),
        child: const Text('NoteHelper', style: TextStyle(fontSize: 24, color: Colors.white), textAlign: TextAlign.center),
      ),
      backgroundColor: const Color.fromARGB(255, 244, 217, 39),
      automaticallyImplyLeading: false,
    ),
    pane: NavigationPane(
      size: const NavigationPaneSize(
        openMinWidth: 250,
        openMaxWidth: 320,
      ),
      items: <NavigationPaneItem>[
        PaneItem(
          icon: const Icon(FluentIcons.home, size: 20),
          title: const Text('Home'),
          body: HomePage(
            notes: notes,
            openTabs: openTabs,
            onNoteClose: _closeTab,
          ),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.fabric_folder, size: 20),
          title: const Text('Files'),
          body: FilesPage(
            notes: notes,
            noteTitles: notes.map((note) => note.title).toList(), // Map note titles
            onNoteSelected: _selectNoteInFiles,
            onNoteDeleted: _removeNoteFromList,
          ),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.settings, size: 20),
          title: const Text('Settings'),
          body: const SettingsPage(),
        ),
      ],
      footerItems: <NavigationPaneItem>[
        PaneItemSeparator(),
        PaneItem(
          icon: const Icon(FluentIcons.add),
          title: const Text('Add Note'),
          body: Container(),
          onTap: _addNote,
        ),
        PaneItem(
          icon: const Icon(FluentIcons.brightness),
          onTap: () {
            ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
            if (themeNotifier.themeMode == ThemeMode.light) {
              themeNotifier.setTheme(ThemeMode.dark);
            } else {
              themeNotifier.setTheme(ThemeMode.light);
            }
          },
          body: Container(),
        ),
      ],
      selected: _currentPage,
      onChanged: (index) => setState(() => _currentPage = index),
    ),
  );
}
