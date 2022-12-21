(outdated) How to work with the BodyParts-classes
=================================================

Preface
-------

The `BodyParts` classes are container classes to keep multiple related propertys of complex body parts in a single class, so coders have a slightly easier job to handle them.<br>
For example many TFs reset the players skin by setting all of their values to their default value one by one. Or it could happen, that you forget to update the skinAdj when (re)setting the players Skin. This is now possible with one method call, like
```as3
// Restore everything to its default
player.rearBody.type.restore(false);

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
player.skin.setProps({type: DRAGON_SCALES, adj: "tough", desc: "shield-shaped dragon scales"});
```

Another example for BodyParts with a `skin` property:
```as3
player.rearBody.type.setProps({
    type: DRACONIC_MANE,
    skin: {
        type: DRAGON_SCALES,
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
| `type`     | `skinType`                | `player.skin.type`      | **The type**<br>`player.skin.type = FUR;`                                                                      |
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
| `player.skin.description(true)`       | `[skin noadj]` | "You have **green scales**."         |
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
- `type` is set to `FUR`
- `adj` is set to "soft"
- `furColor` is set to "orange"
- `desc` is set to "fur"

##### public function hasFur():Boolean
Moved from and aliased to `Creature.hasFur()`<br>
Returns true if the player has fur (aka `player.skin.type == FUR`). Nuff said.

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

##### copySkin(p:Object = null)
This is mainly a wrapper around
```as3
player.underBody.skin.setProps(player.skin);
```
The param `p:Object = null` can optionally be used to override certain skin propertys after copying them (See in the examples below)

#### Examples
##### From lizard scales TF:
```as3
player.skin.setProps({
	type: SKIN_TYPE_LIZARD_SCALES,
	adj: "",
	desc: "scales"
});
player.underBody.type = UNDER_BODY_TYPE_LIZARD;
player.underBody.copySkin({ // copy the main skin props to the underBody skin ...
	desc: "ventral scales"  // ... and only override the desc
});
```

You can always set the propertys to be overridden manually after copying the skin-propertys:
```as3
player.skin.setProps({
	type: SKIN_TYPE_LIZARD_SCALES,
	adj: "",
	desc: "scales"
});
player.underBody.type = UNDER_BODY_TYPE_LIZARD;
player.underBody.copySkin();                     // copy the main skin props to the underBody skin ...
player.underBody.skin.desc = "ventral scales";   // ... and only override the desc
```

##### Another example:
Let's say, we intend to have some kind of turtle girl TF in CoC, the TF code *could* go this way (Not suggesting anything here, its just an example!):

```as3
// First step: The player grows lizard scales on his/her skin and/or underbody
if ((!player.isLizardScaleCovered() || [UNDER_BODY_TYPE_LIZARD, UNDER_BODY_TYPE_TURTLE].indexOf(player.underBody.type) == -1) && player.lowerBody == LOWER_BODY_TYPE_TURTLE /* && ... */) {
	outputText("... You grow " + player.skin.tone + " scales on your skin!");
	player.skin.setProps({
		type: SKIN_TYPE_LIZARD_SCALES,
		adj: "",
		desc: "scales"
	});
	player.underBody.type = UNDER_BODY_TYPE_LIZARD;
	player.underBody.copySkin({ // copy the main skin props to the underBody skin ...
		desc: "ventral scales"  // ... and only override the desc
	});
	changes++;
}

// Second step: The player grows the signature turtle shell on his/her belly
if (player.isLizardScaleCovered() && player.underBody.type == UNDER_BODY_TYPE_LIZARD && player.lowerBody == LOWER_BODY_TYPE_TURTLE /* && ... */) {
	outputText("... The [underBody.skinFurScales] on your belly start to harden to become a sturdy frontal shell to protect your body as a natural armor");
	player.underBody.type = UNDER_BODY_TYPE_TURTLE; // We're done, yay!
	changes++;
}
```


### RearBody
placeholder

### Neck
placeholder

Changed or new related methods
------------------------------

Syntax: ClassName.methodName

### Player.setFurColor
Set the new furColor or furColors randomly and, if wanted: set the new underBody as well.

#### Param `colorArray:Array`
The method still accepts a list of strings to randomly choose from as the new furColor for BC, but in addition to that it now accepts a mixed list of strings and arrays with two strings.

##### Example
```as3
player.setFurColor([ 
	"orange", 
	"brown", 
	"black", 
	"gray", 
	"white", 
	["orange", "white"], 
	["brown", "white"], 
	["black", "white"], 
	["gray", "white"], 
]);
```
If the randomizer chooses one of the first five options, only the main furColor aka `player.furColor` is being set (old behaviour still works),
but for the last four options, the array specifies the main furColor and the furColor on the underBody.

So, if the choice is `["orange", "white"]` for example, it would be the same as:
```as3
player.furColor = "orange";
player.underBody.furColor = "white";
```

#### Param `underBodyProps:Object = null`
In addition to setting the furColor(s) you may want to override a few or all underBody-props, too. You can do that here. (See the example below)

#### Param `doCopySkin:Boolean = false`
Set this to true, if you want to copy the skin-props to the underBody before overriding the underBody.skin. (See the example below)

#### Param `restoreUnderBody:Boolean = true`
If set to true (the default), the underBody is restored before setting the other values. In most, if not all cases, its not needed to set this to false and its always a good idea to clean up the underBody first (or in case the creature has no inhuman underBody)

##### Example
```as3
player.setFurColor(catFurColors, {type: UNDER_BODY_TYPE_FUR}, true);
```
See the example above for potential `catFurColors`

### Player.setSkinTone
Same as `Player.setFurColor` but for the skinTone(s). Currently not used.

### PlayerHelper.hasDifferentUnderBody
Returns true, if the main skin and the underBody-skin differs somehow and false otherwise.
The furColor is only compared, if both the main skin and the underBody skin are furry of course.
If the player has no inhuman underBody it returns false. And certain underBody-types, like naga underBody are handled differently, hence it returns false with these, too.

### Character.nagaLowerBodyColor2
Like I stated above: Naga underBody is handled differently and since it has two colors at least (one for the underside and one for the rest), this method returns the secondary (underside) color depending on the primary naga lower body color (`player.underBody.skin.tone` here).
Actually, this is a wrapper around `Appearance.nagaLowerBodyColor2`

### Utils.convertMixedToStringArray(list:Array):Array
In order to get the mixed color lists (string vs. arrays of strings, see `Player.setFurColor` above) to play nicely with `Utils.InCollection` the array needs to be altered to contain strings only.

##### Example
```as3
var colorList:Array = [
	"blue",
	"green",
	["black", "white", "gray"],
	["red", "orange"],
	"blue"
];

convertMixedToStringArray(colorList);
// returns ["blue", "green", "black, white and gray", "red and orange", "blue"]
```
