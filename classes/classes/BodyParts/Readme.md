How to work with the BodyParts-classes
======================================

Preface
-------

The `BodyParts` classes are container classes to keep multiple related propertys of complex body parts in a single class, so coders have a slightly easier job to handle them.<br>
For example many TFs reset the players skin by setting all of their values to their default value one by one. Or it could happen, that you forget to update the skinAdj when (re)setting the players Skin. This is now possible with one method call, like
```as3
// Restore everything to its default
player.rearBody.restore(false);

// Restore everything except the skintone to its default (the default)
player.skinData.restore();
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
placeholder

### RearBody
placeholder

### UnderBody
placeholder

### Neck
placeholder
