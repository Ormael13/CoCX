# BodyMaterial system

## Old system

Creature body has 2 skin layers (base and coat) + coverage level.

Each skin layer has color(s), type, and few extra properties. Example of base types are skin, goo, stone; example coat types are fur, scales, chitin.

Coverage goes from none (base only), low/partial (patches of coat), medium (mix of base & coat), high (almost fully covered with coat) and complete (fully covered with coat).

### Problems

1. Description-wise, a body part can have material different from "main skin" (torso). For example, "chitinous spider legs" are assumed to be covered with chitin, however, if character's torso is covered with fur, there is no place to store chitin color.
2. Referencing fur (scale/...) color without a coat required hacks.
3. Charviewer sprites had colors for different materials, but they were kept in sync.

## New system

### Body materials

Colors now belong not to skin layers, but to **body material** types. A creature would store information on all possible body materials, and body parts can access any of them.

Current body materials types: skin, hair, fur, scales, chitin and feathers.
Keep list short, but sufficient.
* This allows dual-colored hair.

Body material stores `color1`, `color2` (see 'Dual color system rework' below). 

Body parts indicate whether they have material or not. 
For example, scaly wings would return `true` for `hasMaterial(BodyMaterial.SCALES)`.

### Dual color system rework

Old system: layers have "color" and "color2" properties for primary and secondary colors. 
Secondary, if empty, defaults to primary. 
In rare cases, color is not split to two, but a dual-color name like "white and black" is stored in a primary color, keeping secondary empty.

In the new system there are 3 synchronized properties:
* `color1` and `color2` are primary and secondary separate colors. If color2 is the same as color1, it changes in sync.
* `color` is either "color1" or "color1 and color2", and this is maintained both on reading and writing.

For example:
```js
player.furColor1 = "red"
player.furColor2 = "blue"
       furColor === "red and blue"

// If color has 'and', it's split 
player.chitinColor = "yellow and black"
       chitinColor1 === "yellow"
       chitinColor2 === "black"
       chitinColor  === "yellow and black"
// Setting secondary to same as primary makes it single-colored
player.chitinColor2 = "yellow"
       chitinColor1 === "yellow"
       chitinColor2 === "yellow"
       chitinColor  === "yellow"
// For single-colored material, changing color1 changes color2
player.chitinColor1 = "black"
       chitinColor1 === "black"
       chitinColor2 === "black"
       chitinColor  === "black"
// Changing color2 to new value makes it dual-colored again
player.chitinColor2 = "yellow"
       chitinColor1 === "yellow"
       chitinColor2 === "black"
       chitinColor  === "yellow and black"
```

## Function changes

(For brevity, in following code `fur` means any other body material).

* New r/w properties for body material colors: `skinColor/skinColor1/skinColor2`, `furColor/furColor1/furColor2`
* Corresponding parser tags: `[skin/fur color/color1/color2]`
* `skinTone` (main skin color) renamed to `bodyColor`
* `hasFur` renamed to `isFurCovered`
* `hasFurMaterial` checks if any body part has material
* Functions that take body material ID as an argument: `hasBodyMaterial`, `bodyMaterialColor`, `setBodyMaterialColor`

## Parser Tags

* `[color]`,`[color1]`,`[color2]` - main body color (and its components).
* body material colors:
  - `[skin color]`, `[skin color1]`, `[skin color2]`
  - `[hair color]`, `[hair color1]`, `[hair color2]`
  - `[fur color]`, `[fur color1]`, `[fur color2]`
  - `[scales color]`, `[scales color1]`, `[scales color2]` (or `scale`)
  - `[chitin color]`, `[chitin color1]`, `[chitin color2]`
  - `[feather color]`, `[feather color1]`, `[feather color2]` (or `feathers`)
* layer-specific colors:
  - `[skin base.color]`, `[skin base.color1]`, `[skin base.color2]`  
  - `[skin coat.color]`, `[skin coat.color1]`, `[skin coat.color2]` 
* special:
  - `[flowercolor]` - alraune orchid color

These are REMOVED:
* `[skintone]`,`[skin.color]` (use `[color]`)

These WORK DIFFERENTLY:
* `[skin color]`/`[skin color2]` (use `[color]`), now it means "skin material color"

## To Be Discussed

### Body material types

All materials w/o their own type would use colors from some other material (goo skin would use normal skin, dragon scales - normal scales).

- skin
- fur
- scales
- chitin
- hair - for unification
- feathers
- (?) horns/claws - has its own tone but never used in-game. could use chitin?
- (?) bark/leaves/plant matter

### Body material properties

- `type` (never changes)
- `color1`, `color2`, `color`
- (?) `adj` - would propagate descriptions like "rubber skin" to other body parts
- (???) `pattern` - probably not, as it could allow having multiple patterns, or patterns on small area
