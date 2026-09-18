-- ============================================================================
-- vim-keybinds.nvim
-- lua/keybinds/init.lua
-- ============================================================================

---@alias KeymapMode
---| "n"
---| "v"
---| "x"
---| "s"
---| "o"
---| "i"
---| "c"
---| "t"

---@alias Alphabet
---| "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i"
---| "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r"
---| "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z"

---@alias Number
---| "0" | "1" | "2" | "3" | "4"
---| "5" | "6" | "7" | "8" | "9"

---@alias SpecialKey
---| "<Esc>"
---| "<CR>"
---| "<Tab>"
---| "<S-Tab>"
---| "<Space>"
---| "<BS>"
---| "<Del>"
---| "<Insert>"
---| "<Up>"
---| "<Down>"
---| "<Left>"
---| "<Right>"
---| "<Home>"
---| "<End>"
---| "<PageUp>"
---| "<PageDown>"
---| "<Cmd>"
---| "<Nop>"
---| "<Nul>"
---| "<Bar>"
---| "<LT>"

---@alias LeaderKey
---| "<leader>"
---| "<localleader>"

---@alias FunctionKey
---| "<F1>"
---| "<F2>"
---| "<F3>"
---| "<F4>"
---| "<F5>"
---| "<F6>"
---| "<F7>"
---| "<F8>"
---| "<F9>"
---| "<F10>"
---| "<F11>"
---| "<F12>"
---| "<F13>"
---| "<F14>"
---| "<F15>"
---| "<F16>"
---| "<F17>"
---| "<F18>"
---| "<F19>"
---| "<F20>"
---| "<F21>"
---| "<F22>"
---| "<F23>"
---| "<F24>"

---@alias Key Alphabet|Number|SpecialKey|LeaderKey|FunctionKey

-- ============================================================================
-- KEYBIND TYPES
-- ============================================================================

---@class Keybind
---@field mode KeymapMode|KeymapMode[]
---@field key string
---@field description string
---@field group? string

---@alias KeybindGroup table<string, Keybind>

---@class KeybindRegistry
---@field [string] KeybindGroup

-- ============================================================================
-- MODULE
-- ============================================================================

local M = {}

---@type KeybindRegistry?
local Registry

-- ============================================================================
-- MODES
-- ============================================================================

---@type table<string, KeymapMode>
M.Modes = {
  Normal = "n",
  Visual = "v",
  VisualBlock = "x",
  Select = "s",
  OperatorPending = "o",
  Insert = "i",
  Command = "c",
  Terminal = "t",
}

-- ============================================================================
-- ALPHABETS
-- ============================================================================

---@type table<string, Alphabet>
M.Alphabets = {
  A = "a",
  B = "b",
  C = "c",
  D = "d",
  E = "e",
  F = "f",
  G = "g",
  H = "h",
  I = "i",
  J = "j",
  K = "k",
  L = "l",
  M = "m",
  N = "n",
  O = "o",
  P = "p",
  Q = "q",
  R = "r",
  S = "s",
  T = "t",
  U = "u",
  V = "v",
  W = "w",
  X = "x",
  Y = "y",
  Z = "z",
}

-- ============================================================================
-- NUMBERS
-- ============================================================================

---@type table<string, Number>
M.Numbers = {
  Zero = "0",
  One = "1",
  Two = "2",
  Three = "3",
  Four = "4",
  Five = "5",
  Six = "6",
  Seven = "7",
  Eight = "8",
  Nine = "9",
}

-- ============================================================================
-- SPECIAL KEYS
-- ============================================================================

---@type table<string, SpecialKey|LeaderKey>
M.SpecialKeys = {
  Escape = "<Esc>",
  Enter = "<CR>",

  Tab = "<Tab>",
  ShiftTab = "<S-Tab>",

  Space = "<Space>",
  Backspace = "<BS>",
  Delete = "<Del>",
  Insert = "<Insert>",

  Up = "<Up>",
  Down = "<Down>",
  Left = "<Left>",
  Right = "<Right>",

  Home = "<Home>",
  End = "<End>",

  PageUp = "<PageUp>",
  PageDown = "<PageDown>",

  Command = "<Cmd>",
  Nop = "<Nop>",
  Null = "<Nul>",
  Bar = "<Bar>",
  LessThan = "<LT>",

  Leader = "<leader>",
  LocalLeader = "<localleader>",
}

-- ============================================================================
-- FUNCTION KEYS
-- ============================================================================

---@type table<string, FunctionKey>
M.FunctionKeys = {
  F1 = "<F1>",
  F2 = "<F2>",
  F3 = "<F3>",
  F4 = "<F4>",
  F5 = "<F5>",
  F6 = "<F6>",
  F7 = "<F7>",
  F8 = "<F8>",
  F9 = "<F9>",
  F10 = "<F10>",
  F11 = "<F11>",
  F12 = "<F12>",
  F13 = "<F13>",
  F14 = "<F14>",
  F15 = "<F15>",
  F16 = "<F16>",
  F17 = "<F17>",
  F18 = "<F18>",
  F19 = "<F19>",
  F20 = "<F20>",
  F21 = "<F21>",
  F22 = "<F22>",
  F23 = "<F23>",
  F24 = "<F24>",
}

M.Keys = M.SpecialKeys
M.Keys = M.Numbers
M.Keys = M.Alphabets
M.Keys = M.FunctionKeys

-- ============================================================================
-- REGISTRY
-- ============================================================================

---@return KeybindRegistry
function M.Register()
  if Registry then
    return Registry
  end

  Registry = {}

  vim.g.keymaps = Registry

  return Registry
end

-- ============================================================================
-- BIND
-- ============================================================================

---@param Mode KeymapMode|KeymapMode[]
---@param Key string
---@param Description string
---@return Keybind
function M.Bind(Mode, Key, Description)
  return {
    mode = Mode,
    key = Key,
    description = Description,
  }
end

-- ============================================================================
-- GROUP
-- ============================================================================

---@param Name string
---@param Bindings KeybindGroup
---@return KeybindGroup
function M.Group(Name, Bindings)
  assert(Registry ~= nil, "keybinds.Register() must be called first")

  Registry[Name] = Registry[Name] or {}

  for Key, Binding in pairs(Bindings) do
    Binding.group = Name
    Registry[Name][Key] = Binding
  end

  vim.g.keymaps = Registry

  return Registry[Name]
end

-- ============================================================================
-- LEADER
-- ============================================================================

---@param Key Key
---@return string
function M.Leader(Key)
  return M.Keys.Leader .. Key
end

---@param Key Key
---@return string
function M.LocalLeader(Key)
  return M.Keys.LocalLeader .. Key
end

-- ============================================================================
-- MODIFIERS
-- ============================================================================

---@param Key Key
---@return string
function M.Ctrl(Key)
  return "<C-" .. Key .. ">"
end

---@param Key Key
---@return string
function M.Alt(Key)
  return "<A-" .. Key .. ">"
end

---@param Key Key
---@return string
function M.Shift(Key)
  return "<S-" .. Key .. ">"
end

---@param Key Key
---@return string
function M.Meta(Key)
  return "<M-" .. Key .. ">"
end

---@param Key Key
---@return string
function M.Super(Key)
  return "<D-" .. Key .. ">"
end

-- ============================================================================
-- COMBINED MODIFIERS
-- ============================================================================

---@param Key Key
---@return string
function M.CtrlShift(Key)
  return "<C-S-" .. Key .. ">"
end

---@param Key Key
---@return string
function M.CtrlAlt(Key)
  return "<C-A-" .. Key .. ">"
end

---@param Key Key
---@return string
function M.CtrlMeta(Key)
  return "<C-M-" .. Key .. ">"
end

---@param Key Key
---@return string
function M.AltShift(Key)
  return "<A-S-" .. Key .. ">"
end

---@param Key Key
---@return string
function M.AltMeta(Key)
  return "<A-M-" .. Key .. ">"
end

---@param Key Key
---@return string
function M.ShiftMeta(Key)
  return "<S-M-" .. Key .. ">"
end

---@param Key Key
---@return string
function M.CtrlAltShift(Key)
  return "<C-A-S-" .. Key .. ">"
end

-- ============================================================================
-- FUNCTION KEY
-- ============================================================================

---@param Number integer
---@return FunctionKey
function M.Function(Number)
  assert(Number >= 1 and Number <= 24, "Function key must be between F1 and F24")

  ---@type FunctionKey
  return ("<F%d>"):format(Number)
end

return M
