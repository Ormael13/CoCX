package coc.view {
public class AnimationDef {
	public var name: String;
	public var frames:/*[tStart:int, tEnd:int, dx:int, dy:int, i:String]*/Array = [];
	public var animationDuration:int = 0;
	public function AnimationDef(
			name:String
	) {
		this.name = name;
	}
	
	public function addFrame(
			frameDuration:int,
			dx:int,
			dy:int,
			i:String
	): void {
		var tStart:int = this.animationDuration;
		var tEnd:int = tStart + frameDuration;
		this.animationDuration += frameDuration;
		this.frames.push([tStart,tEnd,dx,dy,i]);
	}
	
}
}
