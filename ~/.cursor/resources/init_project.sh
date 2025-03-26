#!/bin/bash

# Check if a project directory is provided
if [ -z "$1" ]; then
    echo "Usage: init_project.sh <project_directory>"
    echo "Example: init_project.sh ~/Desktop/MyNewProject"
    exit 1
fi

PROJECT_DIR="$1"

# Create project directory if it doesn't exist
mkdir -p "$PROJECT_DIR"

# Copy REFERENCES.md to the project
cp ~/.cursor/resources/REFERENCES.md "$PROJECT_DIR/"

# Create a .cursor directory in the project
mkdir -p "$PROJECT_DIR/.cursor"
cp ~/.cursor/resources/REFERENCES.md "$PROJECT_DIR/.cursor/"

# Create a README.md for the project
cat > "$PROJECT_DIR/README.md" << EOL
# Project Resources

This project includes development resources and references to help with development.

## Available Resources
- \`REFERENCES.md\`: Comprehensive list of development resources
- \`.cursor/\`: Cursor-specific resources

## Usage
1. Access references through:
   - Project root: \`REFERENCES.md\`
   - Cursor resources: \`.cursor/REFERENCES.md\`

## Updating Resources
To update the resources with the latest global references:
\`\`\`bash
~/.cursor/resources/init_project.sh "\$(pwd)"
\`\`\`
EOL

echo "Project resources initialized in $PROJECT_DIR" 