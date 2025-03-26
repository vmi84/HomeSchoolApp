import SwiftUI
import SwiftData
import Foundation
import CoreLocation
import MapKit

// Make imports available throughout the app
@_exported import struct PETS_app.AuthenticationService
@_exported import struct PETS_app.ServiceManager
@_exported import struct PETS_app.Connection

// Stub Firebase Core
#if DEBUG
enum FirebaseApp {
    static func configure() {
        print("Firebase configured (stub)")
    }
}
#endif 