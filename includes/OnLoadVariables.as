/**
 * All the variables that have been left around but don't fit into the GlobalVariables file
 * Will be removed at a point.
 */

//System time
public var date:Date = new Date();

//Mod save version.
public var modSaveVersion:Number = 13;
public var levelCap:Number = 120;

//dungeoneering variables (If it ain't broke, don't fix it)
public var inDungeon:Boolean = false; //Re-enabled for sake.
public var dungeonLoc:int = 0;

// To save shitting up a lot of code...
public var inRoomedDungeon:Boolean = false;
public var inRoomedDungeonResume:Function = null;

public var timeQ:Number = 0;
public var campQ:Boolean = false;
