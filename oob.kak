# Indent the current selection with <tab>
map global insert <tab> '<a-;>: exec -draft <gt><ret>'
# De-indent the current selection with <s-tab>
map global insert <s-tab> '<a-;>: exec -draft <lt><ret>'
