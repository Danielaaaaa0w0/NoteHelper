import 'package:fluent_ui/fluent_ui.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/gestures.dart';

class HomePage extends StatefulWidget {
  final List<EditorState> notes;
  final List<int> openTabs;
  final Function(int) onNoteClose;

  const HomePage({
    super.key, 
    required this.notes,
    required this.openTabs,
    required this.onNoteClose,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: TabView(
        currentIndex: selectedIndex,
        onChanged: (index) => setState(() => selectedIndex = index),
        tabs: widget.openTabs.map((index) {
          return Tab(
            text: Text('Note ${index + 1}'),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppFlowyEditor(editorState: widget.notes[index], editorStyle: customizeEditorStyle(),),
            ),
            closeIcon: const Icon(FluentIcons.chrome_close),
            onClosed: () {
              widget.onNoteClose(index); // Close the tab when requested
              setState(() {
                widget.openTabs.remove(index);
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