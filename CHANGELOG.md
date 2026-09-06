# Changelog

## 1.6

## Changes

- Added a tutorial screen when the game launches to help clarify the controls (based on user feedback)
- Switched from integer to fractional scaling for those with resolutions that don't scale cleanly

## Fixes

- Fixed gamepads not being seen in the flatpak version
- Improved the platform timing on level 9
- Made the input mapping match what was displayed on the tutorial page

## 1.5.2

### Fixes

- Backported a fix from Wightwatch Keep 2 to address an issue where the player would fail to resume
the running animation if attacking while continuing to press left or right

### Changes

- Updated icon in preparation for Flathub release

### New features

- Added metadata and desktop icon in preparation for Flathub release

## 1.5.1

### Fixes

- Add missing background tile on level 25
- Stop projectiles from moving on player reaching exit
- Stop cannons from firing and enemies from attacking on player reaching exit
- Disable hitbox when enemy dies to reduce unintended player damage before explosion and coin are spawned
  - **Note:** if the player is moving towards the enemy, there may a frame where damage can still occur

## 1.5

### New features

#### Visual presentation

- Add black background to improve contrast and readability
- Add new background tiles with different contrasts to increase depth
- Add player camera with zoom to enlarge details and provide a feeling of movement
- Update main menu to match new visual look

#### Player movement

- Reduce player run speed and acceleration
- Add variable jump height (tapping versus holding the input) and increase overall player jump height

### Fixes

- Fix broken extra life sound
- Fix issue where player started prototype level with zero hearts

### Changes

- Upgrade project to Godot Engine 4.7
- Switch to full screen with integer scaling

## 1.4

### New features

- Add empty hearts to improve visibility of player health (based on player feedback)
- Add the original "1-bit dungeon" prototype level as an Easter egg!

### Fixes

- Disable enemy collision shapes sooner after death to reduce likelihood of player getting hit while explosion animation was playing

### Changes

- Prevent summoned minions from dropping coins to prevent "score cheesing"

## 1.3

### Fixes

- Fixed an issue where the neutral ending text wasn't displaying
- Fixed an issue with Level 18 where the hidden block would make it impossible for the player to jump back up if they fell off below where it dropped


## 1.2

### New features

- Add more sound effects
- Enhance the visuals of several levels

### Changes

- Set one-way collision on the wide platform variation
- Adjusted one of the secret areas to make large heart inaccessible without taking the upper path
- Make jumps a little easier in a couple places on level 17

## 1.1

### New features

- Add more sound effects
- Add a little "hop" when pressing up at the top of a ladder to assist with transitioning to adjacent platforms
- Add new movement controls (arrow keys and left joystick)
- Keep track of and save high score
- Display player score after losing all your lives or on game completion
- Add the ability to jump from the top of a ladder

### Fixes

- Fix some various animation issues
- Fix issue with picking up coins or hearts twice when you jump through them
- Fix missing characters in text

### Changes

- Remove the level skip function present in version 1.0

## 1.0

### New features

- Initial release
