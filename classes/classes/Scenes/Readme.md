These are not strict rules but a general directions.

# Scene classes

## Class hierarchy

All scenes should be put it BaseContent subclasses. How many classes per event it developer to decide.

An instance of this scene class should be available from `CoC` (declared as field and instantiated in the declaration),
but not necessarily directly. It is preferable that location-specific scenes should be fields of corresponding location
scenes. In code referencing a "foreign" scene to call an event could be something like
`doNext(kGAMECLASS.telAdre.bakeryScene.bakeryuuuuuu);` . For such location-specific scenes it is good to subclass them
from common superclass containing handy methods to access instance of their parent and other helpy stuff (see
_Scenes/Places/TelAdre/TelAdreAbstractContent.as_ )

## Class members

1. Remember that all variables declared in the Scene will not be saved/loaded in any way, or even resetted after save/load
   unless there is specific code for that in global save/load/newgame method.
2. Please keep methods as invisible as possible; a good start would be declare every function private and make them
   public/internal when needed.
3. For debugging purposes methods of all classes in package _classes/Scenes/_ or its subpackages are listed in
   name-by-ref dictionary `funcLookups`, see _engineCore.as_ (Before that only CoC methods were saved in that dictionary).
   If for whatever reason your scene is in another package, add an `[Scene]` metadata to it (see declaration of
   `testContent` in `CoC` for example.

# File placement

## Locations

A **Location** is either **Camp**, **Area**, **Place**, **Dungeon**, or **Quest**.

1. An **Area** is package, which main scene is directly available from **Explore** menu.
2. A **Place** is package, which main scene is available from **Explore** -> **Places** menu, but is not a **Dungeon**.
3. A definitions of **Dungeon** and **Quest** assumed obvious.
4. A BaseContent subclass for general **Area** or **Place** should be placed in either _Scenes/Areas_ or _Scenes/Places_,
   correspondingly.

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
