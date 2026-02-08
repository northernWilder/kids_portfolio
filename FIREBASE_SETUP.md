# Firebase Setup Guide

This guide will walk you through setting up Firebase for the Kids Portfolio app.

## Step 1: Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name (e.g., "kids-portfolio")
4. Click Continue
5. Disable Google Analytics (optional for this project)
6. Click "Create project"
7. Wait for the project to be created

## Step 2: Register Web App

1. In your Firebase project, click the Web icon (</>) to add a web app
2. Register app nickname: "Kids Portfolio Web"
3. Check "Also set up Firebase Hosting for this app"
4. Click "Register app"
5. Copy the Firebase configuration object (you'll need this later)
6. Click "Continue to console"

## Step 3: Enable Firestore Database

1. In Firebase Console, click "Firestore Database" in the left menu
2. Click "Create database"
3. Select "Start in production mode"
4. Choose a location (select closest to your users)
5. Click "Enable"

## Step 4: Enable Firebase Storage

1. In Firebase Console, click "Storage" in the left menu
2. Click "Get started"
3. Click "Next" (keep default security rules)
4. Choose same location as Firestore
5. Click "Done"

## Step 5: Configure the Flutter App

1. Open `lib/main.dart`
2. Replace the placeholder Firebase configuration with your actual values:

```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "AIza...",  // Your API key
    authDomain: "kids-portfolio.firebaseapp.com",
    projectId: "kids-portfolio",
    storageBucket: "kids-portfolio.appspot.com",
    messagingSenderId: "123456789",
    appId: "1:123456789:web:abc123",
  ),
);
```

3. Update `.firebaserc` with your project ID:

```json
{
  "projects": {
    "default": "kids-portfolio"
  }
}
```

## Step 6: Deploy Firestore Rules and Indexes

```bash
# Install Firebase CLI (if not already installed)
npm install -g firebase-tools

# Login to Firebase
firebase login

# Deploy Firestore rules and indexes
firebase deploy --only firestore:rules
firebase deploy --only firestore:indexes

# Deploy Storage rules
firebase deploy --only storage
```

## Step 7: Set Up Storage Structure

In Firebase Console > Storage:

1. Create folders for each artist:
   - `/media/Joanna Ooms/`
   - `/media/Eleanor Ooms/`

2. Within each artist folder, create category folders:
   - `stories/`
   - `photos/`
   - `writing/`

## Step 8: Add Sample Data (Optional)

### Using Firebase Console

1. Go to Firestore Database
2. Click "Start collection"
3. Collection ID: `media`
4. Add a document with these fields:

```
artistName: "Joanna Ooms"
title: "My First Story"
description: "A wonderful story about..."
category: "stories"
timestamp: (current timestamp)
imageUrl: (optional - URL from Storage)
audioUrl: (optional - URL from Storage)
documentUrl: (optional - URL from Storage)
```

### Using Firebase CLI with JSON

Create a file `sample_data.json`:

```json
[
  {
    "artistName": "Joanna Ooms",
    "title": "Summer Adventure",
    "description": "A story about my summer vacation",
    "category": "stories",
    "timestamp": {"_seconds": 1700000000}
  },
  {
    "artistName": "Eleanor Ooms",
    "title": "My Painting",
    "description": "A beautiful sunset painting",
    "category": "photos",
    "timestamp": {"_seconds": 1700000000}
  }
]
```

Then import using Firestore import tools or manually add through console.

## Step 9: Test the Application

```bash
# Run locally
flutter run -d chrome

# Or build and deploy
flutter build web --release
firebase deploy --only hosting
```

## Step 10: Deploy to Production

```bash
# Build the app
flutter build web --release

# Deploy to Firebase Hosting
firebase deploy --only hosting
```

Your app will be available at: `https://YOUR_PROJECT_ID.web.app`

## Troubleshooting

### Error: Firebase not initialized

- Check that your Firebase configuration in `main.dart` is correct
- Ensure all API keys and IDs match your Firebase project

### Error: Permission denied

- Check that Firestore rules are deployed: `firebase deploy --only firestore:rules`
- Verify rules allow public read access

### Error: Missing indexes

- Deploy Firestore indexes: `firebase deploy --only firestore:indexes`
- Or create indexes automatically when prompted by Firestore errors

### CORS errors when loading media

- In Firebase Storage, ensure files are publicly accessible
- Check storage rules allow read access

## Security Considerations

### Current Setup (Read-Only Portfolio)

- **Read**: Public access (anyone can view)
- **Write**: Requires authentication (for future admin panel)

### For Production with Admin Panel

1. Enable Firebase Authentication
2. Add admin user emails to Firestore in an `admins` collection
3. Update security rules to check admin status
4. Build admin panel for uploading content

### Recommended Security Rules Updates

For production, consider:

```javascript
// firestore.rules - More restrictive
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /media/{document=**} {
      allow read: if true;
      allow write: if request.auth != null && 
                      get(/databases/$(database)/documents/admins/$(request.auth.uid)).data.isAdmin == true;
    }
  }
}
```

## Backup and Maintenance

### Regular Backups

1. Export Firestore data regularly:
   ```bash
   gcloud firestore export gs://YOUR_BUCKET/backups/$(date +%Y%m%d)
   ```

2. Download Storage files:
   ```bash
   gsutil -m cp -r gs://YOUR_BUCKET/media ./backups/
   ```

### Monitoring

1. Enable Firebase monitoring in console
2. Set up alerts for:
   - High read/write counts
   - Storage usage
   - Hosting bandwidth

### Cost Management

- Monitor Firebase usage in console
- Set up budget alerts in Google Cloud Console
- Current setup should stay within free tier for small portfolios

## Support

For Firebase-specific issues:
- [Firebase Documentation](https://firebase.google.com/docs)
- [Firebase Support](https://firebase.google.com/support)

For app-specific issues:
- Check the main README.md
- Open an issue in the repository
