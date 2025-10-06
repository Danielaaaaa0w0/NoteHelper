# NoteHelper 📝

一個基於Flutter開發的現代化筆記管理應用程式，使用Fluent UI設計語言，提供類似Windows原生應用的用戶體驗。

![avatar](https://i.postimg.cc/V6FKGPNk/image.webp)

## 🎯 專案簡介

NoteHelper是一個學生練習專案，旨在創建一個功能完整且用戶友好的筆記管理工具。該應用程式整合了AppFlowy編輯器，提供豐富的文字編輯功能，並採用Fluent UI框架實現現代化的Windows風格界面。

## ✨ 主要功能

### 📝 筆記管理
- **創建筆記**: 快速創建新的筆記，支援自定義標題
- **編輯筆記**: 使用AppFlowy編輯器進行豐富的文字編輯
- **多標籤頁**: 支援同時開啟多個筆記，類似瀏覽器標籤頁體驗
- **檔案管理**: 在Files頁面中查看、開啟和刪除所有筆記

### 🎨 用戶界面
- **Fluent UI設計**: 採用微軟Fluent Design設計語言
- **深色/淺色主題**: 支援主題切換，提供舒適的閱讀體驗
- **響應式布局**: 適配不同螢幕尺寸
- **直觀導航**: 清晰的側邊欄導航結構

### 🏗️ 技術特色
- **Flutter框架**: 跨平台開發，支援Windows、Web等多個平台
- **AppFlowy編輯器**: 強大的富文字編輯功能
- **Provider狀態管理**: 使用Provider進行主題狀態管理
- **模組化設計**: 清晰的代碼結構，易於維護和擴展

## 🚀 如何運行

### 環境要求
- Flutter SDK 3.4.4 或更高版本
- Windows 10/11 (桌面版本)
- Chrome瀏覽器 (Web版本)

### 安裝步驟
1. 克隆專案到本地
2. 安裝依賴套件：
   ```bash
   flutter pub get
   ```
3. 運行應用程式：
   ```bash
   # Windows桌面版本
   flutter run -d windows
   
   # Web版本
   flutter run -d chrome
   ```

## 📁 專案結構

```
lib/
├── main.dart              # 應用程式入口點
├── note.dart              # 筆記數據模型
├── theme.dart             # 主題配置
├── theme_notifier.dart    # 主題狀態管理
└── page/
    ├── home_page.dart     # 主頁面（筆記編輯）
    ├── files_page.dart    # 檔案管理頁面
    └── settings_page.dart # 設定頁面
```

## 🔮 未來規劃

- **筆記分類**: 將筆記組織到不同類別中，便於檢索
- **全文搜尋**: 基於關鍵字的全文搜尋功能
- **語音轉文字**: 支援語音輸入轉換為文字
- **關鍵字標籤**: 自動為筆記添加關鍵字標籤
- **文字摘要**: 自動整理和摘要文章內容
- **知識圖譜**: 基於內容生成知識圖譜
- **雲端同步**: 支援多設備同步
- **匯出功能**: 支援多種格式匯出（PDF、Markdown等）

## 🛠️ 技術棧

- **前端框架**: Flutter
- **UI框架**: Fluent UI
- **編輯器**: AppFlowy Editor
- **狀態管理**: Provider
- **主題管理**: Adaptive Theme
- **本地儲存**: Shared Preferences

## 📄 授權

此專案僅供學習和練習使用。


