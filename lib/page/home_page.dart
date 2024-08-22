import 'package:fluent_ui/fluent_ui.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/gestures.dart';
import '../class/note.dart'; // Import the Note class
import '../theme_notifier.dart';
import 'package:provider/provider.dart';

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

// 自訂 AppFlowyEditor 的樣式
EditorStyle customizeEditorStyle() {
  return EditorStyle(
    padding: PlatformExtension.isDesktopOrWeb
        ? const EdgeInsets.only(left: 100, right: 100, top: 20)
        : const EdgeInsets.symmetric(horizontal: 10),
    dragHandleColor: Colors.yellow,
    cursorColor: Colors.yellow,
    selectionColor: Colors.yellow,
    textStyleConfiguration: TextStyleConfiguration(
      text: const TextStyle(
        fontSize: 18.0,
        color: Colors.white,
      ),
      bold: const TextStyle(
        fontWeight: FontWeight.w900,
      ),
      href: TextStyle(
        color: Colors.yellow,
        decoration: TextDecoration.combine(
          [
            TextDecoration.overline,
            TextDecoration.underline,
          ],
        ),
      ),
      code: const TextStyle(
        fontSize: 14.0,
        fontStyle: FontStyle.italic,
        color: Colors.white,
        backgroundColor: Colors.black,
      ),
    ),
    textSpanDecorator: (context, node, index, text, textSpan, previousSpan) {
      final attributes = text.attributes;
      final href = attributes?[AppFlowyRichTextKeys.href];
      if (href != null) {
        return TextSpan(
          text: text.text,
          style: textSpan.style,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              debugPrint('onTap: $href');
            },
        );
      }
      return textSpan as InlineSpan;
    },
  );
}

bool isDarkTheme(BuildContext context) {
  ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
  return themeNotifier.themeMode == ThemeMode.dark;
}