export function toCamelCase(parts: string[]): string {
  if (parts.length === 0) {
    return ''
  }
  const firstWord = parts[0].toLowerCase()
  const capitalizedWords = parts.slice(1).map(word => {
    if (word.length === 0) {
      return ''
    }
    return word.charAt(0).toUpperCase() + word.slice(1).toLowerCase()
  })
  return firstWord + capitalizedWords.join('')
}