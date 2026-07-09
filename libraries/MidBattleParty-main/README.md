# MidBattleParty Library

This library allows you to add new party members during battle in Kristal.

## Functions

Functions are called using the Mod.libs table
```lua
Mod.libs["midbattleparty"]:functionName()
```

### `addPartyBattler(member, x, y, follower, transition, index)`
Adds a new party member during battle.

- **member**: Class name of the party member.
- **x, y**: Position of the new battler. If either is `nil`, the position will default to the standard party position.
- **follower**: A Character in the overworld to be converted into a follower. If `nil`, a follower will be created from the new party member's Actor.
- **transition**: If `true`, the battler will transition to its position with an animation. If `false`, the battler will be set instantly.
- **index**: The index of the party member in the menu. If `nil`, the member will be added to the end of the party.

**Returns:** A tuple containing the new battler and follower.

**Example:**
```lua
local battler, follower = Mod.libs["midbattleparty"]:addPartyBattler("kris", nil, nil, nil, true)
```
This adds a new Kris battler to the party, creates a new follower, and starts the transition animation.

---
### `refreshPartyPositions(positions, transition)`
Resets the positions of all party members, optionally with a transition.

- **positions**: A table of new positions for party battlers. If `nil`, defaults to standard positions.
- **transition**: If `true`, all party battlers will transition to their new positions with an animation.

**Example:**
```lua
Mod.libs["midbattleparty"]:refreshPartyPositions(nil, true)
```
This causes all PartyBattlers to transition to their default positions.