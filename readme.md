<picture>
  <source media="(prefers-color-scheme: dark)" srcset="/docs/images/TOTEM_logo_dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="/docs/images/TOTEM_logo_bright.svg">
  <img alt="TOTEM logo font" src="/docs/images/TOTEM_logo_bright.svg">
</picture>

# ZMK CONFIG FOR THE TOTEM SPLIT KEYBOARD

[Hardware files and build guide](https://github.com/GEIGEIGEIST/totem)  
[QMK config for TOTEM](https://github.com/GEIGEIGEIST/qmk-config-totem)

TOTEM is a 38-key column-staggered split keyboard running [ZMK](https://zmk.dev/) or [QMK](https://docs.qmk.fm/), designed for SEEED XIAO BLE / RP2040.

![TOTEM layout](/docs/images/TOTEM_layout.svg)

## Repository keymap source

This README documents the active layout in:

- `/config/totem.keymap`

## Layout overview

This keymap defines 6 primary layers:

1. `BASE` – typing layer with home row mods and layer-tap thumbs
2. `NAVI` – navigation, symbols, and numpad cluster
3. `SYM` – symbols, media, and special characters
4. `ADJ` – firmware/Bluetooth/output controls + function keys
5. `TVP 1` – custom workflow layer (editing/video shortcuts)
6. `TVP 2` – secondary custom workflow layer

It also defines:

- Custom hold-tap behaviors tuned for fast typing
- Multiple combos for quick access to common keys

---

## Key behaviors used in this layout

- **Home row mod-taps**: tap for letters, hold for modifiers (Alt/GUI/Shift/Ctrl)
- **Layer-taps on thumbs**:
  - `&lt NAV TILDE` → tap `~`, hold `NAVI`
  - `&lt SYM GRAVE` → tap `` ` ``, hold `SYM`
- **Momentary adjust layer**:
  - `&mo ADJ` in `SYM` layer to access `ADJ`
- **Transparent keys (`&trans`)**: pass through to lower layer

### Hold-tap tuning (from keymap)

- Global `&mt`: tap-preferred, quick-tap enabled, 170 ms tapping term
- Dedicated behaviors (`mt_left`, `mt_right`, `mt_thumb`, `mt_shift_left`, `mt_shift_right`, `mt_all`) customize:
  - tapping term
  - quick tap
  - hold trigger behavior
  - prior idle requirements

---

## Layer reference

### `BASE` layer

### Main keys

| Left half | Right half |
|---|---|
| `Q W E R T` | `Y U I O P` |
| `A S D F G` | `H J K L ;` |
| `ESC Z X C V B` | `N M , . / '` |

### Thumb cluster

| Left thumbs | Right thumbs |
|---|---|
| `BACKSPACE` | `TAB` |
| `LT(NAV, ~)` | `LT(SYM, GRAVE)` |
| `SPACE` | `DELETE` |

### Base-layer mod-taps

- `S` hold → `LALT`
- `D` hold → `LGUI`
- `F` hold → `LSHIFT`
- `J` hold → `RSHIFT`
- `K` hold → `LGUI`
- `L` hold → `LALT`
- `ESC` hold → `LCTRL`
- `'` hold → `RCTRL`

---

### `NAVI` layer

Purpose: arrows, paging, brackets, math symbols, and right-hand numpad.

| Left half | Right half |
|---|---|
| `` ` _ ↑ + [ `` | `] 7 8 9 =` |
| `transparent ← ↓ → <` | `> 4 5 6 -` |
| `~ transparent PgUp LG(DOWN) PgDn (` | `) 1 2 3 * transparent` |
| thumbs: mostly transparent | `.` `0` `,` |

---

### `SYM` layer

Purpose: shifted symbols, media controls, brightness, and locale-specific symbols.

| Left half | Right half |
|---|---|
| `! @ # $ %` | `^ & * ' \"` |
| `RA(A) transparent transparent transparent transparent` | `MUTE PRINT_SCREEN transparent transparent RA(O)` |
| `transparent RA(F18) transparent transparent BRI- BRI+` | `VOL- VOL+ PREV NEXT \ transparent` |
| thumbs include `MO(ADJ)` | includes `PLAY/PAUSE` |

---

### `ADJ` layer

Purpose: system controls and function keys.

| Left half | Right half |
|---|---|
| `RESET BT_CLR OUT_TOG transparent transparent` | `transparent F7 F8 F9 F12` |
| `BOOTLOADER BT_NXT transparent transparent transparent` | `transparent F4 F5 F6 F11` |
| `transparent transparent BT_PRV transparent transparent transparent` | `transparent F1 F2 F3 F10 transparent` |

---

### `TVP 1` layer (custom workflow)

Purpose: custom shortcut workflow (project-specific app/macros).

Highlights from bindings:

- Includes layer switch to `TVP2` via `LT(TVP2, L)`
- Uses chords like `LC(F20)`, `LC(F19)`, `LC(F14)`, `LC(F13)`
- Provides navigation/edit keys: `LEFT`, `RIGHT`, `SPACE`, `SHIFT`, `COPY`, `PASTE`, `BSPC`

---

### `TVP 2` layer (custom workflow)

Purpose: secondary shortcut bank for the same workflow.

Highlights from bindings:

- Uses shifted and control function combos such as:
  - `LS(I)`, `LS(HOME)`, `LS(O)`, `LS(F)`
  - `LC(F17)`, `LC(F16)`, `LC(F15)`, `LC(F12)`, `LC(F11)`
- Retains function key columns (`F1`–`F12`) and transparent pass-throughs

---

## Combos

Defined in `/config/totem.keymap`:

- `combo_esc`: positions `<0 1>` → `TAB`
- `dash`: `<19 31>` → `-`
- `tilde_combo`: `<0 20>` → `~`
- `enter_combo`: `<13 12 11>` → `ENTER`
- `enter_right_combo`: `<16 18 17>` → `ENTER`
- `russian_letter_` (verbatim combo ID from keymap): `<8 9>` → `]`
- `russian_letter_x` (verbatim combo ID from keymap): `<8 7>` → `[`

Combo timings are tuned with `timeout-ms` and optional `require-prior-idle-ms` for reduced accidental triggers.

---

## Firmware build output

Workflow builds these targets (see `build.yaml`):

- `totem_left` on `seeeduino_xiao_ble`
- `totem_right` on `seeeduino_xiao_ble`
- `settings_reset` on `seeeduino_xiao_ble`

---

## How to customize this layout

1. Edit `/config/totem.keymap`
2. Push changes to your fork
3. Download firmware artifacts from GitHub Actions
4. Flash left and right halves with matching UF2 files

ZMK keycode docs: https://zmk.dev/docs/codes/
