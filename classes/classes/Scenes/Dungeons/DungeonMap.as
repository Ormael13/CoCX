package classes.Scenes.Dungeons {
/**
 * A map for **one** dungeon (or closed dungeon section.
 * Contains all necessary methods and information for checking the player location (INSIDE the dungeon) and printing the map.
 */
public class DungeonMap extends DungeonAbstractContent {
    /*
    Reworked map - Svalkash edition.
    DON'T USE NUMERIC CONSTANTS.
    Map layouts work the same way as before.
    BUT, instead of writing maps for each room, you can make a map for dungeon (section), and then use letters and symbols to substitute.
    '0'-'9' - special meaning, usually some alternating part or locked/unlocked doors
    'a'-'z', then 'A'-'Z' - substitute for location codes.
    ---
    Usual markers:
    P - player
    L - locked door
    S - stairs
    E - exit (NYI)
    */

    //Location name, printed above the map.
    private var locName:String;

    //The map itself, representing the dungeon layout. May contain specific symbols that will be parsed later.
    private var map:Array;

    //Rooms associative array. Each room character translates into a constant from AbstractContent and is compared to player's position.
    //If the player is there, 'P' is displayed. Otherwise, either ' ' (space) or the original character (if contained in notSpaces).
    //MUST contain all rooms of the current dungeon (even if they are not present on the map) to detec that the player is in the dungeon.
    private var rooms:Object;

    //Function with unique symbol  replacements. Like, replace '1' with a locked door check. Returns empty object by default.
    private var getSpecial:Function;

    //Array of symbols from rooms which should not be replaced by spaces. Contains only 'S' by default.
    private var notSpaces:Array;

    public function DungeonMap(locName:String, map:Array, rooms:Object, special:Function = null, notSpaces:Array = null) {
        this.locName = locName;
        this.map = map;
        this.rooms = rooms;
        if (special != null)
            this.getSpecial = special;
        else
            this.getSpecial = function():Object { return {}; };
        if (notSpaces != null)
            this.notSpaces = notSpaces;
        else
            this.notSpaces = ['S'];
    }

    //Parses the map (inserts the player position and special elements) and returns the resultant String.
    // The Legend is not included.
    public function parseMap():String {
        //get basic map & associative objects
        var special:Object = getSpecial();
        //parse buffered map
        var fullMap:String = locName + "\n\n";
        for each (var line:String in map) {
            //check each character
            for (var i:int = 0; i < line.length; ++i) {
                var char:String = line.charAt(i);
                if (special.hasOwnProperty(char)) //replace special points (locked doors)
                    fullMap += special[char];
                else if (rooms.hasOwnProperty(char)) //replace room contents (player or nothing.. if in 'notSpaces', not replaced by space)
                    fullMap += (dungeonLoc == rooms[char] ? "P" : notSpaces.indexOf(char) != -1 ? char : " ");
                else fullMap += char;
            }
            //add \n to the end of the line
            fullMap += "\n";
        }
        return fullMap;
    }

    //Checks if the player is in the dungeon by iterating over all possible rooms and comparing them to dungeonLoc
    public function playerIsHere():Boolean {
        for each (var room:int in rooms)
            if (dungeonLoc == room)
                return true;
        return false;
    }
}
}