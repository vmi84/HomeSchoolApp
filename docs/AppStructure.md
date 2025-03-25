# HomeSchooApp Structure Documentation

## Core Screens

HomeSchooApp is organized into four main tabs, each serving a specific purpose in the homeschooling management experience:

### 1. Learning Compass (Profile)

The Learning Compass serves as the personal profile and learning dashboard for students:

- **Student Profile**: Manage personal information and education level
- **Subject Tracking**: View and manage the subjects being studied
- **Learning Goals**: Set and track educational objectives
- **Learning Insights**: See statistics about learning activities and progress

### 2. Resource Nexus (Resources)

The Resource Nexus is a comprehensive hub for educational resources:

- **Featured Resources**: Highlighted educational materials
- **Resource Categories**: Browse by subject or material type
- **Khan Academy Integration**: Access curriculum resources from Khan Academy
- **Wyzant Tutoring**: Find and connect with subject-specific tutors
- **Google Maps Integration**: Discover nearby educational locations like libraries, museums, and educational centers
- **Social Insights**: View posts and discussions about specific educational resources

### 3. HomeLink (Connections)

HomeLink focuses on building community and connections for homeschooling families:

- **Learning Communities**: Join and participate in subject-specific homeschooling groups
- **Educational Events**: Find and RSVP to local educational events
- **Expert Tutors**: Connect with specialized tutors for specific subjects
- **Homeschool Social Feed**: Share experiences and insights with other homeschooling families
- **Maps Integration**: View educational events on a map

### 4. GrowEasy Analytics (Progress)

GrowEasy Analytics provides detailed tracking and insights on learning progress:

- **Progress Overview**: High-level metrics of educational progress
- **Subject Progress**: Detailed progress tracking for each subject
- **Recent Achievements**: Milestone accomplishments in the learning journey
- **Learning Insights**: AI-generated recommendations and observations to improve learning

## API Integrations

The app leverages several external APIs to enhance functionality:

### Google Maps API

- **Purpose**: Geolocation services for finding educational resources and events
- **Features**:
  - Locate nearby libraries, museums, and educational centers
  - Map view for educational events
  - Distance calculations to resources

### X API (Twitter)

- **Purpose**: Social insights for homeschooling community
- **Features**:
  - Trending educational topics
  - Sharing experiences and resources
  - Community engagement through social posts

### Khan Academy API

- **Purpose**: Access to curriculum and learning resources
- **Features**:
  - Browse courses by subject
  - Structured learning paths
  - Educational videos and exercises

### Wyzant API

- **Purpose**: Tutoring services integration
- **Features**:
  - Find qualified tutors by subject
  - Compare rates and availability
  - Direct booking with tutors

## Design and Development

### UI Framework
- The application is built using SwiftUI for a modern, fluid interface
- Consistent design language throughout with rounded corners, shadows, and clear visual hierarchy
- Tab-based navigation for straightforward access to core features

### Wireframe Design
- Figma is used for wireframe designs and prototyping
- Four main tabs correspond to the core screens described above 