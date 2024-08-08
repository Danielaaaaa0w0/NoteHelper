import 'package:fluent_ui/fluent_ui.dart';
import 'page/home_page.dart';
import 'page/files_page.dart';
import 'page/settings_page.dart';
import 'package:appflowy_editor/appflowy_editor.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'NoteHelper',
      theme: FluentThemeData(
        brightness: Brightness.dark, // 設置為暗黑模式
        accentColor: Colors.yellow, // 設置主題色為藍色
      ),
      home: const MainPage(),
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
  List<EditorState> notes = [EditorState.blank(withInitialText: true)];
  List<int> openTabs = [0]; // Track open tabs by their indices

  void _addNote() {
    setState(() {
      notes.add(EditorState.blank(withInitialText: true));
      openTabs.add(notes.length - 1); // Add the new note to open tabs
      _currentPage = 0;
    });
  }

  void _removeNoteFromList(int index) {
    setState(() {
      notes.removeAt(index);
      openTabs.remove(index);
    });
  }

  void _selectNoteInFiles(int index) {
    if (!openTabs.contains(index)) {
      setState(() {
        openTabs.add(index);
      });
    }
    setState(() {
      _currentPage = 0;
    });
  }

  void _closeTab(int index) {
    setState(() {
      openTabs.remove(index);
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
      ],
      selected: _currentPage,
      onChanged: (index) => setState(() => _currentPage = index),
    ),
  );
}
