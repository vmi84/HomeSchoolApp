# CursorAI Agent Commands

## Resource Commands

### @Web
Access web-based development resources and documentation.
```bash
# Opens REFERENCES.md in the default browser
open ~/.cursor/resources/REFERENCES.md
```

### @Resources
List all available development resources.
```bash
# Shows the contents of the resources directory
ls -la ~/.cursor/resources/
```

### @Init
Initialize a new project with development resources.
```bash
# Usage: @Init <project_directory>
~/.cursor/resources/init_project.sh "$1"
```

### @Update
Update global development resources.
```bash
# Updates all resources to their latest versions
~/.cursor/resources/setup_resources.sh
```

### @Config
Show current CursorAI configuration.
```bash
# Displays the current configuration
cat ~/.cursor/config/cursor_config.json
```

### @Help
Show available agent commands and their usage.
```bash
# Displays this help file
cat ~/.cursor/resources/agent_commands.md
```

## Resource Categories

### Swift & iOS
- Swift Documentation
- SwiftUI Documentation
- iOS Human Interface Guidelines

### Firebase
- Firebase iOS SDK
- Authentication
- Firestore
- Storage
- Realtime Database

### Development Tools
- Xcode Resources
- SwiftUI Resources
- Testing and Debugging
- Version Control

### Best Practices
- API Design Guidelines
- Style Guides
- Architecture Patterns

## Usage Examples

1. Access web resources:
```
@Web
```

2. Initialize a new project:
```
@Init ~/Desktop/MyNewProject
```

3. Update resources:
```
@Update
```

4. View configuration:
```
@Config
```

5. Get help:
```
@Help
```

## Notes
- All commands are prefixed with @
- Commands can be used in any CursorAI conversation
- Resources are automatically synchronized across projects
- Configuration can be customized in cursor_config.json 