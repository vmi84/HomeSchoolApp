#!/bin/bash

# Close Xcode if it's still running
osascript -e 'tell application "Xcode" to quit'
sleep 2

# Make sure all directories exist
mkdir -p HomeSchooApp/Utils
mkdir -p docs

# Copy files from the cloned repository
echo "Copying ContentView.swift from repository..."
cp /tmp/HomeSchoolApp/HomeSchooApp/ContentView.swift HomeSchooApp/ContentView.swift

echo "Copying APIManager.swift from repository..."
cp /tmp/HomeSchoolApp/HomeSchooApp/Utils/APIManager.swift HomeSchooApp/Utils/APIManager.swift

echo "Copying ProfileView.swift from repository..."
cp /tmp/HomeSchoolApp/HomeSchooApp/Views/ProfileView.swift HomeSchooApp/Views/ProfileView.swift

echo "Copying ResourcesView.swift from repository..."
cp /tmp/HomeSchoolApp/HomeSchooApp/Views/ResourcesView.swift HomeSchooApp/Views/ResourcesView.swift

echo "Copying ConnectionsView.swift from repository..."
cp /tmp/HomeSchoolApp/HomeSchooApp/Views/ConnectionsView.swift HomeSchooApp/Views/ConnectionsView.swift

echo "Copying documentation files..."
cp /tmp/HomeSchoolApp/docs/AppStructure.md docs/AppStructure.md 2>/dev/null || true
cp /tmp/HomeSchoolApp/docs/DesignCollaboration.md docs/DesignCollaboration.md 2>/dev/null || true

# Install xcodeproj gem if not already installed
if ! command -v xcodeproj > /dev/null; then
  echo "Installing xcodeproj gem..."
  sudo gem install xcodeproj
fi

# Update Xcode project to include all new files
ruby -e '
require "xcodeproj"

project_path = "HomeSchooApp.xcodeproj"
project = Xcodeproj::Project.open(project_path)

# Get the main target
target = project.targets.first

# Find or create groups
home_schoo_app_group = project.main_group.find_subpath("HomeSchooApp", true)
views_group = home_schoo_app_group.find_subpath("Views", true)
utils_group = home_schoo_app_group.find_subpath("Utils", true)
docs_group = project.main_group.find_subpath("docs", true)

# Add new files
files_to_add = [
  { path: "HomeSchooApp/Utils/APIManager.swift", group: utils_group },
  { path: "docs/AppStructure.md", group: docs_group },
  { path: "docs/DesignCollaboration.md", group: docs_group }
]

# Add files that exist but are not in the project
files_to_add.each do |file_info|
  if File.exist?(file_info[:path])
    # Check if the file is already in the project
    existing_files = file_info[:group].files.select { |f| f.path == File.basename(file_info[:path]) }
    
    if existing_files.empty?
      puts "Adding #{file_info[:path]} to project..."
      file_ref = file_info[:group].new_file(file_info[:path])
      
      # Only add Swift files to build phases
      if file_info[:path].end_with?(".swift")
        target.add_file_references([file_ref])
      end
    else
      puts "#{file_info[:path]} is already in project."
    end
  else
    puts "Warning: #{file_info[:path]} does not exist."
  end
end

# Save the project
project.save
puts "Project updated successfully!"
'

# Reopen the project
echo "Opening updated Xcode project..."
open -a Xcode HomeSchooApp.xcodeproj

echo "Project structure update completed!" 