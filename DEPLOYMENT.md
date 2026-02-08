# Deployment Guide

This guide covers deploying the Kids Portfolio app to Firebase Hosting.

## Prerequisites

- Completed Firebase setup (see FIREBASE_SETUP.md)
- Firebase CLI installed (`npm install -g firebase-tools`)
- Flutter SDK installed

## Manual Deployment

### Step 1: Build the Web App

```bash
# Ensure you're in the project directory
cd kids_portfolio

# Get dependencies
flutter pub get

# Build for web (production)
flutter build web --release
```

This creates optimized files in `build/web/`.

### Step 2: Deploy to Firebase Hosting

```bash
# Login to Firebase (if not already logged in)
firebase login

# Deploy to Firebase Hosting
firebase deploy --only hosting
```

Your app will be deployed to:
- `https://YOUR_PROJECT_ID.web.app`
- `https://YOUR_PROJECT_ID.firebaseapp.com`

### Step 3: Verify Deployment

1. Open the hosting URL in your browser
2. Test all features:
   - Home page loads
   - Both artist cards are visible
   - Portfolio pages work
   - Category filters work
   - Media items display correctly
3. Test on mobile devices
4. Test different browsers

## Automated Deployment (GitHub Actions)

### Setup

1. Generate a Firebase service account key:
   ```bash
   firebase init hosting:github
   ```
   Follow the prompts to set up GitHub Actions.

2. Or manually add secrets to GitHub:
   - Go to your GitHub repository
   - Settings > Secrets and variables > Actions
   - Add these secrets:
     - `FIREBASE_SERVICE_ACCOUNT`: Service account JSON from Firebase Console
     - `FIREBASE_PROJECT_ID`: Your Firebase project ID

3. The workflow in `.github/workflows/deploy.yml` will automatically deploy when you push to the `main` branch.

### Workflow Features

- Triggers on push to `main` branch
- Can be manually triggered from GitHub Actions tab
- Builds Flutter web app
- Deploys to Firebase Hosting
- Shows deployment URL in workflow logs

## Environment-Specific Deployments

### Development/Staging

Deploy to a Firebase preview channel:

```bash
# Create a preview channel
firebase hosting:channel:deploy staging --expires 30d

# Or deploy to a specific channel
firebase hosting:channel:deploy dev --expires 7d
```

Preview URLs look like: `https://YOUR_PROJECT_ID--staging-xxxxx.web.app`

### Production

Deploy to the main site:

```bash
firebase deploy --only hosting
```

## Custom Domain Setup

### Add a Custom Domain

1. Go to Firebase Console > Hosting
2. Click "Add custom domain"
3. Enter your domain (e.g., `joanna-eleanor-portfolio.com`)
4. Follow DNS configuration instructions
5. Wait for SSL certificate provisioning (can take up to 24 hours)

### DNS Configuration

Add these DNS records at your domain registrar:

For root domain (`example.com`):
```
Type: A
Name: @
Value: (IP addresses provided by Firebase)
```

For subdomain (`www.example.com`):
```
Type: CNAME
Name: www
Value: YOUR_PROJECT_ID.web.app
```

## Rollback

If you need to rollback to a previous version:

```bash
# List previous releases
firebase hosting:releases:list

# Rollback to a specific version
firebase hosting:rollback RELEASE_ID
```

## Build Optimization

### Reduce Bundle Size

1. **Enable tree-shaking**: Already enabled in `--release` mode
2. **Optimize images**: Use WebP format for photos
3. **Lazy load content**: Consider pagination for large portfolios

### Performance Tips

```bash
# Build with specific options
flutter build web --release \
  --web-renderer canvaskit \
  --dart-define=FLUTTER_WEB_CANVASKIT_URL=https://unpkg.com/canvaskit-wasm
```

Or use auto renderer (default):
```bash
flutter build web --release --web-renderer auto
```

### Check Bundle Size

```bash
# After building
du -sh build/web
```

## Firebase Hosting Configuration

### Caching

The `firebase.json` includes default caching. To customize:

```json
{
  "hosting": {
    "public": "build/web",
    "headers": [
      {
        "source": "**/*.@(jpg|jpeg|gif|png|svg|webp)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=604800"
          }
        ]
      }
    ]
  }
}
```

### Redirects

Add redirects in `firebase.json`:

```json
{
  "hosting": {
    "redirects": [
      {
        "source": "/old-page",
        "destination": "/new-page",
        "type": 301
      }
    ]
  }
}
```

## Monitoring and Analytics

### Setup Firebase Performance Monitoring

1. Add to `pubspec.yaml`:
   ```yaml
   firebase_performance: ^0.9.0
   ```

2. Initialize in `main.dart`:
   ```dart
   import 'package:firebase_performance/firebase_performance.dart';
   
   FirebasePerformance.instance;
   ```

### Setup Google Analytics

1. Enable in Firebase Console
2. Add to `pubspec.yaml`:
   ```yaml
   firebase_analytics: ^10.8.0
   ```

3. Track events:
   ```dart
   FirebaseAnalytics.instance.logEvent(
     name: 'view_portfolio',
     parameters: {'artist_name': artistName},
   );
   ```

## Troubleshooting

### Build Fails

```bash
# Clean build cache
flutter clean

# Remove packages
rm -rf pubspec.lock
rm -rf .dart_tool

# Reinstall
flutter pub get
flutter build web --release
```

### Deployment Fails

```bash
# Check Firebase login status
firebase login:list

# Relogin if needed
firebase logout
firebase login

# Check project
firebase projects:list
firebase use YOUR_PROJECT_ID
```

### Site Shows Old Version

```bash
# Clear Firebase hosting cache
firebase hosting:channel:delete live

# Redeploy
firebase deploy --only hosting
```

### 404 Errors

Check `firebase.json` rewrites configuration:
```json
{
  "hosting": {
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

## Production Checklist

Before deploying to production:

- [ ] Update Firebase configuration with production keys
- [ ] Test all features locally
- [ ] Add real content (remove sample data)
- [ ] Create custom icons
- [ ] Test on multiple devices and browsers
- [ ] Set up custom domain (optional)
- [ ] Enable HTTPS (automatic with Firebase)
- [ ] Configure analytics (optional)
- [ ] Set up monitoring (optional)
- [ ] Test performance (Lighthouse audit)
- [ ] Review security rules
- [ ] Set up regular backups
- [ ] Document any custom configuration

## Maintenance

### Regular Updates

```bash
# Update Flutter
flutter upgrade

# Update dependencies
flutter pub upgrade

# Rebuild and redeploy
flutter build web --release
firebase deploy --only hosting
```

### Monitor Usage

Check Firebase Console regularly:
- Hosting usage and bandwidth
- Firestore read/write operations
- Storage usage
- Performance metrics
- Error logs

## Cost Management

Firebase offers a generous free tier:
- Hosting: 10GB storage, 360MB/day transfer
- Firestore: 50K reads, 20K writes, 20K deletes per day
- Storage: 5GB, 1GB/day downloads

For a small portfolio, you should stay within free limits.

## Support

- [Firebase Hosting Documentation](https://firebase.google.com/docs/hosting)
- [Flutter Web Deployment](https://flutter.dev/docs/deployment/web)
- [Firebase Support](https://firebase.google.com/support)

## Continuous Deployment

For automatic deployments on every commit:

1. Ensure `.github/workflows/deploy.yml` is configured
2. Add Firebase secrets to GitHub
3. Push to `main` branch
4. Check GitHub Actions tab for deployment status

Your app will automatically deploy on every push to main!
