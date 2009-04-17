$args | get-member $_ | ?{ !($_.Name -match "^(get|set|add|remove)_") }
