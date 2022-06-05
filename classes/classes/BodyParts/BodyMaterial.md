# BodyMaterial system _(design draft)_

## Current state of affairs

Creature body has 2 skin layers (base and coat) + coverage level.

Each skin layer has color(s), type, and few extra properties. Example of base types are skin, goo, stone; example coat types are fur, scales, chitin.

Coverage goes from none (base only), low/partial (patches of coat), medium (mix of base & coat), high (almost fully covered with coat) and complete (fully covered with coat).

### Problems

1. Description-wise, a body part can have material different from "main skin" (torso). For example, "chitinous spider legs" are assumed to be covered with chitin, however, if character's torso is covered with fur, there is no place to store chitin color.

## Proposal

### Body materials

Extract **body material** data from skin layers to creature. A creature would store information on all possible body materials, and body parts can access any of them.

List of body material types should be kept short, but sufficient. Current needed types are: skin, fur, scales, and chitin. Candidates: hair, feathers.

Body material would store `color1`, `color2`. See 'Dual color system rework' below. To be discussed: move `adj` too.

### Dual color system rework

Currently, layers have "color" and "color2" properties for primary and secondary colors. Secondary, if empty, defaults to primary. In rare cases, color is not split to two, but a dual-color name like "white and black" is stored in a primary color, keeping secondary empty.

Proposed change is to have 3 properties:
* color1 and color2 are primary and secondary separate colors. If color2 is same as color1, it changes in sync
* "color" is either "color1" or "color1 or color2", and this is maintained both on reading and writing.

For example:
```js
player.furColor1 = "red"
player.furColor2 = "blue"
player.furColor === "red and blue"
// If color has 'and', it's split 
player.chitinColor = "yellow and black"
player.chitinColor1 === "yellow"
player.chitinColor2 === "black"
// Setting secondary same as primary makes it single-colored
player.chitinColor2 = "yellow"
player.chitinColor === "yellow"
// For single-colored material, changing color1 changes color2
player.chitinColor1 = "black"
player.chitinColor2 === "black"
```

## Function changes

* New r/w properties for body material colors: `skinColor/skinColor1/skinColor2`, `furColor/1/2`, `scaleColor/1/2`, `chitinColor/1/2`
* Corresponding parser tags: `[skin/fur/scales/chitin color/1/2]`
* `skinTone` (main skin color) will be named `bodyColor`

