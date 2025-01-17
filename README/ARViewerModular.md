## ARViewerModular API

### Introduction
ARViewerModular is a framework designed to create modular, easy to customize and extensible Augmented Reality (AR) applications.

### Main Components
1. **ARPlugin**: Extend the functionality of your application through plugins.
2. **ARMode**: Define custom scenarios for different use cases.
3. **ARManager**: Controls the AR scene and 3D objects.
4. **PluginManager**: Manages the registered plugins.
5. **PersistenceManager**: Manages the storage of configurations and states.

### Example of Use
```swift
let plugin = HighlightPlugin()
PluginManager.shared.registerPlugin(plugin)
PluginManager.shared.activatePlugin(named: “Highlight Plugin”, for: arView
```
