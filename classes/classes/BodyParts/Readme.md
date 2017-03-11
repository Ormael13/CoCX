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
player.skin.restore();
```

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
player.skin.setProps({
	type: SKIN_TYPE_LIZARD_SCALES,
	adj: "",
	desc: "scales"
});
```
or put that into a single line:

```as3
player.skin.setProps({type: SKIN_TYPE_DRAGON_SCALES, adj: "tough", desc: "shield-shaped dragon scales"});
```

Another example for BodyParts with a `skin` property:
```as3
player.rearBody.setProps({
    type: REAR_BODY_DRACONIC_MANE,
    skin: {
        type: SKIN_TYPE_DRAGON_SCALES,
        tone: player.skin.tone,
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
| Property   | Old (aliased)<br>Property | Access example          | Description / Examples                                                                                                   |
|------------|---------------------------|-------------------------|--------------------------------------------------------------------------------------------------------------------------|
| `type`     | `skinType`                | `player.skin.type`      | **The type**<br>`player.skin.type = SKIN_TYPE_FUR;`                                                                      |
| `tone`     | `skinTone`                | `player.skin.tone`      | **The color**<br>`player.skin.tone = "green-yellow";`<br> → "You have **green-yellow** skin."                            |
| `desc`     | `skinDesc`                | `player.skin.desc`      | **The description**<br>`player.skin.desc = "dragon scales";`<br> → "You have red **dragon scales**."                     |
| `adj`      | `skinAdj`                 | `player.skin.adj`       | **The adjective** (changed with body lotions)<br>`player.skin.adj = "smooth";`<br> → "You have **smooth**, green scales" |
| `furColor` | `furColor`                | `player.skin.furColor`  | **The fur color**<br>`player.skin.furColor = "brown";`                                                                   |

#### Additional mehods
##### public function description(noAdj:Boolean = false, noTone:Boolean = false):String
Always returns the players skin description, even if its hidden behind fur. Setting `noAdj` to `true` skips the adjective and setting `noTone` to `true` additionally skips the skin tone.

###### Usage table:
| Example call                          |   Parser tag   | Example result                       |
|---------------------------------------|----------------|--------------------------------------|
| `player.skin.description()`           | `[skin]`       | "You have **smooth, green scales**." |
| `player.skin.description(true)`       | `[skin.noadj]` | "You have **green scales**."         |
| `player.skin.description(true, true)` | `――――――――――――` | "You have **scales**."               |


`Character.skin()` has been refactored and moved to `Creature.skinDescript()` and is now an alias of `BodyParts.Skin.description()`<br>
In other words (for example):
```as3
outputText(player.skinDescript(true, true));
// is the same as calling
outputText(player.skin.description(true, true));
```

##### public function skinFurScales():String
Moved from and aliased to `Creature.skinFurScales()`<br>
Parser tag: `[skinfurscales]` (case insensitive)

###### Example:
```as3
outputText("You have " + player.skin.skinFurScales() + "!"); // and
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
Returns true if the player has fur (aka `player.skin.type == SKIN_TYPE_FUR`). Nuff said.

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
player.skin.restore();      // Restores all values except the skin tone
player.skin.restore(false); // Restores all values including the skin tone
```

### UnderBody
#### Property table
| Property | Access example          | Description / Examples                                                 |
|----------|-------------------------|------------------------------------------------------------------------|
| `type`   | `player.underBody.type` | **The type**<br>`player.underBody.type = UNDER_BODY_TYPE_DRAGON;`      |
| `skin`   | `player.underBody.skin` | **The skin on the underbody**<br>`player.underBody.skin = new Skin();` |

#### Additional methods
##### skinDescription
Alias of `skin.description()` (Same as above, but for the skin on the underbody)

##### skinFurScales
Alias of `skin.skinFurScales()` (Same as above, but for the skin on the underbody)

Parser tag: `[underbody.skinfurscales]` (case insensitive)

#### Examples
##### From lizard scales TF:
```as3
player.skin.setProps({
	type: SKIN_TYPE_LIZARD_SCALES,
	adj: "",
	desc: "scales"
});
player.underBody.type = UNDER_BODY_TYPE_LIZARD;
player.underBody.skin.setProps(player.skin); // copy the main skin props to the underBody skin ...
player.underBody.skin.desc = "ventral scales";   // ... and only override the desc
```

##### Another example:
Let's say, we intend to have some kind of turtle girl TF in CoC, the TF code *could* go this way (Not suggesting anything here, its just an example!):

```as3
// First step: The player grows lizard scales on his/her skin and/or underbody
if ((!player.hasLizardScales() || [UNDER_BODY_TYPE_LIZARD, UNDER_BODY_TYPE_TURTLE].indexOf(player.underBody.type) == -1) && player.lowerBody == LOWER_BODY_TYPE_TURTLE /* && ... */) {
	outputText("... You grow " + player.skin.tone + " scales on your skin!");
	player.skin.setProps({
		type: SKIN_TYPE_LIZARD_SCALES,
		adj: "",
		desc: "scales"
	});
	player.underBody.type = UNDER_BODY_TYPE_LIZARD;
	player.underBody.skin.setProps(player.skin); // copy the main skin props to the underBody skin ...
	player.underBody.skin.desc = "ventral scales";   // ... and only override the desc
	changes++;
}

// Second step: The player grows the signature turtle shell on his/her belly
if (player.hasLizardScales() && player.underBody.type == UNDER_BODY_TYPE_LIZARD && player.lowerBody == LOWER_BODY_TYPE_TURTLE /* && ... */) {
	outputText("... The [underBody.skinFurScales] on your belly start to harden to become a sturdy frontal shell to protect your body as a natural armor");
	player.underBody.type = UNDER_BODY_TYPE_TURTLE; // We're done, yay!
	changes++;
}
```


### RearBody
placeholder

### Neck
placeholder
