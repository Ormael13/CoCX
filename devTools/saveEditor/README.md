This is a CoCX save editor.

To run it, open the HTML file in browser.

## gamedata.js

This file stores perk, item, and other libraries exported from game. You can generate this file with `[Settings] > [gamedata.js]` in the game, then overwrite the file.

## gamedata-ex.js

This file contains manually written data bindings, and patches to auto-generated data.

Things to include here:
* Flag descriptions.
* Extra perk information - do they have values1-4 and what they mean, special perks
* List of key items and their descriptions
* List of editable custom values.

### Custom values

TODO @aimozg write the description

## Credits 

Uses [Minerva](https://github.com/gmariani/minerva) Flash data parser and [Vuetify](https://vuetifyjs.com/) UI Framework.
