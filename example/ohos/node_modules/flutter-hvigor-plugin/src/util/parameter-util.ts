import { hvigor } from '@ohos/hvigor'

export function getParameter(key: string, defaultValue?: string): string | undefined {
  return hvigor.getParameter().getExtParam(key) ?? defaultValue
}

export function getParameters(key: string, defaultValue?: string[]): string[] | undefined {
  return hvigor.getParameter().getExtParam(key)?.split(',') ?? defaultValue
}