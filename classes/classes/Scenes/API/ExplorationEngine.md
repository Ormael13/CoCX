# How to use ExplorationEngine

ExplorationEngine (available as `explorer` in BaseContent) allows exploration in semi-random way. Instead of picking one random encounter at a time, multiple random encounters are generated, arranged in 5 roads of random length 2..7. Player then chooses a road and encounters are executed in sequence, until player loses a battle or reaches the end. Some encounters can be revealed - depending on player stats, area level and other factors - this makes hunting particular item/npc/event easier while still keeping some randomness.

Encounters on the map have 3 reveal stages:
* **Hidden**: displayed as ???
* **Partially revealed**: encounter kind - NPC, Monster, Item - is visible
* **Fully revealed**: encounter name is visible, ex. "Imp Overlord" or "Tamani".

## Updating encounter definition

ExplorationEngine works with existing GroupEncounter, but they need to have extra fields:
* `kind` (String or function returning String, required). An encounter category, for example `"item"`, `"boss"`, or `"npc"`. See `ExplorationEntry.EncounterKinds` for full list.
* `label` (String or function returning String, optional). Map label - default is encounter `name` capitalized.
* `hint` (String or function returning String, optional). Displayed in the tooltip when hovering over the fully revealed encounter.
* `special` (Boolean, optional). Encounter with `special: true` have priority to appear on the road end.
* `unique` (Boolean|String, optional). If `unique: true`, then only one such encounter can appear on a map. If `unique` is a String indicating encounter group, only one encounter of that group can appear.
* `reenter` (Boolean, optional). You can re-enter the encounter after finishing it (until you go forward).

Example:
```diff
    }, {
        name  : "truffle",
+       label : "Truffle",
+       kind  : 'item',
+       hint  : 'A pigtail truffle',
        call  : findTruffle,
        chance: 0.20
    }, {
```

Locations have the following encounters, depending on their place on a road:
* First encounter cannot have `special:true`.
* Last encounter either has `special:true`, or its `kind` is one of: `'npc', 'item', 'boss', 'treasure', 'special'`.

## Updating the encounter code

Most encounters end with `camp.returnToCampUseOneHour` or combat (which ends with bad end or return to camp). To allow player continue exploration instead, these should be modified.

* `endEncounter();`: End current encounter. [Next] to exploration UI
* `explorer.done();`: End current encounter. Show exploration UI.
* `explorer.markEncounterDone();`: End current encounter.
* `explorer.stopExploring();`: Mark exploration as finished. 

The difference is that `done()` should be used in callbacks to avoid double-nexting. `endEncounter()` should be called by itself. 

It is safe to call these methods outside the exploration engine.

Examples:
```as
// Old: [Next] to camp after 1 hour
doNext(camp.returnToCampUseOneHour);

// New: [Next] to exploration map 
endEncounter();
// Or:
doNext(explorer.done);


// Old: Take item, then return to camp
inventory.takeItem(consumables.PIGTRUF, camp.returnToCampUseOnehour);

// New: Take item, then return to exploration
inventory.takeItem(consumables.PIGTRUF, explorer.done);


// Old: [Next] to camp after 6 hours
doNext(camp.returnToCampUseSixHours);

// New: Also properly close the exploration engine
explorer.stopExploring();
doNext(camp.returnToCampUseSixHours);
```

**If an encounter ends with old return-to-camp code, it will report an error but allow to continue exploration if it is 1 hour time pass.**

## Invoking the explorer

The code has 3 parts:

### 1. Preparation

```as
explorer.prepareArea(groupEncounter);
```
This code generates random encounters and places them on roads.

After `prepareArea` you can edit the 'roads':
```as
if (explorer.roadLength(0) > 5) { // check road length
  explorer.removeLast(0); // remove last entry
}
if (explorer.entryAt(2, 1).encounter.encounterName() == "beegirl") { // check encounter at road 2 pos 1
  explorer.setEncounterAt(2, 1, "trip"); // replace
}
```
Indices are 0-based: road numbers are 0..4, and road poitions are 0..6. 

### 2. Customization

Exploration engine has many properties that could be overriden, if needed:

```as
// Set area tags (see below). 
// Can be used in combat code to check the location
explorer.setTags("tag1", "tag2", ...);

// Set hook to execute just before executing encounter.
explorer.onEncounter = function(e:ExplorationEntry):Boolean {
    player.exploredForest++;
    if (should not execute encounter) {
        return true;
    }
    return false;
}

// Modify a [Leave] button
explorer.leave.hint("Leave the forest outskirts");
// Remove the [Leave] button
explorer.leave = null;

// Do something with the interface
// In this example, we add the [Scout] button that
// reveals one location for free
explorer.onMenu = function():void {
    if (explorer.numUnrevealed() > 0) {
        button(13).show("Scout", function():void {
            explorer.revealRandom();
            explorer.doExplore();
        });
    }
}

// Reveal some locations at start
// In this example, the number is:
//  1 free reveal
// +1 for 10 wis
// +1 for 100 forest explorations
explorer.revealMultiple(1+player.wis/10+player.exploredForest/100);

// Change the behaviour of [End] button that appears on the end of the exploration
explorer.onEnd = new ButtonData("Repeat", exploreEndlessForest);

// true (default) - encounters can be fully revealed, displaying their name.
// false - only encounter kind can be revealed
explorer.canRevealFull = false;

// Disable inventory management during exploration
explorer.canInventory = false;

// Disable masturbation during exploration
explorer.canMastrubate = false;
```

### 3. Display the area map and choices

```as
explorer.doExplore();
```

## Interacting with the exploration engine

```as
explorer.getCurrentEntry()
```
If player is inside an encounter - that is, started one and not yet returned to the exploration map - return corresponding `ExplorationEntry`. Otherwise, return null.

This can be used, for example, to check if player revealed the entry:

```as
public function tripOnARoot():void {
    if (explorer.inEncounter && explorer.getCurrentEntry().isFullyRevealed) {
        outputText("You carefully step over an exposed root.");
    } else {
        outputText("You trip on an exposed root, scraping yourself somewhat, but otherwise the hour is uneventful.");
        player.takePhysDamage(10);
    }
    endEncounter();
}
```

Or to make an encounter repeatable/no longer reentrable.

---

```as
explorer.nextNodes
```
Array of next nodes.

If exploration is ended, empty array.
If road not picked, array of first nodes on the road. 

---

```as
explorer.inEncounter
```
Is `true` if player inside an encounter (see `getCurrentEntry()`)

---

```as
explorer.isActive
```
Is `true` is there's an ongoing exploration - initialized but not finished.

---

```as
explorer.numUnexplored()
```
Return number of unexplored encounters on current road. 0 if road isn't picked yet.

---

```as
explorer.numUnrevealed()
```
Return number of unreveald encounters on map (if on a road - only on current road).

---

```as
explorer.findByName(name)
```
Find on a map `ExplorationEntry` for an encounter with a specific name, or `null` if none found.
Ignores disabled (cleared or off-road) entries.

---

```as
explorer.findAllbyName(name)
```
Find all `ExplorationEntries` of an encounter.
Ignores disabled (cleared or off-road) entries.

---

```as
explorer.skillBasedReveal(areaLevel, timesExplored);
```

Reveal some number of nodes based on player stats, perks, area level and times area was explored.

See function source for exact formula.

---

```as
explorer.revealRandom()
```
Pick one random `ExplorationEntry`, reveal it and return. `null` if none found.

---

```as
explorer.revealMultiple(n)
```
Reveal `n` random locations.
`n` can be float, in this case either of nearby integers is picked randomly, for example `revealMultiple(3.4)` will reveal either 3 (60% chance) or 4 (40% chance) locations.

---

```as
explorer.revealAllByName(name, [level])
```
Reveal all locations with specific encounter.
`level` is reveal level (0: hidden, 1: partial; 2: full, default).
0 can be used to always hide certain encounters.
