# Kids Portfolio

A beautiful web application for showcasing kids' artwork with an admin backend for easy content management.

## Features

### Public Portfolio Site
- 🎨 Beautiful, responsive gallery view
- 📱 Mobile-friendly design
- 🖼️ Image display with titles and descriptions
- 🎯 Clean, kid-friendly interface with colorful gradients

### Admin Backend
- 🔐 Simple password-based authentication
- 📤 Easy file upload for artwork images
- ✏️ Add titles and descriptions
- 🗑️ Delete artwork
- 📊 View all portfolio items at a glance

## Tech Stack

- **Next.js 15+** - React framework with server-side rendering
- **TypeScript** - Type-safe development
- **Tailwind CSS** - Modern, responsive styling
- **File-based storage** - Simple JSON data storage

## Getting Started

### Prerequisites

- Node.js 18+ installed
- npm or yarn package manager

### Installation

1. Clone the repository:
```bash
git clone https://github.com/northernWilder/kids_portfolio.git
cd kids_portfolio
```

2. Install dependencies:
```bash
npm install
```

3. Run the development server:
```bash
npm run dev
```

4. Open [http://localhost:3000](http://localhost:3000) in your browser

## Usage

### Viewing the Portfolio

Navigate to the home page (`/`) to see all uploaded artwork in a beautiful gallery layout.

### Admin Access

1. Navigate to `/admin` or click "Admin Panel" link on the home page
2. Enter the admin password (default: `admin123`)
3. Upload new artwork:
   - Add a title
   - Add a description (optional)
   - Select an image file
   - Click "Upload Artwork"
4. Manage existing artwork:
   - View all uploaded items
   - Delete items as needed

### Security Note

⚠️ **Important**: The default password is `admin123`. For production use, you should:
- Implement proper authentication (e.g., NextAuth.js)
- Use environment variables for sensitive data
- Add rate limiting
- Implement HTTPS

## Project Structure

```
kids_portfolio/
├── app/
│   ├── admin/           # Admin interface
│   │   └── page.tsx
│   ├── api/             # API endpoints
│   │   ├── portfolio/   # Portfolio CRUD operations
│   │   │   └── route.ts
│   │   └── upload/      # File upload handling
│   │       └── route.ts
│   ├── globals.css      # Global styles
│   ├── layout.tsx       # Root layout
│   └── page.tsx         # Home page (portfolio gallery)
├── data/
│   └── portfolio.json   # Portfolio data storage
├── public/
│   └── uploads/         # Uploaded images
├── next.config.js       # Next.js configuration
├── tailwind.config.js   # Tailwind CSS configuration
├── tsconfig.json        # TypeScript configuration
└── package.json         # Dependencies and scripts
```

## API Endpoints

### GET /api/portfolio
Returns all portfolio items.

### POST /api/portfolio
Creates a new portfolio item.
```json
{
  "id": "unique-id",
  "title": "Artwork Title",
  "description": "Description",
  "imageUrl": "/uploads/filename.jpg",
  "createdAt": "ISO-8601-timestamp"
}
```

### DELETE /api/portfolio
Deletes a portfolio item by ID.
```json
{
  "id": "item-id-to-delete"
}
```

### POST /api/upload
Uploads an image file and returns the filename.

## Development

### Running in Development Mode
```bash
npm run dev
```

### Building for Production
```bash
npm run build
npm start
```

### Linting
```bash
npm run lint
```

## Deployment

This application can be easily deployed to:
- **Vercel** (recommended for Next.js)
- **Netlify**
- **Any Node.js hosting service**

### Vercel Deployment

1. Push your code to GitHub
2. Import the project in Vercel
3. Vercel will automatically detect Next.js and configure the build
4. Deploy!

## Future Enhancements

Potential features to add:
- [ ] Multi-user support with user management
- [ ] Categories/tags for artwork
- [ ] Search and filter functionality
- [ ] Image editing capabilities
- [ ] Comments and likes
- [ ] Gallery slideshow mode
- [ ] Export portfolio to PDF
- [ ] Social media sharing
- [ ] OAuth authentication (Google, GitHub, etc.)
- [ ] Database integration (PostgreSQL, MongoDB)
- [ ] Cloud storage for images (AWS S3, Cloudinary)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

ISC

## Support

For issues and questions, please open an issue on GitHub.
