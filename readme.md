# Project

## How to Run

- Download lua at <https://www.lua.org/download.html>
- Download Love2D at <https://love2d.org/>
- run love with the project folder

### On macos after installing love and lua from home-brew

``` bash
    love project_folder
```

## Features

- [x] Add Player
- [x] Add Damage Animation
- [x] Add Attack Target
- [x] Separate logic (Entities, components, systems and world)
- [x] Add Attack Functionality
- [x] Implement a better collision system with lib
- [x] Add enemy
- [x] HealthManagerComponent
- [x] Add Camera
- [X] Add Skills
- [ ] Hud with Skills and cooldowns
- [ ] Animated Sprites to player
- [ ] Add map with collidable tiles
- [ ] Add Attack Animation
- [ ] Effects
- [ ] Different Monsters and behaviors
- [ ] Character classes
- [ ] Loot system
- [ ] Items and Equipments

## Refactoring

- Refactor MapLoader (store map colliders)
- Add more skills

- hitsplashes and renderHealthBar to be animations?

## Now on

- Add the hud the hud and show skills and cooldowns...
- Also, setup global cooldowns
- Add Skills as a parameter and pass the player and the targets to calculate effect, or deploy a damage area or a bullet
