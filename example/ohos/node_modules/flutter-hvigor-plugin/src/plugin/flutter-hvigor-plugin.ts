import fs from 'fs'
import path from 'path'
import { platform } from 'process'
import { execSync } from 'child_process'
import { OhosAppContext, OhosHapContext, OhosHarContext, OhosPluginId, Target } from '@ohos/hvigor-ohos-plugin'
import { hvigor, HvigorNode, HvigorPlugin } from '@ohos/hvigor'
import { relativePath, copyDirectory, listFiles, realFilePath } from '../util/file-util'
import { getParameter, getParameters } from '../util/parameter-util'
import { loadProperties } from '../util/properties-util'
import { toCamelCase } from '../util/string-util'

/** The platforms that can be passed to the `-p target-platform` flag. */
const PLATFORM_ARM32 = 'ohos-arm'
const PLATFORM_ARM64 = 'ohos-arm64'
const PLATFORM_X86_64 = 'ohos-x64'

/** The ABI architectures supported by Flutter. */
const ARCH_ARM32 = "armeabi-v7a"
const ARCH_ARM64 = "arm64-v8a"
const ARCH_X86_64 = "x86_64"

/** Maps platforms to ABI architectures. */
const PLATFORM_ARCH_MAP: Record<string, string> = {
  [PLATFORM_ARM32]: ARCH_ARM32,
  [PLATFORM_ARM64]: ARCH_ARM64,
  [PLATFORM_X86_64]: ARCH_X86_64,
}

/** When split is enabled, multiple APKs are generated per each ABI. */
const DEFAULT_PLATFORMS = [
  PLATFORM_ARM64,
  PLATFORM_X86_64
]

const TARGET_PLATFORM = 'TARGET_PLATFORM'

const localEngineHost = getParameter('LOCAL_ENGINE_HOST') // /xxx/engine/src/out/host_debug_unopt
const localEngineSrcPath = getParameter('FLUTTER_ENGINE') // /xxx/engine/src
const localEngine = getParameter('LOCAL_ENGINE') // /xxx/engine/src/out/ohos_debug_unopt_arm64

const FLUTTER_ASSETS_PATH = 'flutter_assets'

export function flutterHvigorPlugin(flutterProjectPath: string, flutterProjectType: number = 0): HvigorPlugin {
  /**
   * 0: flutter app
   * 1: flutter module
   */
  return {
    pluginId: 'flutter-hvigor-plugin',
    apply(rootNode: HvigorNode) {
      const appContext = rootNode.getContext(OhosPluginId.OHOS_APP_PLUGIN) as OhosAppContext
      const flutterPluginsDependenciesPath = path.join(flutterProjectPath, '.flutter-plugins-dependencies')
      const nativePlugins = findFlutterPlugins(flutterPluginsDependenciesPath)
      const ohosDir = flutterProjectType === 1 ? '.ohos' : 'ohos'
      const properties = loadProperties(path.join(flutterProjectPath, ohosDir, 'local.properties'))
      const sdkPath = properties['flutter.sdk']
      const productName = appContext.getCurrentProduct().getProductName()
      const targetPlatforms = getParameters(TARGET_PLATFORM, DEFAULT_PLATFORMS)
      const buildMode = appContext.getBuildMode()
      rootNode.afterNodeEvaluate(node => {
        // app.json5
        if (flutterProjectType === 0) {
          const appJsonOpt = appContext.getAppJsonOpt()
          appJsonOpt['app']['versionCode'] = Number(properties['flutter.versionCode'] ?? 1)
          appJsonOpt['app']['versionName'] = properties['flutter.versionName'] ?? '1.0'
          appContext.setAppJsonOpt(appJsonOpt)
        }
        // build-profile.json5
        const overrides = appContext.getOverrides() ?? {}
        setFlutterHarInOverrides(overrides, targetPlatforms!, sdkPath, buildMode)
        nativePlugins.forEach(nativePlugin => {
          overrides[nativePlugin.name] =
            `file:${path.join(nativePlugin.path, 'ohos')}`
        })
        if (flutterProjectType == 1) {
          overrides['@ohos/flutter_module'] = `file:${path.join(flutterProjectPath, '.ohos', 'flutter_module')}`
        }
        appContext.setOverrides(overrides)
      })
      rootNode.subNodes(subNode => {
        // 仅当entry的hvigorfile.ts是以下形式：
        // export default {
        //   system: hapTasks,
        //   plugins: []
        // }
        // 以下修改方可生效
        const subNodeName = subNode.getNodeName()
        if (subNodeName === 'entry') {
          subNode.afterNodeEvaluate(node => {
            const hapContext = node.getContext(OhosPluginId.OHOS_HAP_PLUGIN) as OhosHapContext
            if (!hapContext) {
              return
            }
            if (flutterProjectType == 0) {
              hapContext.targets((target: Target) => {
                registerFlutterTask(node, sdkPath, buildMode, flutterProjectPath, target)
              })
            }
            const dependenciesOpt = hapContext.getDependenciesOpt()
            setFlutterHarInDependencies(dependenciesOpt, targetPlatforms)
            nativePlugins.forEach(nativePlugin => {
              dependenciesOpt[nativePlugin.name] = ''
            })
            hapContext.setDependenciesOpt(dependenciesOpt)
          })
        } else if (subNodeName === 'flutter_module' && flutterProjectType === 1) {
          subNode.afterNodeEvaluate(node => {
            const harContext = node.getContext(OhosPluginId.OHOS_HAR_PLUGIN) as OhosHarContext
            if (!harContext) {
              return
            }
            harContext.targets((target: Target) => {
              registerFlutterTask(node, sdkPath, buildMode, flutterProjectPath, target)
            })
            const dependenciesOpt = harContext.getDependenciesOpt()
            setFlutterHarInDependencies(dependenciesOpt, targetPlatforms)
            nativePlugins.forEach(nativePlugin => {
              dependenciesOpt[nativePlugin.name] = ''
            })
            harContext.setDependenciesOpt(dependenciesOpt)
          })
        } else if (nativePlugins.map(it => it.name).includes(subNodeName)) {
          // 仅当flutter plugin的hvigorfile.ts是以下形式：
          // export default {
          //   system: harTasks,
          //   plugins: []
          // }
          // 以下修改方可生效
          subNode.afterNodeEvaluate(node => {
            const harContext = node.getContext(OhosPluginId.OHOS_HAR_PLUGIN) as OhosHarContext
            if (!harContext) {
              return
            }
            const dependenciesOpt = harContext.getDependenciesOpt()
            setFlutterHarInDependencies(dependenciesOpt, targetPlatforms)
            harContext.setDependenciesOpt(dependenciesOpt)
          })
        }
      })
    }
  }
}

function setFlutterHarInDependencies(dependenciesOpt: any, targetPlatforms: string[] | undefined) {
  dependenciesOpt['@ohos/flutter_ohos'] = ''
  targetPlatforms?.map(platform => PLATFORM_ARCH_MAP[platform].replace('-', '_'))
    .forEach(arch => {
      dependenciesOpt[`flutter_native_${arch}`] = ''
    })
}

function setFlutterHarInOverrides(
  overrides: Record<string, string>,
  targetPlatforms: string[],
  sdkPath: string,
  buildMode: string) {
  const buildModeSuffix = buildMode !== 'debug' ? `-${buildMode}` : ''
  targetPlatforms?.forEach((platform, index: number) => {
    const arch = PLATFORM_ARCH_MAP[platform].replace('-', '_')
    const cacheDir = localEngineSrcPath && localEngine
      ? path.join(localEngineSrcPath, "out", localEngine)
      : path.join(sdkPath, 'bin', 'cache', 'artifacts', 'engine', `${platform}${buildModeSuffix}`)

    if (index == 0) {
      // Set flutter_embedding_${buildMode} override for the first target platform
      const flutterHarPath = path.join(cacheDir, `flutter_embedding_${buildMode}.har`)
      overrides['@ohos/flutter_ohos'] = `file:${realFilePath(flutterHarPath)}`
    }
    // Set flutter_native_${arch} overrides for each target platform
    const platformHarPath = path.join(cacheDir, `${arch}_${buildMode}.har`)
    overrides[`flutter_native_${arch}`] = `file:${realFilePath(platformHarPath)}`
  })
}

export function injectNativeModules(nativeProjectPath: string, flutterProjectPath: string,
  flutterProjectType: number = 0) {
  /**
   * 0: flutter app
   * 1: flutter module
   */
  const hvigorConfig = hvigor.getHvigorConfig()
  if (flutterProjectType === 1) {
    const srcPath = relativePath(nativeProjectPath, path.join(flutterProjectPath, '.ohos', 'flutter_module'))
    hvigorConfig.includeNode(
      'flutter_module',
      srcPath
    )
  }
  const flutterPluginsDependenciesPath = path.join(flutterProjectPath, '.flutter-plugins-dependencies')
  findFlutterPlugins(flutterPluginsDependenciesPath).forEach(nativePlugin => {
    const srcPath = relativePath(nativeProjectPath, path.join(nativePlugin.path, 'ohos'))
    hvigorConfig.includeNode(
      nativePlugin.name,
      srcPath
    )
  })
}

function registerFlutterTask(node: HvigorNode, sdkPath: string, buildMode: string, flutterProjectPath: string,
  target: Target) {
  const targetPlatforms = getParameters(TARGET_PLATFORM, DEFAULT_PLATFORMS)
  const productName = target.getCurrentProduct().getProductName()
  const targetName = target.getTargetName()
  // const outputPath = target.getBuildTargetOutputPath()
  node.registerTask({
    name: `${targetName}@FlutterTask`,
    postDependencies: [`${targetName}@MergeProfile`],
    run: (taskContext) => {
      // flutter assemble
      const flutterExecutableName = platform === 'win32' ? 'flutter.bat' : 'flutter'
      const flutterExecutablePath = path.join(
        sdkPath,
        'bin',
        flutterExecutableName
      )
      let targetNames: string[]
      if (buildMode === 'debug') {
        targetNames = ['debug_ohos_application']
      } else if (buildMode === 'profile') {
        targetNames = targetPlatforms.map(it => `ohos_aot_bundle_profile_${it}`)
      } else {
        targetNames = targetPlatforms.map(it => `ohos_aot_bundle_release_${it}`)
      }
      const flutterArgs: string[] = []
      flutterArgs.push(flutterExecutablePath)
      if (localEngineSrcPath) {
        flutterArgs.push('--local-engine-src-path', localEngineSrcPath)
      }
      if (localEngine) {
        flutterArgs.push('--local-engine', localEngine)
      }
      if (localEngineHost) {
        flutterArgs.push('--local-engine-host', localEngineHost)
      }
      if (getParameter('VERBOSE_SCRIPT_LOGGING') === 'true') {
        flutterArgs.push('--verbose')
      } else {
        flutterArgs.push('--quiet')
      }
      flutterArgs.push('assemble')
      flutterArgs.push('--no-version-check')
      const intermediateDir = `build/ohos/intermediates/flutter/${toCamelCase([productName, buildMode])}`
      flutterArgs.push('--depfile', `${intermediateDir}/flutter_build.d`)
      flutterArgs.push('--output', `${intermediateDir}`)
      const performanceMeasurementFile = getParameter('PERFORMANCE_MEASUREMENT_FILE')
      if (performanceMeasurementFile) {
        flutterArgs.push(`--performance-measurement-file=${performanceMeasurementFile}`)
      }
      const targetPath = getParameter('FLUTTER_TARGET', 'lib/main.dart')
      flutterArgs.push(`-dTargetFile=${targetPath}`)
      flutterArgs.push('-dTargetPlatform=ohos')
      flutterArgs.push(`-dBuildMode=${buildMode}`)
      const trackWidgetCreation = getParameter('TRACK_WIDGET_CREATION')
      if (trackWidgetCreation) {
        flutterArgs.push(`-dTrackWidgetCreation=${trackWidgetCreation}`)
      }
      const splitDebugInfo = getParameter('SPLIT_DEBUG_INFO')
      if (splitDebugInfo) {
        flutterArgs.push(`-dSplitDebugInfo=${splitDebugInfo}`)
      }
      const treeShakeIcons = getParameter('TREE_SHAKE_ICONS')
      if (treeShakeIcons === 'true') {
        flutterArgs.push('-dTreeShakeIcons=true')
      }
      const dartObfuscation = getParameter('DART_OBFUSCATION')
      if (dartObfuscation === 'true') {
        flutterArgs.push('-dDartObfuscation=true')
      }
      const dartDefines = getParameter('DART_DEFINES')
      if (dartDefines) {
        flutterArgs.push(`--DartDefines=${dartDefines}`)
      }
      const bundleSkSLPath = getParameter('BUNDLE_SKSL_PATH')
      if (bundleSkSLPath) {
        flutterArgs.push(`-dBundleSkSLPath=${bundleSkSLPath}`)
      }
      const codeSizeDirectory = getParameter('CODE_SIZE_DIRECTORY')
      if (codeSizeDirectory) {
        flutterArgs.push(`-dCodeSizeDirectory=${codeSizeDirectory}`)
      }
      if (productName !== 'default') {
        flutterArgs.push(`-dFlavor=${productName}`)
      }
      const extraGenSnapshotOptions = getParameter('EXTRA_GEN_SNAPSHOT_OPTIONS')
      if (extraGenSnapshotOptions) {
        flutterArgs.push(`--ExtraGenSnapshotOptions=${extraGenSnapshotOptions}`)
      }
      const frontendServerStarterPath = getParameter('FRONTEND_SERVER_STARTER_PATH')
      if (frontendServerStarterPath) {
        flutterArgs.push(`-dFrontendServerStarterPath=${frontendServerStarterPath}`)
      }
      const extraFrontEndOptions = getParameter('EXTRA_FRONT_END_OPTIONS')
      if (extraFrontEndOptions) {
        flutterArgs.push(`--ExtraFrontEndOptions=${extraFrontEndOptions}`)
      }
      flutterArgs.push(`-dOhosArchs=${targetPlatforms.join(' ')}`)
      flutterArgs.push(...targetNames)
      const command = flutterArgs.join(' ')
      try {
        const result = execSync(
          command,
          {
            cwd: flutterProjectPath,
            encoding: 'utf8',
          }
        ).toString()
        console.log(`flutter assemble: ${result}`)
      } catch (error) {
        console.error(`flutter assemble: ${error.message}`)
      }
      // copy flutter assets && app.so
      console.log('copy flutter assets to project start')
      // 1.clean flutter assets
      const nodePath = node.getNodePath()
      const destFlutterAssetsDir = path.join(
        nodePath,
        'src',
        'main',
        'resources',
        'rawfile',
        FLUTTER_ASSETS_PATH
      )
      if (fs.existsSync(destFlutterAssetsDir)) {
        fs.rmSync(destFlutterAssetsDir, { recursive: true })
      }
      // 2.copy flutter assets
      const srcFlutterAssetsDir = path.join(
        flutterProjectPath,
        intermediateDir,
        FLUTTER_ASSETS_PATH
      )
      copyDirectory(srcFlutterAssetsDir, destFlutterAssetsDir)
      // 3.copy app.so
      const libsDir = path.join(nodePath, 'libs')
      if (fs.existsSync(libsDir)) {
        const files = listFiles(libsDir)
        for (const file of files) {
          if (path.basename(file) === 'libapp.so') {
            fs.unlinkSync(file)
          }
        }
      }
      if (buildMode !== 'debug') {
        targetPlatforms?.map(platform => PLATFORM_ARCH_MAP[platform]).forEach(arch => {
          const destAppSoPath = path.join(
            nodePath,
            'libs',
            arch,
            'libapp.so'
          )
          const srcAppSoPath = path.join(
            flutterProjectPath,
            intermediateDir,
            arch,
            'app.so'
          )
          if (!fs.existsSync(path.dirname(destAppSoPath))) {
            fs.mkdirSync(path.dirname(destAppSoPath), { recursive: true })
          }
          fs.copyFileSync(srcAppSoPath, destAppSoPath)
        })
      }
      console.log('copy flutter assets to project end')
    },
  })
}

function findFlutterPlugins(flutterPluginsDependenciesPath: string): JSON[] {
  if (!fs.existsSync(flutterPluginsDependenciesPath)) {
    return []
  }
  const fileContent = fs.readFileSync(flutterPluginsDependenciesPath, 'utf-8')
  const ohosPlugins = JSON.parse(fileContent).plugins.ohos
  const filteredPlugins =
    ohosPlugins.filter(plugin => plugin.native_build !== false)
  return filteredPlugins
}