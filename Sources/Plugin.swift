import Foundation

public class Plugin: NSObject, ESDEventsProtocol {
    var connectionManager: ESDConnectionManager?;
    var knownContexts: [Any] = [];
    
    private func updateButton(withContext context: Any) {
        if DoNotDisturb.isEnabled {
            connectionManager?.setState(1, forContext: context)
        } else {
            connectionManager?.setState(0, forContext: context)
        }
    }

    public func setConnectionManager(_ connectionManager: ESDConnectionManager) {
        self.connectionManager = connectionManager;
    }
    
    public func keyDown(forAction action: String, withContext context: Any, withPayload payload: [AnyHashable : Any], forDevice deviceID: String) {
        // Nothing to do
    }
    
    public func keyUp(forAction action: String, withContext context: Any, withPayload payload: [AnyHashable : Any], forDevice deviceID: String) {
        // Nothing to do
        DoNotDisturb.isEnabled.toggle()
        updateButton(withContext: context)
    }
    
    public func willAppear(forAction action: String, withContext context: Any, withPayload payload: [AnyHashable : Any], forDevice deviceID: String) {
        // Add the context to the list of known contexts
        knownContexts.append(context)
        updateButton(withContext: context)
    }
    
    public func willDisappear(forAction action: String, withContext context: Any, withPayload payload: [AnyHashable : Any], forDevice deviceID: String) {
        // Remove the context from the list of known contexts
        knownContexts.removeAll { isEqualContext($0, context) }
    }
    public func deviceDidConnect(_ deviceID: String, withDeviceInfo deviceInfo: [AnyHashable : Any]) {
        // Nothing to do
    }
    
    public func deviceDidDisconnect(_ deviceID: String) {
        // Nothing to do
    }
    
    public func applicationDidLaunch(_ applicationInfo: [AnyHashable : Any]) {
        // Nothing to do
    }
    
    public func applicationDidTerminate(_ applicationInfo: [AnyHashable : Any]) {
        // Nothing to do
    }
}

