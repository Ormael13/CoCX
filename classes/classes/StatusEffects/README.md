# Status Effects API

## Migration guide

### Creating new effects

1. Subclass `StatusEffectClass` or its subclass
    1) Add a `public static TYPE:StatusEffectType` field initialized with `register("unique id", ThisClassName)`.
    2) Link to the `TYPE` through superclass constructor.
    3) In the `StatusEffects` library, add a static constant that refers `TYPE` (even if you don't use the constant, this is required for `TYPE` to be properly initialized on application start).
2. Override the `onXXXX` methods.
    * **onAttach** - after added to `host.statusEffects` as part of the game. Events related to first application of the effect should go here; text output can stay in the scene code if it's unique.
    * **onRemove** - after removed from `host.statusEffects`. Reversing the changes should go here.
    * **onCombatEnd**
    * **onCombatRound**
    * TODO global time-aware listeners.
    
    `onAttach` and `onRemove` are not called when loading save or creating new character.

Try to keep the actual effects in this class, _especially_ **value1-4** semantics. In the scenes, interactions with class-specific methods are preferred over manipulating game state directly. 

`game` is a shortcut for `kGAMECLASS`. `host` is the creature (monster or player) the effect is attached to. `playerHost` is `host as Player`, so you can use it for code completion, and also in conditions like 
```
if (playerHost) game.outputText(...)
```

## Helper classes &amp; methods

#### StatusEffectClass.remove()

Removes this instance from host. Fires a `onRemove` event.

#### StatusEffectClass.attach(host:Creature) and Creature.addStatusEffect(StatusEffectClass)

Attaches the existing instance of StatusEffectClass to host.

#### Creature.createOrFindStatusEffect(StatusEffectType)

Finds a status effect by type; if not found, creates new one with value1-4 of 0.
Returns the existing or new effect instance.

#### class CombatStatusEffect

Removes itself when the combat ends.

### TemporaryBuff 

Common superclass for temporary stat \[de\]buffs with complete recovery after time. **CombatBuff** removes itself when combat ends.

#### Guide

1. Subclass. Pass affected stat names - up to 4`dynStat` keys like `'str'`, `'spe'`, `'tou'`, `'int'`, `'lib'`, `'sen'` - as superclass constructor args.
2. To apply recoverable \[de\]buff with properly memorized effect values, call `buffHost` instead of `host.dynStats`. Using `host.dynStats` will make effects permanent.
2. If no external parameters required to the effect itself, just override `apply()` with a call to buffHost to buff host and remember effect.
3. To apply buff, add it to host. Call `increase()` on already existing buff to increase it effect
5. Stats are restored when effect is removed. Call `restore()` to reset stats but keep the effect attached to host.
4. If you need to pass external parameter like "effect strength" to application code:
    - add a custom `applyEffect(...)` method 
    - acquire the effect instance (`findStatusEffectByType`, `createOrFindStatusEffect`, `createStatusEffect`, or just create `new MyEffect()`)
    - cast to your type if needed
    - call new method 

#### Implementation details

value1-value4 store `(newStatValue - oldStatValue)`.

Application is done through `host.dynStats`.

Recovery uses `host.dynStats` with additional `'scale', false` arguments to apply the exact values.

## Creature & Player changes

The following methods are pulled from `Player` up to `Creature` so that the `host` of effect could be manipulated in a uniform way. 

* `getAllMaxStats`
* `minLib`
* `minSens`
* `minLust`
* `takeDamage`
* `takeLustDamage`
* `spellMod`

### dynStats

1. Moved to `Creature` from `kGAMECLASS`.

1. Returns an Object of `(newStat-oldStat)` values with keys **str**, **tou**, **spe**, **int**, **lib**, **sen**, **lus**, **cor **.

2. **noBimbo**/**bim** and **resisted**/**res** are replaced with **scaled**/**sca**: if true, apply resistances perks and other; if false - apply values as-is, just respect the mins and maxes.

3. Actual stat change is done in method `modStats` that accepts separate args (old `stats`-like)

4. `modStr`, `modTou`, `modSpe`, `modInt` methods change one stat and return the actual increase. 
