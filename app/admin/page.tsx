'use client'

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import Link from 'next/link'

interface PortfolioItem {
  id: string
  title: string
  description: string
  imageUrl: string
  createdAt: string
}

export default function AdminPage() {
  const [isAuthenticated, setIsAuthenticated] = useState(false)
  const [password, setPassword] = useState('')
  const [portfolioItems, setPortfolioItems] = useState<PortfolioItem[]>([])
  const [title, setTitle] = useState('')
  const [description, setDescription] = useState('')
  const [file, setFile] = useState<File | null>(null)
  const [isLoading, setIsLoading] = useState(false)
  const [message, setMessage] = useState('')
  const router = useRouter()

  useEffect(() => {
    const auth = sessionStorage.getItem('admin_auth')
    if (auth === 'true') {
      setIsAuthenticated(true)
      loadPortfolioItems()
    }
  }, [])

  const loadPortfolioItems = async () => {
    try {
      const response = await fetch('/api/portfolio')
      const data = await response.json()
      setPortfolioItems(data)
    } catch (error) {
      console.error('Failed to load portfolio items:', error)
    }
  }

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault()
    // Simple password check (in production, use proper authentication)
    if (password === 'admin123') {
      setIsAuthenticated(true)
      sessionStorage.setItem('admin_auth', 'true')
      loadPortfolioItems()
    } else {
      setMessage('Invalid password')
    }
  }

  const handleUpload = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!file || !title) {
      setMessage('Please provide a title and select an image')
      return
    }

    setIsLoading(true)
    setMessage('')

    try {
      // Upload file
      const formData = new FormData()
      formData.append('file', file)

      const uploadResponse = await fetch('/api/upload', {
        method: 'POST',
        body: formData,
      })

      if (!uploadResponse.ok) {
        throw new Error('File upload failed')
      }

      const { filename } = await uploadResponse.json()

      // Create portfolio item
      const portfolioItem = {
        id: Date.now().toString(),
        title,
        description,
        imageUrl: `/uploads/${filename}`,
        createdAt: new Date().toISOString(),
      }

      const response = await fetch('/api/portfolio', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(portfolioItem),
      })

      if (!response.ok) {
        throw new Error('Failed to create portfolio item')
      }

      setMessage('✅ Upload successful!')
      setTitle('')
      setDescription('')
      setFile(null)
      loadPortfolioItems()
    } catch (error) {
      setMessage('❌ Upload failed: ' + (error as Error).message)
    } finally {
      setIsLoading(false)
    }
  }

  const handleDelete = async (id: string) => {
    if (!confirm('Are you sure you want to delete this item?')) {
      return
    }

    try {
      const response = await fetch('/api/portfolio', {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ id }),
      })

      if (!response.ok) {
        throw new Error('Failed to delete item')
      }

      setMessage('✅ Item deleted successfully')
      loadPortfolioItems()
    } catch (error) {
      setMessage('❌ Delete failed: ' + (error as Error).message)
    }
  }

  if (!isAuthenticated) {
    return (
      <div className="min-h-screen bg-gradient-to-b from-purple-50 to-blue-50 flex items-center justify-center px-4">
        <div className="bg-white p-8 rounded-lg shadow-lg max-w-md w-full">
          <h1 className="text-3xl font-bold text-purple-600 mb-6 text-center">
            Admin Login
          </h1>
          <form onSubmit={handleLogin} className="space-y-4">
            <div>
              <label className="block text-gray-700 mb-2">Password:</label>
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                placeholder="Enter admin password"
              />
            </div>
            <button
              type="submit"
              className="w-full bg-purple-600 text-white py-2 rounded-lg hover:bg-purple-700 transition"
            >
              Login
            </button>
            {message && (
              <p className="text-red-500 text-center mt-4">{message}</p>
            )}
            <p className="text-sm text-gray-500 text-center mt-4">
              Default password: admin123
            </p>
          </form>
          <div className="mt-6 text-center">
            <Link href="/" className="text-purple-600 hover:underline">
              ← Back to Portfolio
            </Link>
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gradient-to-b from-purple-50 to-blue-50">
      <div className="container mx-auto px-4 py-8">
        <header className="mb-8">
          <div className="flex justify-between items-center">
            <h1 className="text-4xl font-bold text-purple-600">
              Admin Dashboard
            </h1>
            <Link
              href="/"
              className="bg-gray-600 text-white px-4 py-2 rounded-lg hover:bg-gray-700 transition"
            >
              View Portfolio
            </Link>
          </div>
        </header>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          {/* Upload Form */}
          <div className="bg-white p-6 rounded-lg shadow-lg">
            <h2 className="text-2xl font-bold text-gray-800 mb-4">
              Upload New Artwork
            </h2>
            <form onSubmit={handleUpload} className="space-y-4">
              <div>
                <label className="block text-gray-700 mb-2">Title:</label>
                <input
                  type="text"
                  value={title}
                  onChange={(e) => setTitle(e.target.value)}
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                  placeholder="Artwork title"
                  required
                />
              </div>
              <div>
                <label className="block text-gray-700 mb-2">
                  Description:
                </label>
                <textarea
                  value={description}
                  onChange={(e) => setDescription(e.target.value)}
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                  placeholder="Describe the artwork"
                  rows={4}
                />
              </div>
              <div>
                <label className="block text-gray-700 mb-2">Image:</label>
                <input
                  type="file"
                  accept="image/*"
                  onChange={(e) => setFile(e.target.files?.[0] || null)}
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                  required
                />
              </div>
              <button
                type="submit"
                disabled={isLoading}
                className="w-full bg-purple-600 text-white py-3 rounded-lg hover:bg-purple-700 transition disabled:bg-gray-400"
              >
                {isLoading ? 'Uploading...' : 'Upload Artwork'}
              </button>
              {message && (
                <p
                  className={`text-center mt-4 ${
                    message.includes('✅') ? 'text-green-600' : 'text-red-600'
                  }`}
                >
                  {message}
                </p>
              )}
            </form>
          </div>

          {/* Portfolio Items List */}
          <div className="bg-white p-6 rounded-lg shadow-lg">
            <h2 className="text-2xl font-bold text-gray-800 mb-4">
              Manage Artwork ({portfolioItems.length})
            </h2>
            <div className="space-y-4 max-h-[600px] overflow-y-auto">
              {portfolioItems.length === 0 ? (
                <p className="text-gray-500 text-center py-8">
                  No artwork uploaded yet
                </p>
              ) : (
                portfolioItems.map((item) => (
                  <div
                    key={item.id}
                    className="border border-gray-200 p-4 rounded-lg flex justify-between items-start"
                  >
                    <div className="flex-1">
                      <h3 className="font-bold text-gray-800">{item.title}</h3>
                      <p className="text-sm text-gray-600">
                        {item.description}
                      </p>
                      <p className="text-xs text-gray-400 mt-2">
                        {new Date(item.createdAt).toLocaleDateString()}
                      </p>
                    </div>
                    <button
                      onClick={() => handleDelete(item.id)}
                      className="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition text-sm ml-4"
                    >
                      Delete
                    </button>
                  </div>
                ))
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
