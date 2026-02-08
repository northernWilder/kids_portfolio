import { NextRequest, NextResponse } from 'next/server'
import { promises as fs } from 'fs'
import path from 'path'

interface PortfolioItem {
  id: string
  title: string
  description: string
  imageUrl: string
  createdAt: string
}

const dataPath = path.join(process.cwd(), 'data', 'portfolio.json')

async function readData(): Promise<PortfolioItem[]> {
  try {
    const fileContents = await fs.readFile(dataPath, 'utf8')
    return JSON.parse(fileContents)
  } catch (error) {
    return []
  }
}

async function writeData(data: PortfolioItem[]): Promise<void> {
  await fs.writeFile(dataPath, JSON.stringify(data, null, 2), 'utf8')
}

export async function GET() {
  try {
    const data = await readData()
    return NextResponse.json(data)
  } catch (error) {
    return NextResponse.json(
      { error: 'Failed to read portfolio data' },
      { status: 500 }
    )
  }
}

export async function POST(request: NextRequest) {
  try {
    const portfolioItem: PortfolioItem = await request.json()
    const data = await readData()
    data.push(portfolioItem)
    await writeData(data)
    return NextResponse.json({ success: true })
  } catch (error) {
    return NextResponse.json(
      { error: 'Failed to create portfolio item' },
      { status: 500 }
    )
  }
}

export async function DELETE(request: NextRequest) {
  try {
    const { id } = await request.json()
    const data = await readData()
    const filteredData = data.filter((item) => item.id !== id)
    await writeData(filteredData)
    return NextResponse.json({ success: true })
  } catch (error) {
    return NextResponse.json(
      { error: 'Failed to delete portfolio item' },
      { status: 500 }
    )
  }
}
