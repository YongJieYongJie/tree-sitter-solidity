;; --- Comments ----------------------------------------------------------------

(comment) @comment
(
 (comment) @attribute
 (#match? @attribute "^/// .*")
)

;; --- Pragma ------------------------------------------------------------------

(pragma_directive) @tag

;; --- Literals ----------------------------------------------------------------

[
 (string)
 (hex_string_literal)
 (unicode_string_literal)
 (yul_string_literal)
] @string
[
 (number_literal)
 (yul_decimal_number)
 (yul_hex_number)
] @number
[
 (true)
 (false)
] @constant.builtin

;; --- Types -------------------------------------------------------------------

(type_name (identifier) @type)
(type_name "mapping" @type)
(primitive_type) @type
(contract_declaration name: (identifier) @type)
(struct_declaration struct_name: (identifier) @type)
(struct_member name: (identifier) @field)
(enum_declaration enum_type_name: (identifier) @type)
(payable_conversion_expression "payable" @type) ; Color payable in payable address conversion as type and not as keyword
(emit_statement . (identifier) @type) ; Handles ContractA, ContractB in function foo() override(ContractA, contractB) {}
(override_specifier (identifier) @type) ; Ensures that delimiters in mapping( ... => .. ) are not colored like types
(type_name "(" @punctuation.bracket "=>" @punctuation.delimiter ")" @punctuation.bracket)

(member_expression (property_identifier) @field)
(property_identifier) @field
(struct_expression ((identifier) @field . ":"))
(enum_value) @constant

;; --- Functions and parameters ------------------------------------------------

(function_definition function_name: (identifier) @function)
(modifier_definition name: (identifier) @function)
(yul_evm_builtin) @function.builtin

; Use contructor coloring for special functions
(constructor_definition "constructor" @constructor)
(fallback_receive_definition "receive" @constructor)
(fallback_receive_definition "fallback" @constructor)

(modifier_invocation (identifier) @function.call)
(call_expression . (member_expression (property_identifier) @method.call)); Handles expressions like structVariable.g();
(call_expression . (identifier) @function.call) ; Handles expressions like g();
(function_definition function_name: (identifier) @function)
(call_expression (identifier) @field . ":") ; Handles the field in struct literals like MyStruct({MyField: MyVar * 2})

;;; Function parameters
(event_paramater name: (identifier) @variable.parameter)
(parameter name: (identifier) @variable.parameter)

;;; Yul functions
(yul_function_call function: (yul_identifier) @function.call)

;;; Yul function parameters
(yul_function_definition . (yul_identifier) @function (yul_identifier) @parameter)

;; --- Keywords ----------------------------------------------------------------

;;; Misc
[
 "pragma"
 "contract"
 "function"
 "interface"
 "library"
 "is"
 "struct"
 "enum"
 "event"
 "using"
 "assembly"
 "emit"
 "public"
 "internal"
 "private"
 "external"
 "pure"
 "view"
 "payable"
 "modifier"
 "memory"
 "storage"
 "calldata"
 "var"
 (constant)
 (virtual)
 (override_specifier)
 (yul_leave)
] @keyword

;;; Repetition-related
[
 "for"
 "while"
 "do"
] @repeat

;;; Conditional-related
[
 "break"
 "continue"
 "if"
 "else"
 "switch"
 "case"
 "default"
] @conditional

;;; Exception-related
[
 "try"
 "catch"
] @keyword

;;; Return-related
[
 "return"
 "returns"
] @keyword

;;; Import-related
"import" @keyword
(import_directive "as" @keyword)
(import_directive "from" @keyword)

(event_paramater "indexed" @keyword)
(meta_type_expression "type" @keyword)

;; --- Punctuation -------------------------------------------------------------

[
"("
")"
"["
"]"
"{"
"}"
] @punctuation.bracket
[
"."
","
] @punctuation.delimiter

;; --- Operators ---------------------------------------------------------------

[
"&&"
"||"
">>"
">>>"
"<<"
"&"
"^"
"|"
"+"
"-"
"*"
"/"
"%"
"**"
"<"
"<="
"=="
"!="
"!=="
">="
">"
"!"
"~"
"-"
"+"
"++"
"--"
] @operator

[
"delete"
"new"
] @operator

;; --- Catch-alls --------------------------------------------------------------

(identifier) @variable
(yul_identifier) @variable

