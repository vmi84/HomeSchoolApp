#!/bin/bash

# Create necessary directories if they don't exist
mkdir -p ~/.cursor/resources
mkdir -p ~/Library/Developer/Xcode/UserData/CodeSnippets
mkdir -p ~/Library/Developer/Xcode/UserData/IB\ Support
mkdir -p ~/Library/Developer/Xcode/UserData/Previews

# Copy resources to appropriate locations
cp -f ~/.cursor/resources/REFERENCES.md ~/Library/Developer/Xcode/UserData/

# Create symbolic links for easy access
ln -sf ~/.cursor/resources/REFERENCES.md ~/Desktop/REFERENCES.md

# Set up Xcode snippets directory
echo "Xcode snippets directory: ~/Library/Developer/Xcode/UserData/CodeSnippets"

# Set up Cursor resources
echo "Cursor resources directory: ~/.cursor/resources"

# Create a README file explaining the setup
cat > ~/.cursor/resources/README.md << 'EOL'
# Global Development Resources

This directory contains global resources for development tools:

## Structure
- `REFERENCES.md`: Comprehensive list of development resources
- `setup_resources.sh`: Script to set up and manage resources

## Usage
1. Run `setup_resources.sh` to update resource locations
2. Access resources through:
   - Cursor: `~/.cursor/resources/`
   - Xcode: `~/Library/Developer/Xcode/UserData/`
   - Desktop: `~/Desktop/REFERENCES.md`

## Adding New Resources
1. Add new files to `~/.cursor/resources/`
2. Run `setup_resources.sh` to update all locations
EOL

# Make the script executable
chmod +x ~/.cursor/resources/setup_resources.sh

echo "Resource setup complete!" 