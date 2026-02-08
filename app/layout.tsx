import './globals.css'
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Kids Portfolio',
  description: 'A beautiful portfolio showcasing amazing kids artwork',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
