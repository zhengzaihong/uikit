import fs from 'fs'
import path from 'path'

export function relativePath(basePath: string, filePath: string): string {
  let p = path.relative(basePath, filePath)
  if (!path.isAbsolute(p) && !p.startsWith('.')) {
    p = './' + p
  }
  return p.replaceAll('\\', '/')
}

export function copyDirectory(sourceDir: string, destDir: string): void {
  if (!fs.existsSync(destDir)) {
    fs.mkdirSync(destDir, { recursive: true })
  }
  const entries = fs.readdirSync(sourceDir, { withFileTypes: true })
  for (const entry of entries) {
    const srcPath = path.join(sourceDir, entry.name)
    const destPath = path.join(destDir, entry.name)
    if (entry.isDirectory()) {
      copyDirectory(srcPath, destPath)
    } else {
      fs.copyFileSync(srcPath, destPath)
    }
  }
}

export function listFiles(dirPath: string): string[] {
  const entries = fs.readdirSync(dirPath, { withFileTypes: true })
  const files: string[] = []
  for (const entry of entries) {
    const fullPath = path.join(dirPath, entry.name)
    if (entry.isDirectory()) {
      files.push(...listFiles(fullPath))
    } else {
      files.push(fullPath)
    }
  }
  return files
}

export function realFilePath(filePath: string): string {
  try {
    return fs.realpathSync(filePath)
  } catch (error) {
    return filePath
  }
}