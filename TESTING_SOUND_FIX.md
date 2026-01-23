# Testing Sound Effect Fix

## Issue Fixed
`sfx_points` now plays only after `sfx_landing` has completed, instead of both playing simultaneously.

## How to Test

### Setup
1. Open the project in Godot Engine 4.3 or later
2. Run the game (F5 or click Play button)

### Test Case 1: Hard Drop with Line Clear
1. Play the game normally
2. Arrange pieces so that a hard drop (press Enter) will complete a line
3. Execute the hard drop
4. **Expected Result**: 
   - You should hear the landing sound (`sfx_landing`) first
   - After the landing sound completes, you should hear the points sound (`sfx_points`)
   - The sounds should NOT play simultaneously

### Test Case 2: Normal Drop with Line Clear
1. Play the game normally
2. Arrange pieces so that letting a piece fall naturally will complete a line
3. Let the piece fall and lock automatically
4. **Expected Result**: 
   - You should hear the landing sound (`sfx_landing`) first
   - After the landing sound completes, you should hear the points sound (`sfx_points`)
   - The sounds should NOT play simultaneously

### Test Case 3: Landing without Line Clear
1. Play the game normally
2. Execute a hard drop or let a piece fall that does NOT complete a line
3. **Expected Result**: 
   - You should only hear the landing sound (`sfx_landing`)
   - No points sound should play (because no lines were cleared)

### Test Case 4: Multiple Lines Cleared
1. Arrange pieces to clear multiple lines at once (2-4 lines)
2. Complete the lines with either hard drop or normal drop
3. **Expected Result**: 
   - You should hear the landing sound (`sfx_landing`) first
   - After the landing sound completes, you should hear the points sound (`sfx_points`) once
   - The sounds should sequence properly regardless of how many lines are cleared

## Code Changes Summary

### Key Changes Made:
1. **Added flag**: `should_play_points_after_landing` to track when to play points sound
2. **Signal connection**: Connected `sfx_landing.finished` signal to callback function
3. **Modified `clear_lines()`**: Sets flag instead of playing sound immediately
4. **Updated `move_down()` and `hard_drop()`**: Both now play landing sound after locking
5. **Added callback**: `_on_landing_sound_finished()` plays points sound when flag is set

### How It Works:
- When a piece lands, `sfx_landing.play()` is called
- If lines were cleared, `should_play_points_after_landing` is set to true
- When `sfx_landing` finishes playing, it triggers the `finished` signal
- The callback checks the flag and plays `sfx_points` if it's set
- This ensures sequential playback: landing sound → points sound

## Verification Checklist
- [ ] Landing sound plays when piece locks (both hard drop and normal drop)
- [ ] Points sound plays AFTER landing sound completes when lines are cleared
- [ ] Points sound does NOT play when no lines are cleared
- [ ] No simultaneous playback of landing and points sounds
- [ ] Works correctly for single line, double, triple, and tetris (4 lines)
