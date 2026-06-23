# CSV-tools

## Setup
should not setup or

```lua
require("csvtools").setup({
	before = 10,
	after = 10,
	clearafter = true,
	-- this will clear the highlight of buf after move
	showoverflow = true,
	-- this will provide a overflow show
	titelflow = true,
	-- add an alone title

})
```

the number should be as small as possible

Above is the default setting

## Defaut key

| command | use |
| -- | -- |
| TopWindow | open a top window to show the key of csv|
| CloseWindow | close the top window|

| key | use |
| -- | -- |
|\<leader\> td| close the topwindow ,both topwindow and csv buffer has |
|\<leader\> tf| open a new topwindow |
|\<leader\> tg| if remain the hightlight |
|\<leader\> tr| Remove overflow temporarily |

## Example

You can try the csv in example

## TODO

* Make the top line and csv shown as a table
