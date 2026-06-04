{
  config,
  pkgs,
  lib,
  ...
}:

{
  xdg = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
    enableZshIntegration = true;
  };

  home = {
    username = "devin";
    stateVersion = "21.11";
  };

  news.display = "silent";

  home.file.".lldbinit".text = ''
    settings set stop-line-count-before 20
    settings set stop-line-count-after 20
  '';

  home.file.".clang-format".text = ''
    ---
    Language:        Cpp
    # BasedOnStyle:  LLVM
    AccessModifierOffset: -2
    AlignAfterOpenBracket: Align
    AlignArrayOfStructures: None
    AlignConsecutiveMacros: None
    AlignConsecutiveAssignments: None
    AlignConsecutiveBitFields: None
    AlignConsecutiveDeclarations: None
    AlignEscapedNewlines: Right
    AlignOperands:   Align
    AlignTrailingComments: true
    AllowAllArgumentsOnNextLine: true
    AllowAllConstructorInitializersOnNextLine: true
    AllowAllParametersOfDeclarationOnNextLine: true
    AllowShortEnumsOnASingleLine: true
    AllowShortBlocksOnASingleLine: Empty
    AllowShortCaseLabelsOnASingleLine: false
    AllowShortFunctionsOnASingleLine: Empty
    AllowShortLambdasOnASingleLine: All
    AllowShortIfStatementsOnASingleLine: AllIfsAndElse
    AllowShortLoopsOnASingleLine: false
    AlwaysBreakAfterDefinitionReturnType: None
    AlwaysBreakAfterReturnType: None
    AlwaysBreakBeforeMultilineStrings: false
    AlwaysBreakTemplateDeclarations: Yes
    AttributeMacros:
      - __capability
    BinPackArguments: true
    BinPackParameters: true
    BraceWrapping:
      AfterCaseLabel:  false
      AfterClass:      false
      AfterControlStatement: Never
      AfterEnum:       false
      AfterFunction:   false
      AfterNamespace:  false
      AfterObjCDeclaration: false
      AfterStruct:     false
      AfterUnion:      false
      AfterExternBlock: false
      BeforeCatch:     false
      BeforeElse:      false
      BeforeLambdaBody: false
      BeforeWhile:     false
      IndentBraces:    false
      SplitEmptyFunction: true
      SplitEmptyRecord: true
      SplitEmptyNamespace: true
    BreakBeforeBinaryOperators: None
    BreakBeforeConceptDeclarations: true
    BreakBeforeBraces: Attach
    BreakBeforeInheritanceComma: false
    BreakInheritanceList: BeforeColon
    BreakBeforeTernaryOperators: true
    BreakConstructorInitializersBeforeComma: false
    BreakConstructorInitializers: BeforeColon
    BreakAfterJavaFieldAnnotations: false
    BreakStringLiterals: true
    ColumnLimit:     100
    CommentPragmas:  '^ IWYU pragma:'
    CompactNamespaces: false
    ConstructorInitializerAllOnOneLineOrOnePerLine: false
    ConstructorInitializerIndentWidth: 4
    ContinuationIndentWidth: 4
    Cpp11BracedListStyle: true
    DeriveLineEnding: true
    DerivePointerAlignment: false
    DisableFormat:   false
    EmptyLineAfterAccessModifier: Never
    EmptyLineBeforeAccessModifier: LogicalBlock
    ExperimentalAutoDetectBinPacking: false
    FixNamespaceComments: true
    ForEachMacros:
      - foreach
      - Q_FOREACH
      - BOOST_FOREACH
    IfMacros:
      - KJ_IF_MAYBE
    IncludeBlocks:   Preserve
    IncludeCategories:
      - Regex:           '^"(llvm|llvm-c|clang|clang-c)/'
        Priority:        2
        SortPriority:    0
        CaseSensitive:   false
      - Regex:           '^(<|"(gtest|gmock|isl|json)/)'
        Priority:        3
        SortPriority:    0
        CaseSensitive:   false
      - Regex:           '.*'
        Priority:        1
        SortPriority:    0
        CaseSensitive:   false
    IncludeIsMainRegex: '(Test)?$'
    IncludeIsMainSourceRegex: \'\'
    IndentAccessModifiers: false
    IndentCaseLabels: false
    IndentCaseBlocks: false
    IndentGotoLabels: true
    IndentPPDirectives: None
    IndentExternBlock: AfterExternBlock
    IndentRequires:  false
    IndentWidth:     4
    IndentWrappedFunctionNames: false
    InsertTrailingCommas: None
    JavaScriptQuotes: Leave
    JavaScriptWrapImports: true
    KeepEmptyLinesAtTheStartOfBlocks: true
    LambdaBodyIndentation: Signature
    MacroBlockBegin: \'\'
    MacroBlockEnd:   \'\'
    MaxEmptyLinesToKeep: 1
    NamespaceIndentation: None
    ObjCBinPackProtocolList: Auto
    ObjCBlockIndentWidth: 2
    ObjCBreakBeforeNestedBlockParam: true
    ObjCSpaceAfterProperty: false
    ObjCSpaceBeforeProtocolList: true
    PenaltyBreakAssignment: 2
    PenaltyBreakBeforeFirstCallParameter: 19
    PenaltyBreakComment: 300
    PenaltyBreakFirstLessLess: 120
    PenaltyBreakString: 1000
    PenaltyBreakTemplateDeclaration: 10
    PenaltyExcessCharacter: 1000000
    PenaltyReturnTypeOnItsOwnLine: 60
    PenaltyIndentedWhitespace: 0
    PointerAlignment: Right
    PPIndentWidth:   -1
    ReferenceAlignment: Pointer
    ReflowComments:  true
    ShortNamespaceLines: 1
    SortIncludes:    CaseSensitive
    SortJavaStaticImport: Before
    SortUsingDeclarations: true
    SpaceAfterCStyleCast: false
    SpaceAfterLogicalNot: false
    SpaceAfterTemplateKeyword: true
    SpaceBeforeAssignmentOperators: true
    SpaceBeforeCaseColon: false
    SpaceBeforeCpp11BracedList: false
    SpaceBeforeCtorInitializerColon: true
    SpaceBeforeInheritanceColon: true
    SpaceBeforeParens: ControlStatements
    SpaceAroundPointerQualifiers: Default
    SpaceBeforeRangeBasedForLoopColon: true
    SpaceInEmptyBlock: false
    SpaceInEmptyParentheses: false
    SpacesBeforeTrailingComments: 1
    SpacesInAngles:  Never
    SpacesInConditionalStatement: false
    SpacesInContainerLiterals: true
    SpacesInCStyleCastParentheses: false
    SpacesInLineCommentPrefix:
      Minimum:         1
      Maximum:         -1
    SpacesInParentheses: false
    SpacesInSquareBrackets: false
    SpaceBeforeSquareBrackets: false
    BitFieldColonSpacing: Both
    Standard:        Latest
    StatementAttributeLikeMacros:
      - Q_EMIT
    StatementMacros:
      - Q_UNUSED
      - QT_REQUIRE_VERSION
    TabWidth:        4
    UseCRLF:         false
    UseTab:          Never
    WhitespaceSensitiveMacros:
      - STRINGIZE
      - PP_STRINGIZE
      - BOOST_PP_STRINGIZE
      - NS_SWIFT_NAME
      - CF_SWIFT_NAME
    ...
  '';

  home.file.".svls.toml".text = ''
    [option]
    linter = true
  '';

  home.file.".svlint.toml".text = ''
    [option]
    prefix_inout = ""
    prefix_input = ""
    prefix_output = ""

    [textrules]
    header_copyright = false
    style_directives = true
    style_semicolon = true
    style_textwidth = false

    [syntaxrules]
    action_block_with_side_effect = true
    blocking_assignment_in_always_at_edge = true
    blocking_assignment_in_always_ff = true
    blocking_assignment_in_always_latch = true
    case_default = true
    default_nettype_none = false
    # default_nettype_wire_at_end = true
    enum_with_type = true
    eventlist_comma_always_ff = false
    eventlist_or = true
    explicit_brackets_for_confusing_precedence = true
    explicit_case_default = true
    explicit_if_else = false
    function_same_as_system_function = true
    function_with_automatic = false
    general_always_level_sensitive = true
    general_always_no_edge = true
    genvar_declaration_in_loop = true
    genvar_declaration_out_loop = true
    implicit_case_default = true
    inout_with_tri = true
    input_with_var = false
    interface_identifier_matches_filename = true
    interface_port_with_modport = true
    keyword_forbidden_always = true
    keyword_forbidden_always_comb = false
    keyword_forbidden_always_ff = false
    keyword_forbidden_always_latch = true
    keyword_forbidden_generate = false
    keyword_forbidden_logic = false
    keyword_forbidden_priority = true
    keyword_forbidden_unique = true
    keyword_forbidden_unique0 = true
    keyword_forbidden_wire_reg = true
    keyword_required_generate = true
    localparam_explicit_type = true
    localparam_type_twostate = false
    loop_statement_in_always_comb = false
    loop_statement_in_always_ff = true
    loop_statement_in_always_latch = true
    loop_variable_declaration = true
    module_ansi_forbidden = false
    module_identifier_matches_filename = true
    module_nonansi_forbidden = true
    multiline_for_begin = true
    multiline_if_begin = true
    non_blocking_assignment_in_always_comb = true
    non_blocking_assignment_in_always_no_edge = true
    operator_case_equality = true
    operator_incdec = false
    operator_self_assignment = false
    output_with_var = false
    package_identifier_matches_filename = true
    package_item_not_in_package = true
    parameter_default_value = false
    parameter_explicit_type = false
    parameter_in_generate = true
    parameter_in_package = true
    parameter_type_twostate = false
    procedural_continuous_assignment = true
    program_identifier_matches_filename = true
    sequential_block_in_always_comb = false
    sequential_block_in_always_ff = false
    sequential_block_in_always_latch = false
    unpacked_array = false
    generate_case_with_label = true
    generate_for_with_label = true
    generate_if_with_label = false
    lowercamelcase_interface = true
    lowercamelcase_module = true
    lowercamelcase_package = true
    prefix_inout = true
    prefix_input = true
    prefix_instance = false
    prefix_interface = true
    prefix_module = false
    prefix_output = true
    prefix_package = false
    re_forbidden_assert = false
    re_forbidden_assert_property = false
    re_forbidden_checker = false
    re_forbidden_class = false
    re_forbidden_function = false
    re_forbidden_generateblock = false
    re_forbidden_genvar = false
    re_forbidden_instance = false
    re_forbidden_interface = false
    re_forbidden_localparam = false
    re_forbidden_modport = false
    re_forbidden_module_ansi = false
    re_forbidden_module_nonansi = false
    re_forbidden_package = false
    re_forbidden_parameter = false
    re_forbidden_port_inout = false
    re_forbidden_port_input = false
    re_forbidden_port_interface = false
    re_forbidden_port_output = false
    re_forbidden_port_ref = false
    re_forbidden_program = false
    re_forbidden_property = false
    re_forbidden_sequence = false
    re_forbidden_task = false
    re_forbidden_var_class = false
    re_forbidden_var_classmethod = false
    re_required_assert = false
    re_required_assert_property = false
    re_required_checker = false
    re_required_class = false
    re_required_function = false
    re_required_generateblock = false
    re_required_genvar = false
    re_required_instance = false
    re_required_interface = false
    re_required_localparam = false
    re_required_modport = false
    re_required_module_ansi = false
    re_required_module_nonansi = false
    re_required_package = false
    re_required_parameter = false
    re_required_port_inout = false
    re_required_port_input = false
    re_required_port_interface = false
    re_required_port_output = false
    re_required_port_ref = false
    re_required_program = false
    re_required_property = false
    re_required_sequence = false
    re_required_task = false
    re_required_var_class = false
    re_required_var_classmethod = false
    uppercamelcase_interface = false
    uppercamelcase_module = false
    uppercamelcase_package = false
    style_commaleading = false
    style_indent = true
    style_keyword_0or1space = true
    style_keyword_0space = true
    style_keyword_1or2space = true
    style_keyword_1space = true
    style_keyword_1spaceornewline = true
    style_keyword_construct = true
    style_keyword_datatype = true
    style_keyword_end = true
    style_keyword_maybelabel = true
    style_keyword_new = true
    style_keyword_newline = true
    style_operator_arithmetic = true
    style_operator_arithmetic_leading_space = false
    style_operator_boolean = true
    style_operator_boolean_leading_space = true
    style_operator_integer = true
    style_operator_integer_leading_space = true
    style_operator_unary = true
    style_trailingwhitespace = true
    tab_character = true
  '';
}
