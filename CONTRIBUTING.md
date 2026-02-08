# Contributing to Kids Portfolio

Thank you for your interest in contributing to the Kids Portfolio app!

## Development Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/northernWilder/kids_portfolio.git
   cd kids_portfolio
   ```

2. **Install Flutter**
   - Follow [Flutter installation guide](https://flutter.dev/docs/get-started/install)
   - Verify: `flutter doctor`

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Setup Firebase**
   - See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for detailed instructions
   - Update Firebase configuration in `lib/main.dart`

5. **Run the app**
   ```bash
   flutter run -d chrome
   ```

## Project Structure

```
lib/
├── main.dart                     # App entry point
├── models/                       # Data models
├── screens/                      # App screens
├── widgets/                      # Reusable UI components
└── services/                     # Business logic and API calls
```

## Code Style

### Flutter/Dart Guidelines

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `const` constructors where possible
- Prefer composition over inheritance
- Keep widgets small and focused
- Use descriptive names

### Formatting

```bash
# Format code
dart format .

# Analyze code
flutter analyze
```

### Naming Conventions

- **Classes**: PascalCase (`MediaItem`, `HomeScreen`)
- **Variables**: camelCase (`artistName`, `selectedCategory`)
- **Constants**: lowerCamelCase with `k` prefix (`kPrimaryColor`)
- **Private**: prefix with underscore (`_buildPreview`)

## Making Changes

### Branch Naming

- Feature: `feature/description`
- Bug fix: `fix/description`
- Documentation: `docs/description`

Example: `feature/add-audio-player`

### Commit Messages

Follow conventional commits:

```
type(scope): description

[optional body]
[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting, no code change
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance

Examples:
```
feat(player): add audio player for stories
fix(grid): correct responsive layout on mobile
docs(readme): update setup instructions
```

### Pull Request Process

1. Create a feature branch
2. Make your changes
3. Write/update tests if applicable
4. Update documentation
5. Run tests and linting:
   ```bash
   flutter analyze
   flutter test
   ```
6. Commit your changes
7. Push to your fork
8. Create a Pull Request

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Code refactoring

## Testing
- [ ] Tested locally
- [ ] Added/updated tests
- [ ] Tested on mobile
- [ ] Tested on desktop

## Screenshots (if applicable)
Add screenshots here

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-reviewed code
- [ ] Commented complex code
- [ ] Updated documentation
- [ ] No new warnings
```

## Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test
flutter test test/models/media_item_test.dart

# Run with coverage
flutter test --coverage
```

### Writing Tests

Example test structure:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:kids_portfolio/models/media_item.dart';

void main() {
  group('MediaItem', () {
    test('creates instance from valid data', () {
      final item = MediaItem(
        id: '1',
        artistName: 'Joanna Ooms',
        title: 'Test',
        description: 'Test description',
        category: MediaCategory.stories,
        timestamp: DateTime.now(),
      );
      
      expect(item.artistName, 'Joanna Ooms');
      expect(item.category, MediaCategory.stories);
    });
  });
}
```

## Firebase Development

### Local Emulators

Use Firebase emulators for development:

```bash
# Install emulators
firebase init emulators

# Start emulators
firebase emulators:start
```

Update `main.dart` to use emulators:

```dart
if (kDebugMode) {
  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
}
```

### Security Rules Testing

Test security rules:

```bash
firebase emulators:exec --only firestore "npm test"
```

## Adding Features

### New Media Category

1. Add to `MediaCategory` enum in `lib/models/media_item.dart`
2. Update category icon in `lib/widgets/media_category_tabs.dart`
3. Update category icon in `lib/widgets/media_card.dart`
4. Update Firestore indexes in `firestore.indexes.json`
5. Test with sample data

### New Artist

Artists are data-driven. Just add documents with new `artistName` to Firestore.

To add UI customization per artist:
1. Update `lib/screens/home_screen.dart` with new artist card
2. Consider adding artist-specific colors/themes

## Debugging

### Common Issues

**Firebase not initialized**
- Check Firebase configuration
- Ensure `Firebase.initializeApp()` is called

**CORS errors**
- Check Firebase Storage rules
- Ensure files are publicly accessible

**Layout issues**
- Test on different screen sizes
- Use `flutter run -d chrome --web-browser-flag "--disable-web-security"`

### Debug Tools

```bash
# Enable verbose logging
flutter run -v

# Flutter DevTools
flutter pub global activate devtools
flutter pub global run devtools
```

## Performance Optimization

### Tips

- Use `const` constructors
- Implement `ListView.builder` for long lists
- Optimize images (WebP format)
- Lazy load content
- Cache network images

### Profiling

```bash
flutter run --profile
# Then use DevTools to analyze performance
```

## Documentation

### Code Comments

- Document public APIs
- Explain complex logic
- Add TODOs with issue references

Example:
```dart
/// Fetches media items for a specific artist.
///
/// Returns a [Stream] of [QuerySnapshot] that updates whenever
/// the media collection changes.
///
/// Parameters:
///   - [artistName]: The name of the artist to filter by
///   - [category]: Optional category filter
Stream<QuerySnapshot> _getMediaStream() {
  // Implementation
}
```

### Documentation Updates

When making changes, update:
- README.md - for user-facing changes
- FIREBASE_SETUP.md - for Firebase configuration
- SAMPLE_DATA.md - for data structure changes
- Code comments - for implementation details

## Getting Help

- Open an issue for bugs or feature requests
- Check existing issues before creating new ones
- Provide detailed information:
  - Flutter version (`flutter --version`)
  - Browser/device
  - Steps to reproduce
  - Expected vs actual behavior
  - Screenshots if applicable

## Code Review

When reviewing PRs:
- Check code quality and style
- Verify functionality
- Test on multiple devices
- Review security implications
- Check documentation updates
- Ensure no sensitive data exposed

## Release Process

1. Update version in `pubspec.yaml`
2. Update CHANGELOG.md
3. Create release branch
4. Test thoroughly
5. Merge to main
6. Tag release: `git tag v1.0.0`
7. Push tag: `git push origin v1.0.0`
8. Deploy to production

## License

This is a private family portfolio project. All rights reserved.

## Questions?

Open an issue or contact the repository maintainer.

---

Thank you for contributing! 🎨
