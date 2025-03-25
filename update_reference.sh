#!/bin/bash

# Backup the project file
cp HomeSchooApp.xcodeproj/project.pbxproj HomeSchooApp.xcodeproj/project.pbxproj.bak

# Fix the APIManager.swift reference in the project file
sed -i '' 's|path = HomeSchooApp/Utils/APIManager.swift;|path = Utils/APIManager.swift;|g' HomeSchooApp.xcodeproj/project.pbxproj

echo "Fixed APIManager.swift reference in the project file" 