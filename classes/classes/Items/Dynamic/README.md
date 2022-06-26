# Enchanted items

## System limitations and workarounds

* Properties cannot be added to existing items without rewriting their code.
  - There is a simple tool to convert “old” items to “new”. For example, old “black dye” (unique item) to new “dye {color=black}” (dynamic item).
* Most of the time, dynamic items won’t stack. Even if their parameters are identical, JSON serialization quirks (parameter order) might result in different ids.
  - It only means that two separately generated items won’t stack; copying exact ids or modifying stack size would still work.
* Technically, it is impossible to “change” item property - a recreation would be required. For example, changing “flawless sword, durability 100/100” to “flawless sword, durability 99/100” would require removing old item and creating new with slightly different properties.
  - Can be improved in future updates.
* Item library might bloat as more and more items are created; this could lead to degraded performance or even crash.
  - Restarting the Flash would help.
  - Can purge dynamic item cache periodically, or on hitting certain limit, ex. 10,000 items.


## Adding new enchantment type

Different ways:
1. Instantiate `StatEnchantmentType` if the enchantment is simply adding a buff to one stat.
2. `SimpleEnchantmentType`. A standard enchantment template. Has a random generator and power-dependent value calculator. A good option if enchantment has single "power" parameter (or no parameters at all) and its logic is implemented somewhere else.
3. Subclass `SimpleEnchantmentType`. If you want to create many similar enchantment types that don't have extra parameters. See `StatEnchantmentType` for example.
4. Subclass `EnchantmentType`. When you need to tweak random generation, loading, or have more parameters than enchantment power.

### Adding SimpleEnchantmentType

Use the template in `EnchantmentLib`.

For example:

```as
 public static const FireDamage:EnchantmentType = mk(14, "Fire Damage", {
      prefix: "Fiery ",
      suffix: " of Fire",
      shortSuffix: "FD",
      description: "+{power}..{power*2} fire damage",
      rarity: RARITY_MAGICAL,
      categories: [CATEGORY_WEAPON_MELEE, CATEGORY_WEAPON_RANGED],
      minLevel: 5,
      minPower: 1,
      maxPower: 10,
      valuePerPower: 100, // +100 gems per power
      valueX: 1.5, // +50% item value
 }); 
```
(More parameters documented in `EnchantmentLib`).

### Subclassing SimpleEnchantmentType

See `StatEnchantmentType` as an example.

Subclass `SimpleEnchantmentType`. 
* Provide needed superclass arguments. 
* Override `onEquip`, `onUnequip` if needed.

Add a `public static const` member of that class in `EnchantmentLib`.

### Subclassing EnchantmentType

First, design enchantment parameters. Enchantment is encoded as `[identified:0|1, id:int, ...params]`.

Subclass `Enchantment`. 
* Add enchantment parameters in constructor and as fields.
* Override `encode()`.

Subclass `EnchantmentType`. 
* Provide superclass arguments.
* Implement `doDecode`.
* Implement `generateRandom`. Generate params and call `doDecode` or instantiate enchantment directly.
* Override `onEquip`, `onEquip` if needed.
* Write a `spawn()` item to create enchantment with params.

Add a `public static const` member of that class in `EnchantmentLib`.

## Using enchantments

Checking specific item:
```as
// Returns array enchantments 
item.getEnchantments()

// Returns true if has enchantment of that type
item.hasEnchantment(EnchantmentLib.Xxxx)

// Power of specific enchantment, or 0
item.enchantmentPower(EnchantmentLib.Xxxx)

// Enchantment object of specified type, or null
item.enchantmentOfType(EnchantmentLib.Xxxx)
```

Checking any item on player:
```as
// True if any equipped item has specific enchantment
player.hasEnchantment(EnchantmentLib.Xxxx)

// Power of specific enchantment, 0 if none
// 2nd param="sum"|"max"|"min" - if multiple same-type enchantments
player.enchantmentPower(EnchantmentLib.Xxxx, "sum")

// Enchantment object of specified type, or null
// If multiple items has it, return first
player.findEnchantment(EnchantmentLib.Xxxx)

// All enchantments of specific type
player.allEnchantments(EnchantmentLib.Xxxx)
```

Example:
```as
var fd:Number = player.weapon.enchantmentPower(EnchantmentLib.FireDamage);
if (fd > 0) {
    doFireDamage(fd.power + rand(fd.power));
}
```

## Generating random item

`DynamicItems.randomItem(options)`.

Many its properties can accept either fixed value, or weighted table. A weighted table is a list of `[weight, value]` pairs used to generate random value.

For example, `{ subtype: "sword" }` would generate sword and `{ subtype: [[1, "sword"], [3, "dagger"]] }` would generate sword with 25% chance and dagger with 75%.

Options:
* `rarity`: value or table of `ItemConstants.RARITY_COMMON/MAGICAL/RARE/LEGENDARY/DIVINE`
* `level`: level to use, default = player.level
* `ng`: NG+ factor to use, default = NGMOD + 1
* `quality`: value or table
* `category`: value or table of `ItemType.CATEGORY_XXX`
* `subtype`: (only if `category` is constant) value or table of item subtype. Refer to dynamic item docs on available subtypes.
* `cursed`: value or table of`ItemConstants.CS_(HIDDEN/KNOWN)_(CURSED/UNCURSED)`. By default, depends on generated effects.
* `identified`: generate an identified or unidentified item. Default false.

Examples:

```as
// Generate random unidentified cursed sword
var item:ItemType = DynamicItems.randomItem({
    category: ItemType.CATEGORY_WEAPON_MELEE,
    subtype: "sword",
    cursed: DynamicItems.CS_HIDDEN_CURSED
});

// Generate magical (80%) or rare (20%) item
var item:ItemType = DynamicItems.randomItem({
    rarity: [
        [8, DynamicItems.RARITY_MAGICAL],
        [2, DynamicItems.RARITY_RARE]
    ]
});
```

### Monster drop

In the monster constructor, set `randomDropChance` to a value between 0 and 1. If you want to adjust generated item properties, set `randomDropParams`, it is passed to `randomItem()`.
```as
// 10% to drop common/magical/rare item
this.randomDropChance = 0.1;
this.randomDropParams = {
    rarity: DynamicItems.RARITY_CHANCES_LESSER
};
// level: this.level param is always added
```

Alternatively, just generate an item type and add it the usual way. Add an option to use monster level instead of player's:

```as
this.drop = new WeightedDrop()
    .add(consumables.GOB_ALE,5)
    .add(consumables.PONAILS,2)
    .add(DynamicItems.randomItem({level:this.level}))
```

## Creating specific item

Use `itemTemplates.createWeapon()` with `EnchantmentLib.Xxxx.doSpawn`

```as
var item:ItemType = itemTemplates.createWeapon(
    "rapier",
    DynamicItems.RARITY_RARE,
    +1,
    DynamicItems.UNKNOWN_CURSED,
    [
        EnchantmentLib.Speed.spawn(false, 5),
        EnchantmentLib.Toughness.spawn(false, 5)
    ]
);
// (?) rare rapier +1
// cursed Fast rapier of Toughness +1
```

## Modifying item

An `ItemType` is immutable. You need to re-create it and replace the original.

Dynamic items provide helper methods to spawn a partially modified copy:

```as
// Identify item
player.itemSlots[0] = (player.itemSlots[0] as IDynamicItem).identifiedCopy();

// Remove curse 
player.itemSlots[0] = (player.itemSlots[0] as IDynamicItem).uncursedCopy();

// Increase quality by 2 and remove enchantments
var weapon:DynamicWeapon = player.weapon as DynamicWeapon;
player.weapon = weapon.moddedCopy({
    q: weapon.quality+1,
    e: []
}) as DynamicWeapon;

// Add Strength enchantment
var weapon:DynamicWeapon = player.weapon as DynamicWeapon;
var effects = weapon.effects.slice(); // copy
effects.push(EnchantmentLib.Strength.spawn(true, 4)); 
player.weapon = weapon.copy({
    e: effects
}) as DynamicWeapon; 
```
