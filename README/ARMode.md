## ARMode

### Introduction
The `ARMode` protocol allows defining specific configurations for different scenarios in AR. Modes customize the scene and adapt it to specific use cases, such as decoration, museums or games.

### Create a Custom Mode
Implements the `ARMode` protocol:

````swift
public class CustomMode: ARMode {
    public let name = “Custom Mode”
    public let description = “A custom mode for unique experiences.”

    public func configureScene(for view: ARSCNView) {
        // Configure the scene according to your needs
    }
}
````

### Activate a mode 
Use the `ModeManager` to activate modes in the application:

````swift
ModeManager.shared.activateMode(CustomMode(), for: arView)
````
