# Changelog

All notable changes to this project will be documented in this file.

## [0.3.1] - 2024-03-21

### Added
- Google Sign-in integration with proper configuration
- Firebase Authentication service with email/password and Google Sign-in support
- Developer bypass option for testing
- Updated app title to "Parents Education Tracking System"

### Changed
- Updated deployment target to iOS 16.0
- Improved login form with better error handling
- Enhanced user profile management

### Fixed
- Fixed Google Sign-in configuration and URL scheme
- Resolved Firebase module integration issues

## [0.3.0] - 2024-03-21

### Added
- Firebase integration
- Navigation bar with four tabs
- User profile display
- Basic authentication flow

### Changed
- Updated project structure for better organization
- Improved UI/UX with consistent styling

### Fixed
- Various UI layout issues
- Navigation state management

## [v0.3] - 2024-03-26

### Added
- Firebase integration with GoogleService-Info.plist
- Authentication service with Firebase Auth
- Navigation bar with four main tabs:
  - Home (profile and learning compass)
  - Resources (learning materials and courses)
  - Connections (study groups and social features)
  - Progress (analytics and achievements)
- User profile display with Firebase Auth integration
- Modern UI components with system colors and shadows
- Tab-based navigation structure
- Learning progress tracking interface
- Study group and social features interface
- Resource management interface

### Changed
- Restructured project to use proper SwiftUI navigation
- Updated project configuration to include Firebase dependencies
- Moved source files to Sources directory
- Improved UI with consistent styling across all views

### Technical
- Added Firebase Core and Auth dependencies
- Configured project with XcodeGen
- Set up proper iOS deployment target and device family support
- Added necessary privacy usage descriptions in Info.plist 