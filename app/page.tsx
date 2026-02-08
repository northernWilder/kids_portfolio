import Link from 'next/link'
import { promises as fs } from 'fs'
import path from 'path'
import Image from 'next/image'

interface PortfolioItem {
  id: string
  title: string
  description: string
  imageUrl: string
  createdAt: string
}

async function getPortfolioItems(): Promise<PortfolioItem[]> {
  try {
    const dataPath = path.join(process.cwd(), 'data', 'portfolio.json')
    const fileContents = await fs.readFile(dataPath, 'utf8')
    return JSON.parse(fileContents)
  } catch (error) {
    return []
  }
}

export default async function Home() {
  const portfolioItems = await getPortfolioItems()

  return (
    <main className="min-h-screen bg-gradient-to-b from-blue-50 to-purple-50">
      <div className="container mx-auto px-4 py-8">
        <header className="text-center mb-12">
          <h1 className="text-5xl font-bold text-purple-600 mb-4">
            🎨 Kids Portfolio
          </h1>
          <p className="text-xl text-gray-600">
            Amazing artwork by talented young artists
          </p>
        </header>

        {portfolioItems.length === 0 ? (
          <div className="text-center py-20">
            <p className="text-2xl text-gray-500 mb-8">
              No artwork yet. Check back soon!
            </p>
            <Link
              href="/admin"
              className="inline-block bg-purple-600 text-white px-6 py-3 rounded-lg hover:bg-purple-700 transition"
            >
              Go to Admin
            </Link>
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {portfolioItems.map((item) => (
              <div
                key={item.id}
                className="bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-xl transition-shadow"
              >
                <div className="relative h-64 bg-gray-200">
                  <Image
                    src={item.imageUrl}
                    alt={item.title}
                    fill
                    className="object-cover"
                  />
                </div>
                <div className="p-6">
                  <h2 className="text-2xl font-bold text-gray-800 mb-2">
                    {item.title}
                  </h2>
                  <p className="text-gray-600">{item.description}</p>
                  <p className="text-sm text-gray-400 mt-4">
                    {new Date(item.createdAt).toLocaleDateString()}
                  </p>
                </div>
              </div>
            ))}
          </div>
        )}

        <footer className="mt-16 text-center">
          <Link
            href="/admin"
            className="text-purple-600 hover:text-purple-800 underline"
          >
            Admin Panel
          </Link>
        </footer>
      </div>
    </main>
  )
}
