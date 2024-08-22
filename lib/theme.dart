import 'package:fluent_ui/fluent_ui.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import '../theme_notifier.dart';

final FluentThemeData lightTheme = FluentThemeData(
  brightness: Brightness.light,
  accentColor: Colors.yellow,
);

final FluentThemeData darkTheme = FluentThemeData(
  brightness: Brightness.dark,
  accentColor: Colors.yellow,
);

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