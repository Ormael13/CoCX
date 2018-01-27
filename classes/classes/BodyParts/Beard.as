package classes.BodyParts {

public class Beard extends BodyPart {
	public static const NORMAL:int = 0;
	public static const GOATEE:int = 1;
	public static const CLEANCUT:int = 2;
	public static const MOUNTAINMAN:int = 3;
	
	public var length:Number = 0;
	public function Beard() {
		super(null, null);
	}
}
}
