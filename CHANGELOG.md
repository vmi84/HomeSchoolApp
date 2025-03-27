# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.4.2] - 2024-03-21

### Added
- Persistent background color across all screens
- Scroll indicators for better navigation
- Subject progress tracking with persistence
- Interactive subject management interface

### Changed
- Improved learning style display in Home screen
- Enhanced subject card layout for better space utilization
- Updated navigation structure for better user flow
- Refined UI spacing and padding for better visual hierarchy

### Fixed
- Learning style updates now properly reflect in Home screen
- Subject progress updates now persist and display correctly
- Background color consistency across all screens
- Scroll bar visibility and functionality

### Removed
- Redundant background color declarations
- Unnecessary padding and spacing

## [0.4.1] - 2024-03-20

### Added
- Student profile section with learning style display
- Subject management in settings
- Progress tracking for subjects
- Interactive subject cards

### Changed
- Improved learning style display
- Enhanced subject list layout
- Updated background color handling
- Refined UI spacing and padding

### Fixed
- Team retention in project.yml
- Navigation bar duplication
- Background color persistence
- Subject management interface

### Removed
- Redundant quick actions
- Duplicate navigation bars

## [0.4.0] - 2024-03-19

### Added
- Learning style selection in Settings
- Subject management interface
- Progress tracking for subjects
- Interactive subject cards

### Changed
- Updated Home screen layout
- Enhanced subject list display
- Improved navigation structure
- Refined UI components

### Fixed
- Navigation bar issues
- Background color consistency
- Subject management functionality
- Progress tracking persistence

### Removed
- Redundant UI elements
- Unnecessary navigation components

## [0.3.0] - 2024-03-18

### Added
- Learning style selection
- Subject management
- Progress tracking
- Interactive UI elements

### Changed
- Updated navigation structure
- Enhanced UI components
- Improved user experience
- Refined visual design

### Fixed
- Navigation issues
- UI inconsistencies
- Performance optimizations
- Bug fixes

### Removed
- Redundant components
- Unnecessary features

## [0.2.0] - 2024-03-17

### Added
- Basic navigation structure
- Core UI components
- User authentication
- Settings management

### Changed
- Updated project structure
- Enhanced UI design
- Improved code organization
- Refined user experience

### Fixed
- Initial setup issues
- Basic functionality
- UI consistency
- Navigation flow

### Removed
- Legacy components
- Unused features

## [0.1.0] - 2024-03-16

### Added
- Initial project setup
- Basic UI components
- Project configuration
- Development environment setup

### Changed
- Project structure
- Development workflow
- Code organization
- Build configuration

### Fixed
- Initial setup
- Basic functionality
- Development environment
- Project configuration

### Removed
- Legacy code
- Unused components

## [0.3.3] - 2024-03-21

### Added
- Dark/Light mode theme selection in Settings
- Persistent settings storage using UserDefaults
- Save button in Settings screen
- Improved developer bypass functionality

### Changed
- Enhanced Settings view with appearance section
- Updated Settings view to automatically save changes
- Improved Settings view layout and organization

### Fixed
- Fixed developer bypass navigation issue
- Fixed settings persistence across app launches
- Improved error handling in authentication flow

## [0.3.2] - 2024-03-21

### Added
- New Settings screen with learning style selection
- Support for up to 10 customizable goals
- Scrollable Learning Compass view
- Custom learning style input option
- Version tracking in Settings

### Changed
- Updated tab bar icons for better visual consistency
- Improved navigation structure with Settings tab
- Enhanced Learning Compass layout with scrolling support

### Fixed
- Fixed navigation stack implementation
- Improved form validation for goal input

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