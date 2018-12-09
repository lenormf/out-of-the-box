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
