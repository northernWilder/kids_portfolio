#!/bin/bash

# Setup script for Kids Portfolio
# This script helps with the initial configuration

echo "🎨 Kids Portfolio Setup Script"
echo "================================"
echo ""

# Check if .firebaserc exists
if [ -f ".firebaserc" ]; then
    echo "✅ .firebaserc already exists"
else
    if [ -f ".firebaserc.template" ]; then
        echo "📝 Creating .firebaserc from template..."
        cp .firebaserc.template .firebaserc
        echo "⚠️  Please edit .firebaserc and add your Firebase project ID"
    else
        echo "❌ .firebaserc.template not found"
    fi
fi

echo ""
echo "📋 Setup Checklist:"
echo ""
echo "1. ☐ Install Flutter SDK"
echo "2. ☐ Create Firebase project"
echo "3. ☐ Copy .firebaserc.template to .firebaserc and update project ID"
echo "4. ☐ Update Firebase config in lib/main.dart"
echo "5. ☐ Run: flutter pub get"
echo "6. ☐ Deploy Firebase rules: firebase deploy --only firestore,storage"
echo "7. ☐ Run: flutter run -d chrome"
echo ""
echo "📚 See QUICKSTART.md for detailed instructions"
echo ""
