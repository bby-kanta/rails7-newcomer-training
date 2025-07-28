# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Rails Application Overview

This is a Rails 7.1.3 training application implementing a simple SNS (Social Networking Service) with the following features:
- User registration and authentication (using Devise)
- Posts creation and management
- Comments functionality
- Favorites (likes) system
- Follow/follower relationships
- User profiles and timelines

## Development Environment

### Prerequisites
- Docker and Docker Compose
- Ruby 3.2.3 (handled by Docker)
- MySQL 8.3.0 (handled by Docker)

### Essential Commands

```bash
# Start the application
docker-compose up

# Rebuild after Gemfile changes
docker-compose build --no-cache

# Run Rails console
docker-compose exec web rails console

# Run database migrations
docker-compose exec web rails db:migrate

# Access the application
# http://localhost:10530/

# Run RuboCop linting
docker-compose exec web rubocop

# Auto-fix RuboCop violations
docker-compose exec web rubocop -a
```

## Architecture and Key Components

### Models Structure
- **User**: Devise-based authentication with relationships for posts, favorites, and follow/follower associations
- **Post**: Belongs to users, has many favorites
- **Favorite**: Join table between users and posts for the "like" functionality
- **Relationship**: Self-referential join table for user follow/follower relationships

### Key Routes
- Root: `homes#index`
- Posts: RESTful resource
- Users: Custom routes for index and show
- Favorites: Create/destroy only
- Relationships: Create/destroy with custom followings/followers routes

### Frontend Stack
- Tailwind CSS for styling
- Hotwire (Turbo + Stimulus) for interactivity
- Import maps for JavaScript management

### Development Tools
- RuboCop configured with Rails and RSpec cops
- Pry for debugging
- Web console for development debugging

## Database Configuration
- Development database: `rails7_practice_development`
- MySQL port: 10531 (host) → 3306 (container)
- Web port: 10530 (host) → 3000 (container)

## Important Notes
- The application runs inside Docker containers
- All Rails commands should be prefixed with `docker-compose exec web`
- The codebase follows RuboCop style guidelines with some customizations (see .rubocop.yml)
- Authentication is handled by Devise gem