package classes.BodyParts {

public class Hair extends BodyPart {
	public static const NORMAL:int  = 0;
	public static const FEATHER:int = 1;
	public static const GHOST:int   = 2;
	public static const GOO:int     = 3;
	public static const ANEMONE:int = 4;
	public static const QUILL:int   = 5;
	public static const GORGON:int  = 6;
	public static const LEAF:int    = 7;
	public static const FLUFFY:int  = 8;
	public static const GRASS:int   = 9;
	public static const SILKEN:int  = 10;
	public static const STORM:int   = 11;
	public static const BURNING:int = 12;
	public static const SNOWY:int 	= 13;
	//public static const SNOWY:int 	= 14;//button 0 on 2nd page of metamorph
	// Don't forget to add new types in DebugMenu.as list HAIR_TYPE_CONSTANTS
	
	public var color:String = "no";
	public var length:Number = 0.0;
	
	public function Hair() {
		super(null, null);
	}
	
	public override function restore(keepColor:Boolean = true):void {
		super.restore();
		color = "no";
		length = 0.0;
	}
}
}
