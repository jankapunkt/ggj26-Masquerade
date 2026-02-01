# White Droppable and Ability 5 Implementation

## Overview
This document describes the implementation of the third droppable type (WHITE) and its associated ability 5 mechanic - collision damage.

## Feature Summary
- **New Droppable**: WHITE droppable (displayed as a white square with dark border)
- **Ability 5**: When activated, allows the player to inflict damage to enemies on collision for 5 seconds
- **Damage Amount**: 5000 per collision (matching the YELLOW droppable's instant damage)
- **Duration**: 5 seconds
- **Visual Feedback**: Pulsing "COLLISION DAMAGE" indicator at the top of the screen showing remaining time

## Implementation Details

### Files Modified

#### 1. scripts/droppable.gd
- Added `WHITE` to the `DroppableType` enum
- Added visual rendering for the white droppable (white square with darkened border)

```gdscript
enum DroppableType {
    YELLOW,  # Shrinks all current enemies by 5000
    ORANGE,  # Refills all gauges to maximum
    WHITE    # Activates ability 5 for 5 seconds (collision damage)
}
```

#### 2. scripts/game.gd
Added the following ability 5 system components:

**Configuration Constants:**
```gdscript
const ABILITY_5_DURATION = 5.0  # Duration in seconds
const ABILITY_5_DAMAGE = 5000   # Damage dealt on collision
var ability_5_active = false    # Whether ability 5 is currently active
var ability_5_timer = 0.0       # Time remaining for ability 5
```

**Timer Management:**
- Timer counts down in `_process()` when ability 5 is active
- Automatically deactivates when timer reaches 0

**Collision Damage:**
- Modified `check_player_collision_with()` to check if ability 5 is active
- When active, damages enemies by 5000 on collision instead of applying full drag force
- Still applies reduced drag (30% of normal) to maintain some challenge

**Droppable Spawning:**
- Updated `spawn_droppable()` to include WHITE in random selection (1 in 3 chance)

**Droppable Pickup:**
- Added handler in `_on_droppable_picked_up()` for WHITE droppable
- Activates ability 5 and sets timer to 5 seconds

#### 3. scripts/ability_ui.gd
Added visual indicator for ability 5:

**Configuration:**
```gdscript
const ABILITY_5_INDICATOR_Y = 100.0     # Position near top of screen
const ABILITY_5_FONT_SIZE = 32
const ABILITY_5_BG_PADDING = 20.0
```

**Visual Display:**
- Shows "COLLISION DAMAGE: X.Xs" text at top center of screen
- Pulsing animation using sine wave for visibility
- Red background with white border that pulses
- Automatically updates every frame when ability 5 is active

## Gameplay Mechanics

### How It Works
1. Players defeat enemies normally through shooting
2. After defeating 10-25 enemies (random), a droppable spawns
3. The droppable has a 1/3 chance of being WHITE
4. When player collects WHITE droppable:
   - Ability 5 activates for 5 seconds
   - Visual indicator appears at top of screen
   - Player can now damage enemies on collision
5. During ability 5:
   - Colliding with enemies deals 5000 damage
   - Drag force is reduced to 30% of normal
   - Timer counts down and is displayed
6. After 5 seconds:
   - Ability 5 deactivates
   - Visual indicator disappears
   - Normal collision mechanics resume

### Strategic Value
- Provides temporary offensive capability beyond shooting
- Useful for clearing multiple enemies quickly
- Reduces drag force penalty, allowing more aggressive positioning
- Limited duration encourages strategic timing
- Complements existing droppables (YELLOW for instant clear, ORANGE for gauge refill)

## Testing Recommendations

### Manual Testing Steps
1. **Spawn Verification**:
   - Play game and defeat 10-25 enemies
   - Verify white droppable spawns occasionally
   - Check visual appearance (white square with dark border)

2. **Pickup Verification**:
   - Collect white droppable
   - Verify "COLLISION DAMAGE" indicator appears
   - Check timer shows "5.0s" initially

3. **Collision Damage**:
   - While ability 5 is active, collide with enemies
   - Verify enemies shrink/die on collision
   - Check that multiple enemies can be damaged

4. **Timer Behavior**:
   - Watch timer count down from 5.0 to 0.0
   - Verify indicator disappears when timer reaches 0
   - Test that collision damage stops working after timer expires

5. **Visual Feedback**:
   - Verify pulsing animation is visible
   - Check that indicator doesn't obstruct gameplay
   - Ensure text is readable

### Edge Cases to Test
- Multiple enemy collisions during ability 5
- Enemy destruction during ability 5
- Picking up other droppables while ability 5 is active
- Game over during ability 5
- Pause/resume during ability 5

## Code Quality Notes

### Design Decisions
1. **Damage Amount**: Set to 5000 to match YELLOW droppable's instant damage, ensuring consistency
2. **Duration**: 5 seconds provides enough time to be useful without being overpowered
3. **Reduced Drag**: 30% drag maintains some challenge while allowing aggressive play
4. **Visual Position**: Top-center placement avoids obscuring player or ability UI
5. **Random Spawn**: 1/3 chance balances availability with other droppables

### Minimal Changes
- No changes to existing ability system (1-4)
- No changes to enemy behavior or properties
- No changes to player movement or shooting
- Only added new functionality, didn't modify existing features

## Integration Points

### Dependencies
- Relies on existing droppable spawn system
- Uses existing collision detection system
- Integrates with existing ability UI framework
- Compatible with existing gauge and score systems

### No Breaking Changes
- All existing droppables (YELLOW, ORANGE) work unchanged
- All existing abilities (1-4) work unchanged
- Game mechanics remain consistent
- Save/load compatibility maintained (if implemented)
