# Character Viewer

## Overview

TODO

#### Accessing in game

It is rendered under \[Appearance\]. Depending on the mod it's enabled:
* (Xianxia) In \[Main Menu\] &gt; \[Settings\]
* (Revamp) In debug builds only

In debug mode setting on, external resources are reloaded every time you click \[Appearance\] ()so you can preview changes without restarting).

Also available in Body Part Editor (`D` `E` `B` `U` `G` &gt; \[Hack Stuff\] &gt; \[Body Part Editor\]).

## Contributing

#### Sprite editor (spred)

Located in `devTools/spred/spred.html` (open file in browser).

Used to test adjust sprite positions, body part combinations, colors.

On each character buttons are: zoom in/out, show layers, show colors

### Editing existing parts

To edit existing body part images, just edit corresponding spritemap image file and preview in game or **spred**.

To re-position body parts, open them in **spred**, select layer in the list, and drag around with mouse.
Save by clicking **"Save spritemaps"**, then **"Copy"** button (near **"Close"**). Select all `<spritemap>` tags in `model.xml` and Ctrl+V (replace with clipboard).

If the existing bounding box is too small, you have to reposition it somewhere and put new values in spritemap (see **Adding new parts**).

### Adding/editing colors

Textual colors, like "**fair** skin" are mapped to RGB colors through palette\[s\].
There can be many of them to have different colors for "**red** *hair*", and "**red** (*everything else*)".

Then these colors are used in sprites, replacing *key colors* (see `basic.png`, bottom right corner). 

1. If adding new color, add a `<color name="newname">#RRGGBB</color>` line in the `<common>` or specific palette.
2. Open **spred**. Add that color to some preview characters.
3. Select it in the list to the right and adjust HSL values.
4. Click **Save palettes**, then **Copy** button. Select whole `<palette>` tag in `model.xml` and Ctrl+V. 

### Adding new parts

1. Draw it on existing or new spritemap file. If you add a new image file, you have to add a `<spritemap file="path">` tag to it. 
    1) if you're doing a close variation of existing body part, copy it and re-draw.
    2) if it doesn't fit bounding box of existing body part or is very different, just draw it anywhere and add a box.
2. Write down the bounding box coordinates. In Paint.NET this can be done by selecting its contents (with magic wand on transparent space or rectangular select tool) and using the coordinates in bottom status bar. 
3. Add a `<cell rect="dx,dy,width,height" name="layer/variation" dx="0" dy="0"/>` line in `model.xml`. If copying existing bounding box, use its **width**, **height**, **dx**, **dy**.
    
    Also if you add a new layer, you need to add a `<layer name="layer"/>` tag under `<layers>` to set between which layers it is rendered.
4. Reload the **spred**. Add that body part to some chars, and adjust its position. This might be optional for existing bounding box if the place of attachment is the same.
5. When it looks good (and you did any changes), click **"Save spritemaps"**, then **"Copy"**. Select all `<spritemap>` tags in `model.xml` and Ctrl+V.


### Editing layer selection logic 

TODO

### Editing key color logic

TODO

## Implementation details

### Initialization:

1. Body parts are cut from files according to `<spritemap>` definitions.
2. Expressions in `<palette>/<property src="...">` and `<logic>/...` are compiled.

### Rendering

1. `<logic>` is evaluated with the `game.player` as a context. The `<show>` and `<hide>` statements that are executed determine set of visible parts.
2. For every `<palette>/<property>`: 
    1. Its `src` is evaluated with `game.player` as a context.
    2. The resulting value is mapped to RGB color through its own palette (`<palette>/<property>/<color>`), if not found, through the `<palette>/<common>` palette.
    3. The resulting RGB is saved under its `name`.
3. For every `<colorkeys>/<key>`:
    1. A corresponding (by `key.base = property.name`) palette property is found; its RGB value will be used.
    2. If `transform` is present, it is applied to the color value.
    3. The mapping from `key.src` RGB color to transformed RGB color is saved.
4. Each visible layer undergoes color replacement (key colors replaced with actual colors).
5. Resulting layers are blended according to their order in `<layers>`  

### Accessing in code

TODO