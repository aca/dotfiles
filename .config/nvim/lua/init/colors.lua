local colors_init = {
  DiffAdd = {
    bg = "#2e322d"
  },
  DiffAdded = {
    fg = "#76946a"
  },
  DiffChange = {
    bg = "#252535"
  },
  DiffChanged = {
    fg = "#dca561"
  },
  DiffDelete = {
    fg = "#393836"
  },
  DiffDeleted = {
    fg = "#c34043"
  },
  DiffNewFile = {
    fg = "#76946a"
  },
  DiffOldFile = {
    fg = "#c34043"
  },
  DiffRemoved = {
    fg = "#c34043"
  },
  DiffText = {
    bg = "#54546d"
  },
  ["@attribute"] = {
    link = "Constant"
  },
  ["@constructor"] = {
    fg = "#949fb5"
  },
  ["@constructor.lua"] = {
    fg = "#8992a7"
  },
  ["@exception"] = {
    bold = true,
    fg = "#c4746e"
  },
  ["@keyword.luap"] = {
    link = "@string.regex"
  },
  ["@keyword.operator"] = {
    bold = true,
    fg = "#c4746e"
  },
  ["@keyword.return"] = {
    fg = "#c4746e",
    italic = true
  },
  ["@lsp.mod.readonly"] = {
    link = "Constant"
  },
  ["@lsp.mod.typeHint"] = {
    link = "Type"
  },
  ["@lsp.type.builtinConstant"] = {
    link = "@constant.builtin"
  },
  ["@lsp.type.comment"] = {
    fg = "NONE"
  },
  ["@lsp.type.macro"] = {
    fg = "#a292a3"
  },
  ["@lsp.type.magicFunction"] = {
    link = "@function.builtin"
  },
  ["@lsp.type.method"] = {
    link = "@method"
  },
  ["@lsp.type.namespace"] = {
    link = "@namespace"
  },
  ["@lsp.type.parameter"] = {
    link = "@parameter"
  },
  ["@lsp.type.selfParameter"] = {
    link = "@variable.builtin"
  },
  ["@lsp.type.variable"] = {
    fg = "NONE"
  },
  ["@lsp.typemod.function.builtin"] = {
    link = "@function.builtin"
  },
  ["@lsp.typemod.function.defaultLibrary"] = {
    link = "@function.builtin"
  },
  ["@lsp.typemod.function.readonly"] = {
    bold = true,
    fg = "#8ba4b0"
  },
  ["@lsp.typemod.keyword.documentation"] = {
    link = "Special"
  },
  ["@lsp.typemod.method.defaultLibrary"] = {
    link = "@function.builtin"
  },
  ["@lsp.typemod.operator.controlFlow"] = {
    link = "@exception"
  },
  ["@lsp.typemod.operator.injected"] = {
    link = "Operator"
  },
  ["@lsp.typemod.string.injected"] = {
    link = "String"
  },
  ["@lsp.typemod.variable.defaultLibrary"] = {
    link = "Special"
  },
  ["@lsp.typemod.variable.global"] = {
    link = "Constant"
  },
  ["@lsp.typemod.variable.injected"] = {
    link = "@variable"
  },
  ["@lsp.typemod.variable.static"] = {
    link = "Constant"
  },
  ["@namespace"] = {
    fg = "#b6927b"
  },
  ["@operator"] = {
    link = "Operator"
  },
  ["@parameter"] = {
    fg = "#a6a69c"
  },
  ["@punctuation.bracket"] = {
    fg = "#9e9b93"
  },
  ["@punctuation.delimiter"] = {
    fg = "#9e9b93"
  },
  ["@punctuation.special"] = {
    fg = "#949fb5"
  },
  ["@string.escape"] = {
    fg = "#b6927b"
  },
  ["@string.regex"] = {
    fg = "#b6927b"
  },
  ["@symbol"] = {
    fg = "#b4b8b4"
  },
  ["@tag.attribute"] = {
    fg = "#b4b8b4"
  },
  ["@tag.delimiter"] = {
    fg = "#9e9b93"
  },
  ["@text.danger"] = {
    bg = "#e84444",
    bold = true,
    fg = "#b4b8b4"
  },
  ["@text.diff.add"] = {
    fg = "#76946a"
  },
  ["@text.diff.delete"] = {
    fg = "#c34043"
  },
  ["@text.emphasis"] = {
    italic = true
  },
  ["@text.environment"] = {
    link = "Keyword"
  },
  ["@text.environment.name"] = {
    link = "String"
  },
  ["@text.literal"] = {
    link = "String"
  },
  ["@text.math"] = {
    link = "Constant"
  },
  ["@text.note"] = {
    bg = "#6a9589",
    bold = true,
    fg = "#223249"
  },
  ["@text.quote"] = {
    link = "@parameter"
  },
  ["@text.reference.markdown_inline"] = {
    link = "htmlLink"
  },
  ["@text.strong"] = {
    bold = true
  },
  ["@text.title"] = {
    link = "Function"
  },
  ["@text.title.1.markdown"] = {
    fg = "#c4746e"
  },
  ["@text.title.1.marker.markdown"] = {
    link = "Delimiter"
  },
  ["@text.title.2.markdown"] = {
    fg = "#c4746e"
  },
  ["@text.title.2.marker.markdown"] = {
    link = "Delimiter"
  },
  ["@text.title.3.markdown"] = {
    fg = "#c4746e"
  },
  ["@text.title.3.marker.markdown"] = {
    link = "Delimiter"
  },
  ["@text.title.4.markdown"] = {
    fg = "#c4746e"
  },
  ["@text.title.4.marker.markdown"] = {
    link = "Delimiter"
  },
  ["@text.title.5.markdown"] = {
    fg = "#c4746e"
  },
  ["@text.title.5.marker.markdown"] = {
    link = "Delimiter"
  },
  ["@text.title.6.markdown"] = {
    fg = "#c4746e"
  },
  ["@text.title.6.marker.markdown"] = {
    link = "Delimiter"
  },
  ["@text.todo.checked"] = {
    fg = "#626462"
  },
  ["@text.todo.unchecked"] = {
    fg = "#c4746e"
  },
  ["@text.uri.markdown_inline"] = {
    link = "htmlString"
  },
  ["@text.warning"] = {
    bg = "#ff9e3b",
    bold = true,
    fg = "#223249"
  },
  ["@variable"] = {
    fg = "#b4b8b4"
  },
  ["@variable.builtin"] = {
    fg = "#c4746e",
    italic = true
  },
  Boolean = {
    bold = true,
    fg = "#b6927b"
  },
  Character = {
    link = "String"
  },
  ColorColumn = {
    bg = "#201d1d"
  },
  Comment = {
    fg = "#626462"
  },
  Conceal = {
    bold = true,
    fg = "#7a8382"
  },
  Constant = {
    fg = "#b6927b"
  },
  CurSearch = {
    link = "IncSearch"
  },
  Cursor = {
    bg = "#b4b8b4",
    fg = "#181616"
  },
  CursorColumn = {
    link = "CursorLine"
  },
  CursorIM = {
    link = "Cursor"
  },
  CursorLine = {
    bg = "#201d1d"
  },
  CursorLineNr = {
    bold = true,
    fg = "#a6a69c"
  },
  DebugPC = {
    bg = "#43242b"
  },
  Delimiter = {
    fg = "#9e9b93"
  },
  Directory = {
    fg = "#8ba4b0"
  },
  EndOfBuffer = {
    fg = "#181616"
  },
  Error = {
    fg = "#e84444"
  },
  ErrorMsg = {
    fg = "#e84444"
  },
  Exception = {
    fg = "#c4746e"
  },
  Float = {
    link = "Number"
  },
  FloatBorder = {
    bg = "#0d0c0c",
    fg = "#54546d"
  },
  FloatFooter = {
    bg = "#0d0c0c",
    fg = "#625e5a"
  },
  FloatTitle = {
    bg = "#0d0c0c",
    bold = true,
    fg = "#7a8382"
  },
  FoldColumn = {
    fg = "#625e5a"
  },
  Folded = {
    bg = "#201d1d",
    fg = "#716e61"
  },
  Function = {
    fg = "#8ba4b0"
  },
  GitSignsAdd = {
    fg = "#76946a"
  },
  GitSignsChange = {
    fg = "#54546d"
  },
  GitSignsDelete = {
    fg = "#d7474b"
  },
  GitSignsDeletePreview = {
    bg = "#43242b"
  },
  Identifier = {
    fg = "#b4b8b4"
  },
  Ignore = {
    link = "NonText"
  },
  IncSearch = {
    bg = "#c8ae81",
    fg = "#223249"
  },
  Keyword = {
    fg = "#8992a7"
  },
  LazyProgressTodo = {
    fg = "#625e5a"
  },
  LineNr = {
    fg = "#625e5a"
  },
  MatchParen = {
    bg = "#393836"
  },
  ModeMsg = {
    bold = true,
    fg = "#c4746e"
  },
  MoreMsg = {
    fg = "#658594"
  },
  MsgArea = {
    fg = "#b4b3a7"
  },
  MsgSeparator = {
    bg = "#0d0c0c"
  },
  NonText = {
    fg = "#625e5a"
  },
  Normal = {
    bg = "#181616",
    fg = "#b4b8b4"
  },
  NormalFloat = {
    bg = "#0d0c0c",
    fg = "#b4b3a7"
  },
  NormalNC = {
    link = "Normal"
  },
  Number = {
    fg = "#a292a3"
  },
  Operator = {
    fg = "#c4746e"
  },
  Pmenu = {
    bg = "#282727",
    fg = "#b4b3a7"
  },
  PmenuSbar = {
    bg = "#393836"
  },
  PmenuSel = {
    bg = "#393836",
    fg = "NONE"
  },
  PmenuThumb = {
    bg = "#625e5a"
  },
  PreProc = {
    fg = "#c4746e"
  },
  Question = {
    link = "MoreMsg"
  },
  QuickFixLine = {
    bg = "#282727"
  },
  Search = {
    bg = "#393836"
  },
  SignColumn = {
    fg = "#7a8382"
  },
  Special = {
    fg = "#949fb5"
  },
  SpecialKey = {
    fg = "#7a8382"
  },
  SpellBad = {
    underdashed = true
  },
  SpellCap = {
    underdashed = true
  },
  SpellLocal = {
    underdashed = true
  },
  SpellRare = {
    underdashed = true
  },
  Statement = {
    fg = "#8992a7"
  },
  StatusLine = {
    bg = "#282727",
    fg = "#b4b3a7"
  },
  StatusLineGitAdded = {
    bg = "#282727",
    fg = "#8a9a7b"
  },
  StatusLineGitChanged = {
    bg = "#282727",
    fg = "#c8ae81"
  },
  StatusLineGitRemoved = {
    bg = "#282727",
    fg = "#c4746e"
  },
  StatusLineHeader = {
    bg = "#625e5a",
    fg = "#b4b3a7"
  },
  StatusLineHeaderModified = {
    bg = "#c4746e",
    fg = "#181616"
  },
  StatusLineNC = {
    bg = "#201d1d",
    fg = "#625e5a"
  },
  String = {
    fg = "#8a9a7b"
  },
  Substitute = {
    bg = "#c34043",
    fg = "#b4b8b4"
  },
  TabLine = {
    link = "StatusLineNC"
  },
  TabLineFill = {
    link = "Normal"
  },
  TabLineSel = {
    link = "StatusLine"
  },
  TermCursor = {
    bg = "#c4746e",
    fg = "#181616"
  },
  TermCursorNC = {
    bg = "#626462",
    fg = "#181616"
  },
  Title = {
    bold = true,
    fg = "#8ba4b0"
  },
  Todo = {
    bg = "#658594",
    bold = true,
    fg = "#0d0c0c"
  },
  Type = {
    fg = "#95aeac"
  },
  Underlined = {
    fg = "#949fb5",
    underline = true
  },
  VertSplit = {
    link = "WinSeparator"
  },
  Visual = {
    bg = "#393836"
  },
  VisualNOS = {
    link = "Visual"
  },
  WarningMsg = {
    fg = "#ff9e3b"
  },
  Whitespace = {
    fg = "#393836"
  },
  WildMenu = {
    link = "Pmenu"
  },
  WinBar = {
    bg = "NONE",
    fg = "#b4b3a7"
  },
  WinBarNC = {
    link = "WinBar"
  },
  WinSeparator = {
    fg = "#393836"
  },
  bashSpecialVariables = {
    link = "Constant"
  },
  healthError = {
    fg = "#d7474b"
  },
  healthSuccess = {
    fg = "#98bb6c"
  },
  healthWarning = {
    fg = "#ff9e3b"
  },
  helpHeader = {
    link = "Title"
  },
  helpSectionDelim = {
    link = "Title"
  },
  htmlBold = {
    bold = true
  },
  htmlBoldItalic = {
    bold = true,
    italic = true
  },
  htmlH1 = {
    bold = true,
    fg = "#c4746e"
  },
  htmlH2 = {
    bold = true,
    fg = "#c4746e"
  },
  htmlH3 = {
    bold = true,
    fg = "#c4746e"
  },
  htmlH4 = {
    bold = true,
    fg = "#c4746e"
  },
  htmlH5 = {
    bold = true,
    fg = "#c4746e"
  },
  htmlH6 = {
    bold = true,
    fg = "#c4746e"
  },
  htmlItalic = {
    italic = true
  },
  htmlLink = {
    fg = "#9fb5c9",
    underline = true
  },
  htmlSpecialChar = {
    link = "SpecialChar"
  },
  htmlSpecialTagName = {
    fg = "#8992a7"
  },
  htmlString = {
    fg = "#626462"
  },
  htmlTagName = {
    link = "Tag"
  },
  htmlTitle = {
    link = "Title"
  },
  lCursor = {
    link = "Cursor"
  },
  markdownBold = {
    bold = true
  },
  markdownBoldItalic = {
    bold = true,
    italic = true
  },
  markdownCode = {
    fg = "#8a9a7b"
  },
  markdownCodeBlock = {
    fg = "#8a9a7b"
  },
  markdownError = {
    link = "NONE"
  },
  markdownEscape = {
    fg = "NONE"
  },
  markdownH1 = {
    link = "htmlH1"
  },
  markdownH2 = {
    link = "htmlH2"
  },
  markdownH3 = {
    link = "htmlH3"
  },
  markdownH4 = {
    link = "htmlH4"
  },
  markdownH5 = {
    link = "htmlH5"
  },
  markdownH6 = {
    link = "htmlH6"
  },
  markdownListMarker = {
    fg = "#dca561"
  },
  shAstQuote = {
    link = "Constant"
  },
  shCaseEsac = {
    link = "Operator"
  },
  shDeref = {
    link = "Special"
  },
  shDerefSimple = {
    link = "shDerefVar"
  },
  shDerefVar = {
    link = "Constant"
  },
  shNoQuote = {
    link = "shAstQuote"
  },
  shQuote = {
    link = "String"
  },
  shTestOpr = {
    link = "Operator"
  }
}

for hlgroup_name, hlgroup_attr in pairs(colors_init) do
  vim.api.nvim_set_hl(0, hlgroup_name, hlgroup_attr)
end

local colors_lazy = {
{
  LspCodeLens = {
    fg = "#626462"
  },
  LspInfoBorder = {
    link = "FloatBorder"
  },
  LspReferenceRead = {
    link = "LspReferenceText"
  },
  LspReferenceText = {
    bg = "#322e29"
  },
  LspReferenceWrite = {
    bg = "#322e29",
    underline = true
  },
  LspSignatureActiveParameter = {
    fg = "#ff9e3b"
  },
  qfFileName = {
    link = "Directory"
  },
  qfLineNr = {
    link = "lineNr"
  },
  fugitiveHash = {
    link = "gitHash"
  },
  fugitiveHeader = {
    link = "Title"
  },
  fugitiveStagedModifier = {
    fg = "#76946a"
  },
  fugitiveUnstagedModifier = {
    fg = "#dca561"
  },
  fugitiveUntrackedModifier = {
    fg = "#95aeac"
  },
  gitHash = {
    fg = "#626462"
  },
  DiagnosticError = {
    fg = "#c4746e"
  },
  DiagnosticHint = {
    fg = "#95aeac"
  },
  DiagnosticInfo = {
    fg = "#8ba4b0"
  },
  DiagnosticOk = {
    fg = "#8a9a7b"
  },
  DiagnosticSignError = {
    fg = "#c4746e"
  },
  DiagnosticSignHint = {
    fg = "#95aeac"
  },
  DiagnosticSignInfo = {
    fg = "#8ba4b0"
  },
  DiagnosticSignWarn = {
    fg = "#c8ae81"
  },
  DiagnosticUnderlineError = {
    sp = "#c4746e",
    undercurl = true
  },
  DiagnosticUnderlineHint = {
    sp = "#95aeac",
    undercurl = true
  },
  DiagnosticUnderlineInfo = {
    sp = "#8ba4b0",
    undercurl = true
  },
  DiagnosticUnderlineWarn = {
    sp = "#c8ae81",
    undercurl = true
  },
  DiagnosticVirtualTextError = {
    bg = "#43242b",
    fg = "#c4746e"
  },
  DiagnosticVirtualTextHint = {
    bg = "#2e322d",
    fg = "#95aeac"
  },
  DiagnosticVirtualTextInfo = {
    bg = "#252535",
    fg = "#8ba4b0"
  },
  DiagnosticVirtualTextWarn = {
    bg = "#322e29",
    fg = "#c8ae81"
  },
  DiagnosticWarn = {
    fg = "#c8ae81"
  },
  CmpCompletion = {
    link = "Pmenu"
  },
  CmpCompletionBorder = {
    bg = "#223249",
    fg = "#2d4f67"
  },
  CmpCompletionSbar = {
    link = "PmenuSbar"
  },
  CmpCompletionSel = {
    bg = "#2d4f67",
    fg = "NONE"
  },
  CmpCompletionThumb = {
    link = "PmenuThumb"
  },
  CmpDocumentation = {
    link = "NormalFloat"
  },
  CmpDocumentationBorder = {
    link = "FloatBorder"
  },
  CmpItemAbbr = {
    fg = "#a09f95"
  },
  CmpItemAbbrDeprecated = {
    fg = "#626462",
    strikethrough = true
  },
  CmpItemAbbrMatch = {
    fg = "#c4746e"
  },
  CmpItemAbbrMatchFuzzy = {
    link = "CmpItemAbbrMatch"
  },
  CmpItemKindClass = {
    link = "Type"
  },
  CmpItemKindConstant = {
    link = "Constant"
  },
  CmpItemKindConstructor = {
    link = "@constructor"
  },
  CmpItemKindCopilot = {
    link = "String"
  },
  CmpItemKindDefault = {
    fg = "#717c7c"
  },
  CmpItemKindEnum = {
    link = "Type"
  },
  CmpItemKindEnumMember = {
    link = "Constant"
  },
  CmpItemKindField = {
    link = "@field"
  },
  CmpItemKindFile = {
    link = "Directory"
  },
  CmpItemKindFolder = {
    link = "Directory"
  },
  CmpItemKindFunction = {
    link = "Function"
  },
  CmpItemKindInterface = {
    link = "Type"
  },
  CmpItemKindKeyword = {
    link = "@keyword"
  },
  CmpItemKindMethod = {
    link = "Function"
  },
  CmpItemKindModule = {
    link = "@include"
  },
  CmpItemKindOperator = {
    link = "Operator"
  },
  CmpItemKindProperty = {
    link = "@property"
  },
  CmpItemKindReference = {
    link = "Type"
  },
  CmpItemKindSnippet = {
    fg = "#949fb5"
  },
  CmpItemKindStruct = {
    link = "Type"
  },
  CmpItemKindText = {
    fg = "#a09f95"
  },
  CmpItemKindTypeParameter = {
    link = "Type"
  },
  CmpItemKindValue = {
    link = "String"
  },
  CmpItemKindVariable = {
    fg = "#d9a594"
  },
  CmpItemMenu = {
    fg = "#626462"
  },
  DapUIBreakpointsCurrentLine = {
    bold = true,
    fg = "#b4b8b4"
  },
  DapUIBreakpointsDisabledLine = {
    link = "Comment"
  },
  DapUIBreakpointsInfo = {
    fg = "#658594"
  },
  DapUIBreakpointsPath = {
    link = "Directory"
  },
  DapUIDecoration = {
    fg = "#54546d"
  },
  DapUIFloatBorder = {
    fg = "#54546d"
  },
  DapUILineNumber = {
    fg = "#949fb5"
  },
  DapUIModifiedValue = {
    bold = true,
    fg = "#949fb5"
  },
  DapUIPlayPause = {
    fg = "#8a9a7b"
  },
  DapUIRestart = {
    fg = "#8a9a7b"
  },
  DapUIScope = {
    link = "Special"
  },
  DapUISource = {
    fg = "#c4746e"
  },
  DapUIStepBack = {
    fg = "#949fb5"
  },
  DapUIStepInto = {
    fg = "#949fb5"
  },
  DapUIStepOut = {
    fg = "#949fb5"
  },
  DapUIStepOver = {
    fg = "#949fb5"
  },
  DapUIStop = {
    fg = "#d7474b"
  },
  DapUIStoppedThread = {
    fg = "#949fb5"
  },
  DapUIThread = {
    fg = "#b4b8b4"
  },
  DapUIType = {
    link = "Type"
  },
  DapUIUnavailable = {
    fg = "#626462"
  },
  DapUIWatchesEmpty = {
    fg = "#d7474b"
  },
  DapUIWatchesError = {
    fg = "#d7474b"
  },
  DapUIWatchesValue = {
    fg = "#b4b8b4"
  },
  TelescopeBorder = {
    bg = "#181616",
    fg = "#54546d"
  },
  TelescopeMatching = {
    bold = true,
    fg = "#c4746e"
  },
  TelescopeNormal = {
    bg = "#201d1d",
    fg = "#a09f95"
  },
  TelescopeResultsClass = {
    link = "Structure"
  },
  TelescopeResultsField = {
    link = "@field"
  },
  TelescopeResultsMethod = {
    link = "Function"
  },
  TelescopeResultsStruct = {
    link = "Structure"
  },
  TelescopeResultsVariable = {
    link = "@variable"
  },
  TelescopeSelection = {
    link = "Visual"
  },
  TelescopeTitle = {
    fg = "#7a8382"
  },
}
}

--
-- vim.defer_fn(function
--     for hlgroup_name, hlgroup_attr in pairs(colors_lazy) do
--       vim.api.nvim_set_hl(0, hlgroup_name, hlgroup_attr)
--     end
-- end, 50
-- )
