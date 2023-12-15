# Trackatron

A tracker made with Godot that uses an instance of ZynAddSubFX as sound engine, and that can be controlled with a gamepad.

Loosely based on the great Dirtwave's M8.

## Motivation

- Tracker (M8)
- Good sound (ZynAddSubFX)
- Multi-platform (Godot)
- Gamepad Control (M8)
- Arch device (SteamDeck)

# Notes
## Phrase view:
### note | degree
Header can be either `N` for note or `D` for degree.
- `[*]SCALE` is set globaly but can be applied locally (`*` indicates it's local) - take SC scales
- `[D] <degree><accidental><octave>`
- `volume` 

```
PHRASE 00
SCALE *AEOLIAN
    
    D   V   I   FX1     FX2     FX3
0   0-3 64  00  ---00   ---00   ---00
1   2-- --  --  ---00   ---00   ---00
2   4-- --  --  ---00   ---00   ---00
3   --- --  --  ---00   ---00   ---00
4   --- --  --  ---00   ---00   ---00
5   --- --  --  ---00   ---00   ---00
6   --- --  --  ---00   ---00   ---00
7   --- --  --  ---00   ---00   ---00
8   --- --  --  ---00   ---00   ---00
9   --- --  --  ---00   ---00   ---00
A   --- --  --  ---00   ---00   ---00
B   --- --  --  ---00   ---00   ---00
C   --- --  --  ---00   ---00   ---00
D   --- --  --  ---00   ---00   ---00
E   --- --  --  ---00   ---00   ---00
F   --- --  --  ---00   ---00   ---00
G   --- --  --  ---00   ---00   ---00
```
