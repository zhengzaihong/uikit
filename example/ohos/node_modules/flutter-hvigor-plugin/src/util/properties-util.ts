import fs from 'fs'

export function loadProperties(propertiesPath: string): { [key: string]: string } {
  const fileContent = fs.readFileSync(propertiesPath, 'utf-8')
  const properties: { [key: string]: string } = {}
  fileContent.split('\n').forEach(line => {
    if (line.trim() === '' || line.trim().startsWith('#')) {
      return
    }
    const [key, value] = line.split('=').map(part => part.trim())
    if (key && value) {
      properties[key] = value
    }
  })
  return properties
}