#!/bin/bash

# Create Cursor configuration directory if it doesn't exist
mkdir -p ~/.cursor/config

# Copy the configuration file
cp ~/.cursor/resources/cursor_config.json ~/.cursor/config/

# Create symbolic links for easy access
ln -sf ~/.cursor/resources/REFERENCES.md ~/.cursor/config/references.md
ln -sf ~/.cursor/resources/init_project.sh ~/.cursor/config/init_project.sh
ln -sf ~/.cursor/resources/setup_resources.sh ~/.cursor/config/setup_resources.sh

# Create a README for the configuration
cat > ~/.cursor/config/README.md << EOL
# CursorAI Configuration

This directory contains the configuration for CursorAI, including:
- Development resources and references
- Project initialization scripts
- Code snippets and templates

## Available Commands
- \`init_project.sh\`: Initialize a new project with development resources
- \`setup_resources.sh\`: Update global development resources

## Resources
- \`references.md\`: Comprehensive development resources
- \`cursor_config.json\`: CursorAI configuration file

## Usage
1. Initialize a new project:
   \`\`\`bash
   ~/.cursor/config/init_project.sh <project_directory>
   \`\`\`

2. Update resources:
   \`\`\`bash
   ~/.cursor/config/setup_resources.sh
   \`\`\`

## Configuration
The configuration is stored in \`cursor_config.json\` and includes:
- Resource paths
- Command definitions
- Settings for auto-initialization
EOL

echo "CursorAI configuration registered successfully!" 