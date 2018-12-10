# Indent the current selection with <tab>
map global insert <tab> '<a-;><gt>'
# De-indent the current selection with <s-tab>
map global insert <s-tab> '<a-;><lt>'

# Allow cycling to the next/previous candidate with <tab> and <s-tab> when completing a word
hook global InsertCompletionShow .* %{
    try %{
        execute-keys -draft 'h<a-K>\h<ret>'
        map window insert <tab> <c-n>
        map window insert <s-tab> <c-p>
    }
}
hook global InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
}

# Display line numbers in all newly created windows
add-highlighter global/ number-lines

# Underline search matches in all newly created windows
add-highlighter global/ dynregex '%reg{/}' 0:+u

# Minimal set of readline mappings
map -docstring "move the cursor to the start of the line"        global insert <c-a> '<a-;>gh'
map -docstring "move the cursor to the end of the line"          global insert <c-e> '<esc>glli'
map -docstring "delete the character under the anchor"           global insert <c-d> '<a-;>c'
map -docstring "delete from the cursor to the start of the line" global insert <c-u> '<esc>h<a-h>c'
map -docstring "delete from the cursor to the end of the line"   global insert <c-k> '<esc><a-l>c'
map -docstring "delete until the next word boundary"             global insert <a-d> '<esc>ec'
map -docstring "delete until the previous word boundary"         global insert <c-w> '<esc>bc'
map -docstring "paste before the cursor"                         global insert <c-y> '<esc>Pi'

# Set of mappings to copy/paste data to/from the system clipboard
define-command -hidden oob-clipboard-copy %{
    execute-keys <a-|> %sh{
        if command -v xsel >/dev/null; then
            printf 'xsel -ib'
        elif command -v xclip >/dev/null; then
            printf 'xclip -i'
        elif command -v pbcopy >/dev/null; then
            printf 'pbcopy'
        fi
    } <ret>
}
define-command -hidden oob-clipboard-paste-before %{
    execute-keys ! %sh{
        if command -v xsel >/dev/null; then
            printf 'xsel -ob'
        elif command -v xclip >/dev/null; then
            printf 'xclip -o'
        elif command -v pbcopy >/dev/null; then
            printf 'pbpaste'
        fi
    } <ret>
}
define-command -hidden oob-clipboard-paste-after %{
    execute-keys <a-!> %sh{
        if command -v xsel >/dev/null; then
            printf 'xsel -ob'
        elif command -v xclip >/dev/null; then
            printf 'xclip -o'
        elif command -v pbcopy >/dev/null; then
            printf 'pbpaste'
        fi
    } <ret>
}
map -docstring "copy the current selection to the system clipboard" global user y ': oob-clipboard-copy<ret>'
map -docstring "paste data from the system clipboard before the selection" global user P ': oob-clipboard-paste-before<ret>'
map -docstring "paste data from the system clipboard after the selection" global user p ': oob-clipboard-paste-after<ret>'
