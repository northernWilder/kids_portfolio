# Quick Start Guide

Get the Kids Portfolio app running in 5 minutes!

## Prerequisites

- [ ] Flutter SDK installed (https://flutter.dev/docs/get-started/install)
- [ ] Firebase account (https://console.firebase.google.com/)
- [ ] Git installed

## Step-by-Step Setup

### 1. Clone & Install (1 minute)

```bash
git clone https://github.com/northernWilder/kids_portfolio.git
cd kids_portfolio
flutter pub get
```

### 2. Firebase Setup (2 minutes)

1. Create a Firebase project at https://console.firebase.google.com/
2. Add a web app and copy the configuration
3. Enable Firestore Database (production mode)
4. Enable Firebase Storage

### 3. Configure App (1 minute)

Edit `lib/main.dart` and replace the Firebase configuration:

```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "YOUR_API_KEY",              // From Firebase Console
    authDomain: "YOUR_PROJECT.firebaseapp.com",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_PROJECT.appspot.com",
    messagingSenderId: "YOUR_SENDER_ID",
    appId: "YOUR_APP_ID",
  ),
);
```

Edit `.firebaserc` and add your project ID:

```json
{
  "projects": {
    "default": "YOUR_PROJECT_ID"
  }
}
```

### 4. Deploy Firebase Rules (30 seconds)

```bash
npm install -g firebase-tools
firebase login
firebase deploy --only firestore,storage
```

### 5. Run App (30 seconds)

```bash
flutter run -d chrome
```

🎉 Done! The app should open in Chrome.

## Add Sample Data (Optional)

To test with sample data:

1. Go to Firebase Console → Firestore Database
2. Create a collection named `media`
3. Add a document with these fields:

```
artistName: "Joanna Ooms"
title: "My First Story"
description: "A wonderful story"
category: "stories"
timestamp: (current timestamp)
```

4. Refresh the app!

## Deploy to Production (1 minute)

```bash
flutter build web --release
firebase deploy --only hosting
```

Your site will be live at `https://YOUR_PROJECT_ID.web.app`

## Troubleshooting

### "Firebase not initialized"
→ Check Firebase configuration in `main.dart`

### "Permission denied" in Firestore
→ Run `firebase deploy --only firestore:rules`

### App doesn't load
→ Check browser console for errors
→ Ensure Firebase project has Firestore and Storage enabled

## Next Steps

✅ Read [README.md](README.md) for full documentation
✅ See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for detailed Firebase config
✅ Check [SAMPLE_DATA.md](SAMPLE_DATA.md) for test data examples
✅ Review [DEPLOYMENT.md](DEPLOYMENT.md) for production deployment

## Need Help?

- Check existing issues: https://github.com/northernWilder/kids_portfolio/issues
- Read the full documentation in README.md
- Contact: [repository maintainer]

---

Happy coding! 🎨✨
