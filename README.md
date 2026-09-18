# keymap-helper.nvim

A small, declarative, and type-safe keymap helper library for Neovim.

`keymap-helper.nvim` provides reusable helpers for defining Neovim keys, modes, modifiers, leaders, function keys, and grouped keybindings without repeatedly hardcoding key notation.

## Features

- Declarative keybinding definitions
- LuaLS type annotations
- Type-safe Neovim modes
- Type-safe alphabet keys
- Type-safe number keys
- Named special keys
- Leader and LocalLeader helpers
- Ctrl, Alt, Shift, Meta, and Super helpers
- Combined modifier helpers
- F1-F24 function key helpers
- Keybinding groups
- Keybinding registry
- No external dependencies
- Lightweight
- Compatible with `lazy.nvim`
- Compatible with Neovim's built-in `vim.pack`

## Requirements

- Neovim 0.11+
- LuaLS recommended for type checking

## Installation

### lazy.nvim

```lua
{
  "madhanraj-official/keymap-helper.nvim",
}
```

No `lazy = true`, `event`, `cmd`, or `ft` configuration is required.

### vim.pack

```lua
vim.pack.add({
  "https://github.com/madhanraj-official/keymap-helper.nvim",
})
```

## Usage

Require the module:

```lua
local K = require("keymap-helper")
```

Initialize the registry:

```lua
K.Register()
```

Create a keybinding group:

```lua
K.Group("File", {
  Find = K.Bind(
    K.Modes.Normal,
    K.Leader(K.Alphabets.F),
    "Find files"
  ),
})
```

The generated key is:

```text
<leader>f
```

## Modes

Neovim modes are available through `K.Modes`:

```lua
K.Modes.Normal
K.Modes.Visual
K.Modes.VisualBlock
K.Modes.Select
K.Modes.OperatorPending
K.Modes.Insert
K.Modes.Command
K.Modes.Terminal
```

The corresponding Neovim mode values are:

| Name              | Mode |
| ----------------- | ---- |
| `Normal`          | `n`  |
| `Visual`          | `v`  |
| `VisualBlock`     | `x`  |
| `Select`          | `s`  |
| `OperatorPending` | `o`  |
| `Insert`          | `i`  |
| `Command`         | `c`  |
| `Terminal`        | `t`  |

Example:

```lua
K.Bind(
  K.Modes.Normal,
  K.Leader(K.Alphabets.F),
  "Find files"
)
```

This is preferred over:

```lua
K.Bind(
  "n",
  "<leader>f",
  "Find files"
)
```

because the named mode can be checked by LuaLS.

## Multiple Modes

A keybinding can target multiple modes:

```lua
K.Bind(
  {
    K.Modes.Normal,
    K.Modes.Visual,
  },
  K.Ctrl(K.Alphabets.C),
  "Copy"
)
```

Another example:

```lua
K.Bind(
  {
    K.Modes.Normal,
    K.Modes.Visual,
    K.Modes.VisualBlock,
  },
  K.Leader(K.Alphabets.Y),
  "Yank"
)
```

You can combine any supported modes:

```lua
K.Bind(
  {
    K.Modes.Normal,
    K.Modes.Insert,
    K.Modes.Visual,
  },
  K.Keys.Escape,
  "Escape"
)
```

## Alphabet Keys

Alphabet keys are available through `K.Alphabets`:

```lua
K.Alphabets.A
K.Alphabets.B
K.Alphabets.C
K.Alphabets.D
K.Alphabets.E
K.Alphabets.F
K.Alphabets.G
K.Alphabets.H
K.Alphabets.I
K.Alphabets.J
K.Alphabets.K
K.Alphabets.L
K.Alphabets.M
K.Alphabets.N
K.Alphabets.O
K.Alphabets.P
K.Alphabets.Q
K.Alphabets.R
K.Alphabets.S
K.Alphabets.T
K.Alphabets.U
K.Alphabets.V
K.Alphabets.W
K.Alphabets.X
K.Alphabets.Y
K.Alphabets.Z
```

For example:

```lua
K.Alphabets.F
```

returns:

```text
f
```

It can be passed to a key helper:

```lua
K.Leader(K.Alphabets.F)
```

which produces:

```text
<leader>f
```

## Number Keys

Number keys are available through `K.Numbers`:

```lua
K.Numbers.Zero
K.Numbers.One
K.Numbers.Two
K.Numbers.Three
K.Numbers.Four
K.Numbers.Five
K.Numbers.Six
K.Numbers.Seven
K.Numbers.Eight
K.Numbers.Nine
```

Example:

```lua
K.Leader(K.Numbers.One)
```

produces:

```text
<leader>1
```

## Special Keys

Common special keys are available through `K.Keys`:

```lua
K.Keys.Escape
K.Keys.Enter
K.Keys.Tab
K.Keys.ShiftTab
K.Keys.Space
K.Keys.Backspace
K.Keys.Delete
K.Keys.Insert

K.Keys.Up
K.Keys.Down
K.Keys.Left
K.Keys.Right

K.Keys.Home
K.Keys.End
K.Keys.PageUp
K.Keys.PageDown

K.Keys.Command
K.Keys.Nop
K.Keys.Null
K.Keys.Bar
K.Keys.LessThan
```

Leader keys are also available:

```lua
K.Keys.Leader
K.Keys.LocalLeader
```

## Leader

Generate a leader key using:

```lua
K.Leader(K.Alphabets.F)
```

Result:

```text
<leader>f
```

Example:

```lua
K.Bind(
  K.Modes.Normal,
  K.Leader(K.Alphabets.F),
  "Find files"
)
```

You can use any supported key:

```lua
K.Leader(K.Alphabets.A)
K.Leader(K.Alphabets.B)
K.Leader(K.Numbers.One)
K.Leader(K.Keys.Space)
```

## LocalLeader

Generate a local leader key using:

```lua
K.LocalLeader(K.Alphabets.F)
```

Result:

```text
<localleader>f
```

Example:

```lua
K.Bind(
  K.Modes.Normal,
  K.LocalLeader(K.Alphabets.F),
  "Find files"
)
```

## Ctrl

Use:

```lua
K.Ctrl(K.Alphabets.C)
```

Result:

```text
<C-c>
```

Example:

```lua
K.Bind(
  K.Modes.Normal,
  K.Ctrl(K.Alphabets.S),
  "Save file"
)
```

## Alt

Use:

```lua
K.Alt(K.Alphabets.C)
```

Result:

```text
<A-c>
```

## Shift

Use:

```lua
K.Shift(K.Alphabets.C)
```

Result:

```text
<S-c>
```

## Meta

Use:

```lua
K.Meta(K.Alphabets.C)
```

Result:

```text
<M-c>
```

## Super

Use:

```lua
K.Super(K.Alphabets.C)
```

Result:

```text
<D-c>
```

## Combined Modifiers

The library provides helpers for common modifier combinations.

### Ctrl + Shift

```lua
K.CtrlShift(K.Alphabets.C)
```

Result:

```text
<C-S-c>
```

### Ctrl + Alt

```lua
K.CtrlAlt(K.Alphabets.C)
```

Result:

```text
<C-A-c>
```

### Ctrl + Meta

```lua
K.CtrlMeta(K.Alphabets.C)
```

Result:

```text
<C-M-c>
```

### Alt + Shift

```lua
K.AltShift(K.Alphabets.C)
```

Result:

```text
<A-S-c>
```

### Alt + Meta

```lua
K.AltMeta(K.Alphabets.C)
```

Result:

```text
<A-M-c>
```

### Shift + Meta

```lua
K.ShiftMeta(K.Alphabets.C)
```

Result:

```text
<S-M-c>
```

### Ctrl + Alt + Shift

```lua
K.CtrlAltShift(K.Alphabets.C)
```

Result:

```text
<C-A-S-c>
```

## Function Keys

Predefined function keys are available through `K.FunctionKeys`:

```lua
K.FunctionKeys.F1
K.FunctionKeys.F2
K.FunctionKeys.F3
K.FunctionKeys.F4
K.FunctionKeys.F5
K.FunctionKeys.F6
K.FunctionKeys.F7
K.FunctionKeys.F8
K.FunctionKeys.F9
K.FunctionKeys.F10
K.FunctionKeys.F11
K.FunctionKeys.F12
K.FunctionKeys.F13
K.FunctionKeys.F14
K.FunctionKeys.F15
K.FunctionKeys.F16
K.FunctionKeys.F17
K.FunctionKeys.F18
K.FunctionKeys.F19
K.FunctionKeys.F20
K.FunctionKeys.F21
K.FunctionKeys.F22
K.FunctionKeys.F23
K.FunctionKeys.F24
```

Dynamic function keys can be generated with:

```lua
K.Function(1)
```

Result:

```text
<F1>
```

For example:

```lua
K.Function(12)
```

produces:

```text
<F12>
```

Valid values are:

```text
1-24
```

Invalid values are rejected:

```lua
K.Function(25)
```

## Keybinding Registry

Call:

```lua
K.Register()
```

to create the registry.

The registry is returned:

```lua
local Registry = K.Register()
```

The same registry is returned on subsequent calls:

```lua
local First = K.Register()
local Second = K.Register()

assert(First == Second)
```

## Bind

Create a keybinding with:

```lua
K.Bind(
  K.Modes.Normal,
  K.Leader(K.Alphabets.F),
  "Find files"
)
```

The arguments are:

```text
Bind(mode, key, description)
```

For multiple modes:

```lua
K.Bind(
  {
    K.Modes.Normal,
    K.Modes.Visual,
  },
  K.Ctrl(K.Alphabets.C),
  "Copy"
)
```

A binding contains:

```text
mode
key
description
group
```

The `group` field is assigned automatically when the binding is added to a group.

## Groups

Create a group with:

```lua
K.Group("File", {
  Find = K.Bind(
    K.Modes.Normal,
    K.Leader(K.Alphabets.F),
    "Find files"
  ),

  Save = K.Bind(
    K.Modes.Normal,
    K.Ctrl(K.Alphabets.S),
    "Save file"
  ),
})
```

Another group:

```lua
K.Group("Window", {
  Split = K.Bind(
    K.Modes.Normal,
    K.Leader(K.Alphabets.S),
    "Split window"
  ),

  Close = K.Bind(
    K.Modes.Normal,
    K.Leader(K.Alphabets.C),
    "Close window"
  ),
})
```

Groups are stored in the registry by name.

## Complete Example

```lua
local K = require("keymap-helper")

K.Register()

K.Group("File", {
  Find = K.Bind(
    K.Modes.Normal,
    K.Leader(K.Alphabets.F),
    "Find files"
  ),

  Save = K.Bind(
    K.Modes.Normal,
    K.Ctrl(K.Alphabets.S),
    "Save file"
  ),
})

K.Group("Navigation", {
  Next = K.Bind(
    {
      K.Modes.Normal,
      K.Modes.Visual,
    },
    K.Ctrl(K.Alphabets.N),
    "Next item"
  ),

  Previous = K.Bind(
    {
      K.Modes.Normal,
      K.Modes.Visual,
    },
    K.Ctrl(K.Alphabets.P),
    "Previous item"
  ),
})

K.Group("Window", {
  Split = K.Bind(
    K.Modes.Normal,
    K.Leader(K.Alphabets.S),
    "Split window"
  ),

  Close = K.Bind(
    K.Modes.Normal,
    K.Leader(K.Alphabets.C),
    "Close window"
  ),
})
```

## Type Safety

The library uses LuaLS annotations for type checking.

Modes are defined as:

```lua
---@alias KeymapMode
---| "n"
---| "v"
---| "x"
---| "s"
---| "o"
---| "i"
---| "c"
---| "t"
```

Therefore:

```lua
K.Modes.Normal
```

has the value:

```text
n
```

and:

```lua
K.Modes.Visual
```

has the value:

```text
v
```

Named constants make configuration easier to read while allowing LuaLS to understand the expected types.

## API Reference

### Registry

| API            | Description                                |
| -------------- | ------------------------------------------ |
| `K.Register()` | Creates or returns the keybinding registry |
| `K.Bind()`     | Creates a keybinding                       |
| `K.Group()`    | Adds bindings to a named group             |

### Modes

| API                       | Value |
| ------------------------- | ----- |
| `K.Modes.Normal`          | `n`   |
| `K.Modes.Visual`          | `v`   |
| `K.Modes.VisualBlock`     | `x`   |
| `K.Modes.Select`          | `s`   |
| `K.Modes.OperatorPending` | `o`   |
| `K.Modes.Insert`          | `i`   |
| `K.Modes.Command`         | `c`   |
| `K.Modes.Terminal`        | `t`   |

### Key Collections

| API              | Description  |
| ---------------- | ------------ |
| `K.Alphabets`    | A-Z          |
| `K.Numbers`      | 0-9          |
| `K.Keys`         | Special keys |
| `K.FunctionKeys` | F1-F24       |

### Key Generators

| API                   | Description                  |
| --------------------- | ---------------------------- |
| `K.Leader(Key)`       | Generates `<leader>Key`      |
| `K.LocalLeader(Key)`  | Generates `<localleader>Key` |
| `K.Ctrl(Key)`         | Generates `<C-Key>`          |
| `K.Alt(Key)`          | Generates `<A-Key>`          |
| `K.Shift(Key)`        | Generates `<S-Key>`          |
| `K.Meta(Key)`         | Generates `<M-Key>`          |
| `K.Super(Key)`        | Generates `<D-Key>`          |
| `K.CtrlShift(Key)`    | Generates `<C-S-Key>`        |
| `K.CtrlAlt(Key)`      | Generates `<C-A-Key>`        |
| `K.CtrlMeta(Key)`     | Generates `<C-M-Key>`        |
| `K.AltShift(Key)`     | Generates `<A-S-Key>`        |
| `K.AltMeta(Key)`      | Generates `<A-M-Key>`        |
| `K.ShiftMeta(Key)`    | Generates `<S-M-Key>`        |
| `K.CtrlAltShift(Key)` | Generates `<C-A-S-Key>`      |
| `K.Function(Number)`  | Generates F1-F24             |

## Project Structure

```text
keymap-helper.nvim/
├── doc/
│   └── keybinds.txt
├── LICENSE
├── lua/
│   └── keymap-helper/
│       └── init.lua
├── plugin/
│   └── keymap-helper.lua
└── README.md
```

## Documentation

Inside Neovim:

```vim
:help keybinds
```

## License

MIT License.

See [LICENSE](LICENSE) for details.

## Author

madhanraj-official

Repository:

https://github.com/madhanraj-official/keymap-helper.nvim
