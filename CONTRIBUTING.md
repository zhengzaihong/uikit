## 开发环境

- Flutter >= 3.27.0
- Dart >= 3.6.0

## 提交前检查

```bash
flutter pub get
dart format lib test
dart analyze lib test
flutter test
```

> `flutter analyze` 会把当前既有的 lint info 视为失败；CI 使用 `dart analyze`，error 和 warning 仍会阻断。

## 约定

- 一个 PR 聚焦一个主题，避免混入无关重构。
- 公共 API 变更需要同步更新 `CHANGELOG.md` 和 README。
- 新增组件或修复运行时行为时，请附带最小 widget/unit 测试。
- 保持向后兼容：优先新增推荐命名，旧参数保留为可选或标记 `@Deprecated`。