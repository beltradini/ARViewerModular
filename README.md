# ARViewerModular

**ARViewerModular** is a modular and extensible framework designed to simplify the development of ARKit-based applications. The framework supports the visualization of 3D objects, integration with Vision for environment recognition, and flexibility to handle various use cases such as decoration, museums, or games.

## Features

- **Modular Plugin System**: Add or remove functionalities seamlessly.
- **Customizable AR Modes**: Adapt the AR experience to different use cases.
- **Vision Integration**: Recognize and interact with real-world environments.
- **SwiftUI Compatibility**: Extend and customize the user interface effortlessly.
- **Persistence Support**: Save and load configurations and states.

## Getting Started

### Requirements

- iOS 16.0 or later
- Xcode 15.0 or later
- Swift 5.8 or later
- ARKit and Vision frameworks enabled

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/ARViewerModular.git
   ```
2. Open the project in Xcode:
   ```bash
   cd ARViewerModular
   open ARViewerModular.xcodeproj
   ```
3. Build and run the project on a real device with ARKit support.

## Usage

### Implementing a Plugin

Create a custom plugin by conforming to the `ARPlugin` protocol:

```swift
public class HighlightPlugin: ARPlugin {
    public let name = "Highlight Plugin"
    public let description = "Highlights objects in the AR scene."

    public func activate(for view: ARSCNView) {
        // Add highlighting logic here
    }

    public func deactivate() {
        // Clean up resources
    }
}
```

Register and activate your plugin:

```swift
let plugin = HighlightPlugin()
PluginManager.shared.registerPlugin(plugin)
PluginManager.shared.activatePlugin(named: "Highlight Plugin", for: arView)
```

### Adding a New AR Mode

Define a new mode by implementing the `ARMode` protocol:

```swift
public class CustomMode: ARMode {
    public let name = "Custom Mode"
    public let description = "A unique AR experience."

    public func configureScene(for view: ARSCNView) {
        // Customize your AR scene here
    }
}
```

Activate the mode:

```swift
ModeManager.shared.activateMode(CustomMode(), for: arView)
```

## Architecture

1. **Plugin System**: Extend functionality with modular plugins.
2. **Mode Manager**: Switch between different AR scenarios seamlessly.
3. **Persistence Manager**: Save and retrieve configurations using a simple protocol.
4. **SwiftUI Integration**: Use customizable views like `ARToolbar` for interactive interfaces.

## Contributing

We welcome contributions to ARViewerModular! Please follow the steps below:

1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature/YourFeatureName
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add YourFeatureName"
   ```
4. Push to the branch:
   ```bash
   git push origin feature/YourFeatureName
   ```
5. Create a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Apple ARKit and Vision documentation.
- Inspiration from modular design patterns in iOS development.

### Next Steps

1. Add support for advanced features like multi-user AR sessions.
2. Expand the plugin and mode library to include more use cases.
3. Improve testing coverage with XCTest for plugins and modes.
