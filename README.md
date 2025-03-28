# GoalsApp

A goal-tracking app with virtual pet companions that evolve as you achieve your goals. This app combines productivity tools with pet care mechanics to create an engaging experience that motivates users to complete their goals.

## Project Overview

GoalsApp helps users track and complete their goals while taking care of a virtual pet companion. The pet grows and evolves based on the user's goal completion rate, providing visual reinforcement for progress and achievement.

## Project Progress

- [x] Setup project folder structure for onboarding flow
- [x] Implement onboarding screen with basic welcome flow
- [x] Implement authentication screen
- [x] Implement pet selection screen with placeholder icons
- [x] Implement pet stats component and UI
- [ ] Implement pet naming screen
- [ ] Implement goal setup
- [ ] Connect onboarding flow to main app

## Detailed Features Plan

### 0. Onboarding Experience Flow [IN PROGRESS]

#### 0.1 First Launch Experience
- [x] Welcome animation with app logo and tagline
- [x] Brief app concept introduction (5-second animation)
- [ ] Permission requests (notifications, etc.) with clear explanations
- [x] Account creation options (email, Google, Apple)
- [x] Option to skip account creation (local data only)

#### 0.2 Pet Selection Journey
- [x] Character selection carousel with 3 starter pets
- [x] Pet stats display and configuration
- [x] Pet personality traits customization
- [ ] Personality quiz (3 questions) that suggests matching pet
- [ ] Pet naming screen with suggestion helper
- [ ] Pet greeting animation where pet "introduces" itself
- [ ] Personalization options for basic pet appearance

#### 0.3 Goal Setup Guidance
- [ ] Guided first goal creation with templates
- [ ] Category selection with visual explanations
- [ ] Duration selection tutorial (daily to 3-month)
- [ ] Difficulty level explanation
- [ ] Simple example completion walkthrough

#### 0.4 App Tour & Tutorial
- [ ] Interactive pet care demonstration
- [ ] Goal dashboard navigation tutorial
- [ ] Achievement system explanation
- [ ] Evolution preview teaser
- [ ] Quick tips for daily usage
- [ ] "Skip tutorial" option available throughout

#### 0.5 Engagement Hooks
- [ ] First achievement unlocked during onboarding
- [ ] First pet item gifted to demonstrate rewards
- [ ] Daily check-in schedule setup
- [ ] Optional notification preference customization
- [ ] "Invite friends" with incentive (bonus item)

#### 0.6 Finch-Style Onboarding Elements
- [ ] Conversational UI approach ("Hi, I'm [pet name]!")
- [ ] Gradual feature introduction over first 3 days
- [ ] Daily question about user's goals and motivation
- [ ] Personality-matching onboarding path
- [ ] "Adventure begins" story moment to mark completion

### 1. Core App Features [PLANNED]

#### 1.1 Goal Management System
- [ ] Create goals with title, description, deadline, difficulty level
- [ ] Support for various goal durations (daily to 3+ months)
- [ ] Multiple goal categories with visual identities
- [ ] Sub-task creation functionality
- [ ] Recurring goals and habit tracking
- [ ] Goal progress visualization
- [ ] Daily check-in reflection moments

#### 1.2 Pet Companion System
- [ ] Initial 3 pet options (puppy, kitten, baby fox)
- [ ] Pet status indicators (happiness, energy, growth)
- [ ] Daily care interactions (feed, play, train)
- [ ] Pet animations for different states and emotions
- [ ] Interactive pet responses to user actions
- [ ] Energy system and sleep cycle mechanics
- [ ] Mood tracking and pet personality development

#### 1.2.1 Pet Animation System
- [ ] Sprite sheets and individual PNGs for pet animations
- [ ] Layered animation with independent body parts
- [ ] Various animation states (idle, walking, jumping, etc.)
- [ ] Technical implementation with multiple animation types

#### 1.3 Growth & Evolution System
- [ ] Five evolution stages for pets
- [ ] Visual transformations at each stage
- [ ] Growth tied to goal completion metrics
- [ ] Multiple evolution paths based on user focus
- [ ] Special abilities and milestone celebrations
- [ ] Visual journey map of evolution progress

#### 1.4 Long-Term Goal Support
- [ ] Progress visualization for extended goals
- [ ] Milestone sub-goals for breaking down objectives
- [ ] Consistency mechanics and recovery features
- [ ] Time capsule motivational messages
- [ ] Reflection prompts and growth narratives

### 2. Reward & Progression Systems [PLANNED]

#### 2.1 Achievement System
- [ ] "Paw Points" currency from goal completion
- [ ] Achievement badges and daily streak rewards
- [ ] Collection and mastery systems
- [ ] Achievement history and display features

#### 2.2 Pet Customization
- [ ] Appearance options (colors, patterns)
- [ ] Unlockable accessories and outfits
- [ ] Special themed items and achievement rewards
- [ ] Pet home decorations and interactive objects

#### 2.3 Habitat & Environment
- [ ] Growing home base habitat
- [ ] Multiple environment themes
- [ ] Interactive elements and day/night cycle
- [ ] Weather effects and expandable areas

### 3. Social & Community Features [PLANNED]

#### 3.1 Friend System
- [ ] Friend connections and shared achievements
- [ ] Motivational interactions between users
- [ ] Collaborative goals and shared rewards
- [ ] Pet playdates and group challenges

#### 3.2 Community Hub
- [ ] "Pet Park" global community space
- [ ] Leaderboards and challenges
- [ ] Goal inspiration and sharing features
- [ ] Events and collaborative activities

#### 3.3 Sharing & Integration
- [ ] Achievement and progress sharing
- [ ] Integration with calendar and health apps
- [ ] Progress reports and journey highlights
- [ ] Web companion dashboard

### 4. Motivation & Psychology Features [PLANNED]

#### 4.1 Motivation Mechanics
- [ ] Pet-delivered encouragement
- [ ] Personalized motivation based on patterns
- [ ] Visualizations and celebratory moments
- [ ] Self-care reminders and affirmations

#### 4.2 Habit Formation Tools
- [ ] Streak tracking and consistency features
- [ ] Habit organization and templates
- [ ] Visual habit tracking through pet activities
- [ ] Specialized routine support features

#### 4.3 Psychological Support
- [ ] Growth mindset and recovery encouragement
- [ ] Mindfulness and gratitude integration
- [ ] Self-compassion for missed goals
- [ ] Progress-focused philosophy

### 5. Technical & Experience Features [PLANNED]

#### 5.1 User Experience
- [ ] Intuitive interface and onboarding
- [ ] Cross-device synchronization
- [ ] Accessibility and dark/light modes
- [ ] Home screen widget and haptic feedback

#### 5.2 Data & Analysis
- [ ] Goal statistics and productivity insights
- [ ] Visual reports and improvement suggestions
- [ ] Privacy-focused data management
- [ ] Weekly summary cards and progress calendar

#### 5.3 Monetization Elements
- [ ] Free core features with premium options
- [ ] Purchasable pet accessories and themes
- [ ] Subscription model for advanced features
- [ ] Gift options for friends

#### 5.4 Technical Foundation
- [ ] Cross-platform functionality
- [ ] Cloud synchronization with offline support
- [ ] Push notification system
- [ ] Battery and performance optimizations

## Getting Started

Clone the repository and run the following commands:

```bash
flutter pub get
flutter run
```

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
