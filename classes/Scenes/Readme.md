These are not strict rules but a general directions.

## Locations

A **Location** is either **Camp**, **Area**, **Place**, **Dungeon**, or **Quest**.

1. An **Area** is package, which main scene is directly available from **Explore** menu.
2. A **Place** is package, which main scene is available from **Explore** -> **Places** menu, but is not a **Dungeon**.
3. A definitions of **Dungeon** and **Quest** assumed obvious.

### Notes

1. **Locations** that share many common scenes could be joined in one package, like **Forest** and **Deepwoods**.
2. Sub-locations are welcomed, like **Lake** and **Boat**. Areas that are directly explorable after they are found in other
   areas (like **Mountain** and **High Mountain**) are <u>not</u> subareas.
3. Events for **Explore** -> **Explore** could be placed directly into _Scenes/Areas_.

## NPCs

1. If a **NPC** can not be discovered directly by visiting **Location**, put it in _Scenes/NPCs_.
2. If a **NPC** can be made a follower/slave/lover/etc, or contains highly detailed dialogue/scene,
   put it in _Scenes/NPCs_.
1. If a **NPC** can be met in a specific **Place** or **Dungeon**, put it in its corresponding package.
3. Else put it in corresponding **Area** package.

## Monsters

1. **Monster** classes that are related to **NPCs** should be placed in same package as corresponding **NPCs**.
2. **Monsters** that mostly could be found in one **Location** should be placed in that **Location** package.
3. Else put it in _Scenes/Monsters_.

## Other scenes

If it does not fit **Camp** scenes, put it whatever it seems logial and where similar scenes may appear.
