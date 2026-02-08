# Kids Portfolio - Creative Showcase

A Flutter web application showcasing the creative work of two talented young artists: **Joanna Ooms** and **Eleanor Ooms**. This portfolio displays their recorded stories, photos of school work, and written assignments.

## Features

- 🎨 Individual portfolio pages for each artist
- 📸 Photo galleries
- 🎙️ Audio story recordings
- ✍️ Written assignments and school work
- 📱 Responsive design (mobile, tablet, desktop)
- ☁️ Firebase backend integration
- 🔥 Firebase Hosting deployment

## Technology Stack

- **Frontend**: Flutter Web
- **Backend**: Firebase Firestore
- **Storage**: Firebase Storage
- **Hosting**: Firebase Hosting

## Project Structure

```
kids_portfolio/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── models/
│   │   └── media_item.dart       # Media data model
│   ├── screens/
│   │   ├── home_screen.dart      # Landing page with artist selection
│   │   └── artist_portfolio_screen.dart  # Individual portfolio view
│   ├── widgets/
│   │   ├── artist_card.dart      # Artist selection card
│   │   ├── media_card.dart       # Media item card
│   │   ├── media_grid.dart       # Grid layout for media items
│   │   ├── media_category_tabs.dart  # Category filter tabs
│   │   └── media_detail_dialog.dart  # Media detail view
│   └── services/
├── web/
│   ├── index.html               # Web entry point
│   └── manifest.json            # PWA manifest
├── firebase.json                # Firebase configuration
├── firestore.rules              # Firestore security rules
├── firestore.indexes.json       # Firestore indexes
├── storage.rules                # Storage security rules
└── pubspec.yaml                 # Dependencies
```

## Setup Instructions

### Prerequisites

- Flutter SDK (>=3.0.0)
- Firebase CLI
- A Firebase project

### 1. Install Flutter

Follow the official Flutter installation guide: https://flutter.dev/docs/get-started/install

### 2. Clone the Repository

```bash
git clone https://github.com/northernWilder/kids_portfolio.git
cd kids_portfolio
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Firebase Setup

#### Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or use an existing one
3. Enable Firestore Database
4. Enable Firebase Storage
5. Enable Firebase Hosting

#### Configure Firebase for Web

1. In Firebase Console, add a Web app to your project
2. Copy the Firebase configuration
3. **Important**: Copy `.firebaserc.template` to `.firebaserc` and update with your project ID
4. Update `lib/main.dart` with your Firebase configuration:

```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_PROJECT_ID.appspot.com",
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
    appId: "YOUR_APP_ID",
  ),
);
```

#### Deploy Firebase Rules

```bash
# Install Firebase CLI if not already installed
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase (select your project)
firebase init

# Deploy Firestore rules and indexes
firebase deploy --only firestore

# Deploy Storage rules
firebase deploy --only storage
```

### 5. Run the App Locally

```bash
# Enable Flutter web
flutter config --enable-web

# Run in Chrome
flutter run -d chrome
```

### 6. Build for Production

```bash
flutter build web --release
```

### 7. Deploy to Firebase Hosting

```bash
firebase deploy --only hosting
```

## Data Structure

### Media Collection (Firestore)

Each media item in the `media` collection has the following structure:

```json
{
  "artistName": "Joanna Ooms",
  "title": "My Summer Story",
  "description": "A story about summer adventures",
  "category": "stories",
  "imageUrl": "https://...",
  "audioUrl": "https://...",
  "documentUrl": "https://...",
  "timestamp": "2024-01-15T10:30:00Z"
}
```

### Categories

- `stories` - Recorded audio stories
- `photos` - Photos of school work and art
- `writing` - Written assignments and creative writing

### Artists

- Joanna Ooms
- Eleanor Ooms

## Adding Content

To add new portfolio items:

1. Upload media files (images, audio, documents) to Firebase Storage under `/media/{artistName}/`
2. Add a document to the `media` collection in Firestore with the structure above
3. The app will automatically display the new content

### Example: Adding a Story

1. **Upload audio file**:
   - Storage path: `/media/Joanna Ooms/stories/summer-adventure.mp3`
   
2. **Add Firestore document**:
```javascript
{
  artistName: "Joanna Ooms",
  title: "My Summer Adventure",
  description: "A story about what I did during summer vacation",
  category: "stories",
  audioUrl: "https://storage.googleapis.com/.../summer-adventure.mp3",
  timestamp: firebase.firestore.FieldValue.serverTimestamp()
}
```

## Security

- **Read access**: Public (anyone can view the portfolio)
- **Write access**: Restricted to authenticated users only
- Security rules are defined in `firestore.rules` and `storage.rules`

## Future Enhancements

- [ ] Admin panel for uploading content
- [ ] Audio player integration
- [ ] PDF viewer for documents
- [ ] Comments and likes
- [ ] Search functionality
- [ ] Social sharing
- [ ] Download certificates/achievements

## Contributing

This is a private family portfolio. If you have suggestions, please open an issue or contact the repository owner.

## License

Private - All rights reserved.

## Contact

For questions or support, please contact the repository owner.

---

Built with ❤️ using Flutter and Firebase
