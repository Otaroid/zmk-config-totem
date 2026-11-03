# TOTEM layout (from Corne)

ZMK config for a 38-key TOTEM with two XIAO BLE boards.
It is a fork of [notthebee/zmk-config-totem](https://github.com/notthebee/zmk-config-totem).
The layers come from my old Corne-ish Zen config (`Otaroid/zmk-config-formycorne`).
The home-row mods, combos and gaming layer come from notthebee.

Keymap: `config/totem.keymap`

## Base (QWERTY)

```
      Q     W     E     R     T   |   Y     U     I     O     P
      A    S/⌥   D/⌘   F/⇧    G   |   H    J/⇧   K/⌘   L/⌥    ;
Ctl/Esc Z     X     C     V     B   |   N     M     ,     .     /   Ctl/'
                BSPC  LWR/~ SPC/ADJ | ENT/ADJ RSE/` DEL
```

- `X/⇧` means tap for X, hold for Shift. The same goes for ⌥ (Alt), ⌘ (Gui) and Ctl.
- `LWR/~`: hold for NUMBER, tap for `~`.
- `RSE/``: hold for SYMBOL, tap for `` ` ``.
- `SPC/ADJ`, `ENT/ADJ`: hold either one for ADJ.

## Combos (press keys together)

| Keys                     | Output | Layer  |
|--------------------------|--------|--------|
| W + E                    | Tab    | base   |
| S + D + F                | Enter  | base   |
| J + K + L                | Enter  | base   |
| `;` + `Ctl/'`            | `-`    | base   |
| Q + `Ctl/Esc`            | `~`    | base   |
| Q + `Ctl` (bottom left)  | Tab    | gaming |

## NUMBER (hold LWR)

```
   1     2     3     4     5   |   6     7     8     9     0
   ⇧    ()=>  ⌘`    Ctl    -   |   ←     ↓     ↑     →   PgUp
F1  F2    F3    F4    F5    F6 |   F7    F8    F9   F10   F11  F12
                 .     .     .  |   .     .   PgDn
```

`()=>` types `()=>` with one key. `⌘`` switches between windows of one app.

## SYMBOL (hold RSE)

```
   !     @     #     $     %   |   ^     &     *     (     )
   `   Back   Fwd  Play  Vol+  |   -     =     [     ]     \
GAME  -     .     -   Mute  Vol- |   _     +     {     }     |     ~
                 .     .     .  |   .     .     .
```

`GAME` turns the gaming layer on.

## ADJ (hold SPC or ENT)

```
 BT0   BT1   BT2   BT3  BTclr  | Reset   -     -     -     -
ClrAll  -     -     -   Boot   | Boot    -     -   PrtSc   -
  -    -     -     -     -    USB | BLE    -     -     -     -     -
```

- `BT0`–`BT3` pick a Bluetooth profile. `BTclr` forgets the current one.
- `Boot` puts that half into flash mode.

## GAMING (toggle)

The left hand is set up for games: Q W E R P / 1 S D F 6 / Ctl 2 3 4 5 B, and the thumbs are 7, Alt and Space.
To leave, press the bottom right outer key or the right outer thumb key.

## Update the keyboard

1. Edit the keymap with `zmk code totem`.
2. Run `./update.sh`. It commits, pushes, waits for the build and flashes the left half.
   Use `./update.sh both` after `.conf` or shield changes.
3. Studio edits stay on the keyboard and cover the file. After you flash, press
   "Restore Stock Settings" in Studio to see the new keymap.

## Build and flash by hand

1. Push to GitHub. Actions builds the firmware.
2. Download `firmware.zip` from the Actions run.
3. Plug in the left half and press reset two times. A drive shows up.
4. Drag `totem_left-xiao_ble-zmk.uf2` onto the drive.
5. Do the same for the right half with `totem_right-...uf2`.

If keys act strangely after a flash, flash `settings_reset` to both halves, then flash the normal firmware again.

## ZMK version

`config/west.yml` and `.github/workflows/build.yml` pin ZMK to one commit.
To update, change that commit hash in both files at the same time.

## Editing with ZMK CLI

`zmk` is installed with pipx (Python 3.13) and points at this repo:

```
zmk code totem    # open the keymap in your editor
zmk cd            # go to this repo
zmk download      # open the latest GitHub Actions build
```
