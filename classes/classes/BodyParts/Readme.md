How to work with the BodyParts-classes
======================================

Preface
-------

The `BodyParts` classes are container classes to keep multiple related propertys of complex body parts in a single class, so coders have a slightly easier job to handle them.<br>
For example many TFs reset the players skin by setting all of their values to their default value one by one. Or it could happen, that you forget to update the skinAdj when (re)setting the players Skin. This is now possible with one method call, like
```as3
// Restore everything to its default
player.rearBody.restore(false);

// Restore everything except the skintone to its default
player.skinData.restore();
```

Most methods return the object itself (`return this;`) to support method-chaining aka [fluent interface](https://en.wikipedia.org/wiki/Fluent_interface).<br>
However: In most cases, method-chaining isn't needed. So unless anyone gives me a few good examples, where method-chaining is useful, chances are that this feature is being removed in the future.

General methods
---------------

### restore()
restores the bodypart to the default (human or nonexistant)

Example:
```as3
player.neck.restore();
```

### setProps(p:Object)
sets multiple props at once. Skipped propertys are left untouched.

Example:
```as3
player.skinData.setProps({
	type: SKIN_TYPE_LIZARD_SCALES,
	adj: "",
	desc: "scales"
});
```
or put that into a single line:

```as3
player.skinData.setProps({type: SKIN_TYPE_DRAGON_SCALES, adj: "tough", desc: "shield-shaped dragon scales"});
```

Another example for BodyParts with a `skin` property:
```as3
player.rearBody.setProps({
    type: REAR_BODY_DRACONIC_MANE,
    skin: {
        type: SKIN_TYPE_DRAGON_SCALES,
        tone: player.skinData.tone,
        desc: "shield-shaped dragon scales",
        adj: "test!"
    }
});
```

### setAllProps(p:Object)
same as above, but skipped propertys are being reset to their default values

BodyParts
---------

### Skin
#### Property table
| Property   | Old (aliased)<br>Property | Access example              | Description / Examples                                                                                                       |
|------------|---------------------------|-----------------------------|------------------------------------------------------------------------------------------------------------------------------|
| `type`     | `skinType`                | `player.skinData.type`      | **The type**<br>`player.skinData.type = SKIN_TYPE_FUR;`                                                                      |
| `tone`     | `skinTone`                | `player.skinData.tone`      | **The color**<br>`player.skinData.tone = "green-yellow";`<br> → "You have **green-yellow** skin."                            |
| `desc`     | `skinDesc`                | `player.skinData.desc`      | **The description**<br>`player.skinData.desc = "dragon scales";`<br> → "You have red **dragon scales**."                     |
| `adj`      | `skinAdj`                 | `player.skinData.adj`       | **The adjective** (changed with body lotions)<br>`player.skinData.adj = "smooth";`<br> → "You have **smooth**, green scales" |
| `furColor` | `furColor`                | `player.skinData.furColor`  | **The fur color**<br>`player.skinData.furColor = "brown";`                                                                   |

#### Additional mehods
##### `public function description(noAdj:Boolean = false, noTone:Boolean = false):String`
Always returns the players skin description, even if its hidden behind fur. Setting `noAdj` to `true` skips the adjective and setting `noTone` to `true` additionally skips the skin tone.

###### Usage table:
| Example call                              |   Parser tag   | Example result                       |
|-------------------------------------------|----------------|--------------------------------------|
| `player.skinData.description()`           | `[skin]`       | "You have **smooth, green scales**." |
| `player.skinData.description(true)`       | `[skin.noadj]` | "You have **green scales**."         |
| `player.skinData.description(true, true)` | `――――――――――――` | "You have **scales**."               |


`Character.skin()` is now an alias of `BodyParts.Skin.description()`<br>
In other words (for example):
```as3
outputText(player.skin(true, true));
// is the same as calling
outputText(player.skinData.description(true, true));
```

##### public function skinFurScales():String
Moved from and aliased to `Creature.skinFurScales()`<br>
Parser tag: `[skinfurscales]` (case insensitive)

###### Example:
```as3
outputText("You have " + player.skinData.skinFurScales() + "!"); // and
outputText("You have [skinFurScales]!");
// both return: "You have soft, orange fur!"
```
Assuming that:
- `type` is set to `SKIN_TYPE_FUR`
- `adj` is set to "soft"
- `furColor` is set to "orange"
- `desc` is set to "fur"

##### public function hasFur():Boolean
Moved from and aliased to `Creature.hasFur()`<br>
Returns true if the player has fur (aka `player.skinData.type == SKIN_TYPE_FUR`). Nuff said.

#### Note
I've added the optional param `keepTone` to the methods `restore()` and `setAllProps()` which defaults to true.
Method headers:
```as3
public function restore(keepTone:Boolean = true):Skin {}
public function setAllProps(p:Object, keepTone:Boolean = true):Skin {}
```
As the params name suggests, it leaves the skintone untouched, if its been set to true which is the default.

Example:
```as3
player.skinData.restore();      // Restores all values except the skin tone
player.skinData.restore(false); // Restores all values including the skin tone
```

### UnderBody
placeholder

### RearBody
placeholder

### Neck
placeholder
