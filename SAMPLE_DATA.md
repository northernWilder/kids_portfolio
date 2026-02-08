# Sample Data for Testing

This document contains sample data that can be added to Firestore to test the application.

## Adding Sample Data via Firebase Console

### Method 1: Manual Entry

1. Open Firebase Console
2. Go to Firestore Database
3. Click "Start collection" (or add to existing `media` collection)
4. Collection ID: `media`
5. Click "Auto-ID" to generate a document ID
6. Add the fields below

### Sample Media Items

#### Sample 1: Joanna's Story

```
Document ID: (auto-generated)

Fields:
- artistName (string): "Joanna Ooms"
- title (string): "My Summer Adventure"
- description (string): "This is a story about what I did during summer vacation. I went to the beach, built sandcastles, and collected seashells. It was the best summer ever!"
- category (string): "stories"
- timestamp (timestamp): (select current date/time)
```

#### Sample 2: Eleanor's Artwork

```
Document ID: (auto-generated)

Fields:
- artistName (string): "Eleanor Ooms"
- title (string): "Sunset Painting"
- description (string): "I painted this beautiful sunset using watercolors. The sky has purple, orange, and pink colors mixing together."
- category (string): "photos"
- timestamp (timestamp): (select current date/time)
```

#### Sample 3: Joanna's Writing

```
Document ID: (auto-generated)

Fields:
- artistName (string): "Joanna Ooms"
- title (string): "My Favorite Animal"
- description (string): "An essay about dolphins. Did you know dolphins are mammals and they can swim very fast? They are also very smart and friendly."
- category (string): "writing"
- timestamp (timestamp): (select current date/time)
```

#### Sample 4: Eleanor's Story

```
Document ID: (auto-generated)

Fields:
- artistName (string): "Eleanor Ooms"
- title (string): "The Magic Garden"
- description (string): "A story about a secret garden where flowers can talk and butterflies grant wishes."
- category (string): "stories"
- timestamp (timestamp): (select current date/time)
```

#### Sample 5: Joanna's Art Project

```
Document ID: (auto-generated)

Fields:
- artistName (string): "Joanna Ooms"
- title (string): "Paper Mache Volcano"
- description (string): "Science project - I made a volcano that erupts! Used newspaper, glue, and baking soda with vinegar for the eruption."
- category (string): "photos"
- timestamp (timestamp): (select current date/time)
```

#### Sample 6: Eleanor's Writing

```
Document ID: (auto-generated)

Fields:
- artistName (string): "Eleanor Ooms"
- title (string): "My Family"
- description (string): "A poem about my family. We love to play games together, go on adventures, and tell funny jokes."
- category (string): "writing"
- timestamp (timestamp): (select current date/time)
```

## Method 2: Using Firebase CLI (Advanced)

Create a file `import_data.js`:

```javascript
const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

const sampleData = [
  {
    artistName: "Joanna Ooms",
    title: "My Summer Adventure",
    description: "This is a story about what I did during summer vacation.",
    category: "stories",
    timestamp: admin.firestore.FieldValue.serverTimestamp()
  },
  {
    artistName: "Eleanor Ooms",
    title: "Sunset Painting",
    description: "I painted this beautiful sunset using watercolors.",
    category: "photos",
    timestamp: admin.firestore.FieldValue.serverTimestamp()
  },
  {
    artistName: "Joanna Ooms",
    title: "My Favorite Animal",
    description: "An essay about dolphins.",
    category: "writing",
    timestamp: admin.firestore.FieldValue.serverTimestamp()
  }
];

async function importData() {
  const batch = db.batch();
  
  sampleData.forEach((item) => {
    const docRef = db.collection('media').doc();
    batch.set(docRef, item);
  });
  
  await batch.commit();
  console.log('Sample data imported successfully!');
}

importData();
```

Run with:
```bash
node import_data.js
```

## Adding Images/Media Files

To add actual media files (images, audio, documents):

1. Go to Firebase Console > Storage
2. Navigate to `/media/{ArtistName}/`
3. Upload files to appropriate category folder:
   - `stories/` - for audio recordings (.mp3, .wav)
   - `photos/` - for images (.jpg, .png)
   - `writing/` - for documents (.pdf)

4. After uploading, click on the file and copy the download URL
5. Add the URL to the corresponding Firestore document:
   - `imageUrl` - for photos
   - `audioUrl` - for audio stories
   - `documentUrl` - for written documents

### Example with Media URLs

```
Document with Image:
- artistName: "Joanna Ooms"
- title: "My Drawing"
- description: "A colorful drawing of a rainbow"
- category: "photos"
- imageUrl: "https://firebasestorage.googleapis.com/v0/b/YOUR-PROJECT/o/media%2FJoanna%20Ooms%2Fphotos%2Fdrawing.jpg?alt=media&token=..."
- timestamp: (current timestamp)
```

## Testing the Application

After adding sample data:

1. Run the app: `flutter run -d chrome`
2. You should see both artists on the home page
3. Click on each artist to see their portfolios
4. Test the category filters (All, Stories, Photos, Writing)
5. Click on individual items to view details

## Cleanup

To remove all sample data:

1. Go to Firestore Console
2. Select all documents in the `media` collection
3. Click Delete
4. Confirm deletion

Or use Firebase CLI:
```bash
firebase firestore:delete media --recursive
```

## Production Data

When ready for production:

1. Remove all test data
2. Add real portfolio items
3. Upload actual media files (photos, recordings, documents)
4. Update descriptions and titles to real content
5. Ensure all media URLs are correct and accessible

## Data Validation

Before going live, verify:

- [ ] All artistName values match exactly: "Joanna Ooms" or "Eleanor Ooms"
- [ ] All category values are: "stories", "photos", or "writing"
- [ ] All URLs are valid and accessible
- [ ] Timestamps are set correctly
- [ ] Descriptions are appropriate and family-friendly
- [ ] No sensitive or private information is included
