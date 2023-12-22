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
## TODO
- add headers to columns
## commands
command examples
### synth voice
- play note: `/noteOn 0 60 120`
- saw wave: `/part0/kit0/adpars/VoicePar0/OscilSmp/Pcurrentbasefunc 4`
- wave shape param: `/part0/kit0/adpars/VoicePar0/OscilSmp/Pbasefuncpar 70`

## UI
- customize `CodeEdit` as if it were ncurses.
  - separate columns by spaces
  - navigate columns with shortcuts (either `[SHIFT+]TAB` or vim modes)
- use modes:
  - `normal` to navigate
  - `insert` to edit contents
  - `visual` to select
## Phrase view:
### note | degree
Header can be either `N` for note or `D` for degree.
- `[*]SCALE` is set globaly but can be applied locally (`*` indicates it's local) - take SC scales
- `[D] <degree><accidental><octave>`
- `volume` 

```
INST 00

    
            FILTER  LFO
    AMP FQ  FQ  RES FQ  AMP
GLO --- --- --- --- --- --- --- --- 

            FILTER  LFO
    AMP FQ  FQ  RES FQ  AMP
VCE
0   ---- --- --- --- --- --- --- ---
1   ---- --- --- --- --- --- --- ---
2   ---- --- --- --- --- --- --- ---
3   ---- --- --- --- --- --- --- ---
4   ---- --- --- --- --- --- --- ---
5   ---- --- --- --- --- --- --- ---
6   ---- --- --- --- --- --- --- ---
7   ---- --- --- --- --- --- --- ---
8   ---- --- --- --- --- --- --- ---
9   ---- --- --- --- --- --- --- ---
A   ---- --- --- --- --- --- --- ---
B   ---- --- --- --- --- --- --- ---
C   ---- --- --- --- --- --- --- ---
D   ---- --- --- --- --- --- --- ---
E   ---- --- --- --- --- --- --- ---
F   ---- --- --- --- --- --- --- ---
G   ---- --- --- --- --- --- --- ---

```
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
