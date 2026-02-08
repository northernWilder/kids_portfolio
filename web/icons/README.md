# Web Icons Setup

## Required Icons

The web app requires the following icon files in the `web/icons/` directory:

- `Icon-192.png` - 192x192 pixels
- `Icon-512.png` - 512x512 pixels
- `Icon-maskable-192.png` - 192x192 pixels (maskable)
- `Icon-maskable-512.png` - 512x512 pixels (maskable)

And in the `web/` directory:
- `favicon.png` - 32x32 or 64x64 pixels

## Creating Icons

### Option 1: Use Online Icon Generator

1. Go to https://favicon.io/favicon-generator/
2. Create an icon with:
   - Text: "J&E" or "🎨"
   - Background: Purple (#9C27B0)
   - Font: Rounded/friendly
3. Download and rename files appropriately

### Option 2: Use Design Software

Create icons with these specifications:
- **Background**: Purple/pink gradient
- **Icon**: Paint palette, paintbrush, or initials "J&E"
- **Style**: Colorful, friendly, suitable for children's portfolio
- **Format**: PNG with transparency

### Option 3: Quick Placeholder Icons

For development/testing, you can use simple colored squares:

#### Using ImageMagick (if installed):

```bash
cd web/icons

# Icon-192.png
convert -size 192x192 xc:'#9C27B0' \
  -gravity center -pointsize 72 -fill white \
  -annotate +0+0 "J&E" Icon-192.png

# Icon-512.png
convert -size 512x512 xc:'#9C27B0' \
  -gravity center -pointsize 192 -fill white \
  -annotate +0+0 "J&E" Icon-512.png

# Maskable versions (with safe zone padding)
convert -size 192x192 xc:'#9C27B0' \
  -gravity center -pointsize 60 -fill white \
  -annotate +0+0 "J&E" Icon-maskable-192.png

convert -size 512x512 xc:'#9C27B0' \
  -gravity center -pointsize 160 -fill white \
  -annotate +0+0 "J&E" Icon-maskable-512.png

# Favicon
cd ..
convert -size 64x64 xc:'#9C27B0' \
  -gravity center -pointsize 24 -fill white \
  -annotate +0+0 "J&E" favicon.png
```

#### Using Python with Pillow:

```python
from PIL import Image, ImageDraw, ImageFont

def create_icon(size, text, filename):
    # Create image with purple background
    img = Image.new('RGB', (size, size), color='#9C27B0')
    draw = ImageDraw.Draw(img)
    
    # Calculate text size and position
    font_size = size // 3
    try:
        font = ImageFont.truetype("arial.ttf", font_size)
    except:
        font = ImageFont.load_default()
    
    # Get text bounding box
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    
    # Calculate position to center text
    x = (size - text_width) // 2
    y = (size - text_height) // 2
    
    # Draw text
    draw.text((x, y), text, fill='white', font=font)
    
    # Save
    img.save(filename)

# Create icons
create_icon(192, "J&E", "web/icons/Icon-192.png")
create_icon(512, "J&E", "web/icons/Icon-512.png")
create_icon(192, "J&E", "web/icons/Icon-maskable-192.png")
create_icon(512, "J&E", "web/icons/Icon-maskable-512.png")
create_icon(64, "J&E", "web/favicon.png")
```

Run with: `python create_icons.py`

## Icon Design Recommendations

### Colors
- Primary: Purple (#9C27B0)
- Secondary: Pink (#E91E63)
- Consider using a gradient

### Design Elements
- Paint palette
- Paintbrush
- Pencil
- Stars
- Initials (J & E)
- Heart
- Rainbow

### Style Guidelines
- Keep it simple and recognizable at small sizes
- Use high contrast (light icon on dark background or vice versa)
- Ensure readability at 32x32 pixels
- Make it friendly and age-appropriate
- Consider the "maskable" safe zone (20% padding from edges)

## Maskable Icons

Maskable icons need a safe zone of approximately 20% padding from all edges because different platforms may apply different shapes (circle, rounded square, etc.)

## Testing Icons

1. Run the app: `flutter run -d chrome`
2. Check browser tab for favicon
3. Open DevTools > Application > Manifest to verify PWA icons
4. Test on mobile device by adding to home screen

## Resources

- [PWA Icon Generator](https://www.pwabuilder.com/imageGenerator)
- [Favicon Generator](https://favicon.io/)
- [Maskable Icon Editor](https://maskable.app/)
- [Flutter Icon Guide](https://flutter.dev/docs/development/ui/assets-and-images)

## Current Status

⚠️ **Placeholder icons need to be created**

The app will work without custom icons, but will show browser defaults. For production deployment, create professional icons following the guidelines above.
