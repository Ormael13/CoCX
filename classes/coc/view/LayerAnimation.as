package coc.view {
import flash.display.BitmapData;

public class LayerAnimation {
	private var frames:/*AnimationFrame*/Array = [];
	private var animationDuration:int = 0;
	private var time:int = 0;
	private var frameIndex:int = 0;
	
	public function LayerAnimation(
			def:AnimationDef,
			layer:CompositeLayer
	) {
		this.animationDuration = def.animationDuration;
//		trace("assigning to layer "+layer.name+" animation "+def.name);
		for (var i:int = 0; i < def.frames.length; i++) {
			var fd:Array = def.frames[i];
			var fimage:CompositeLayer = null;
			var fname:String = fd[4];
			if (fname) {
				if (fname.indexOf('%') >= 0) {
					fname = fname.replace('%', layer.name);
				}
				fimage = layer.composite.getPart(fname);
//				trace("frame "+i+" image "+fname+" found "+!!fimage);
			}
			this.frames.push(new AnimationFrame(fd[0],fd[1],fd[2],fd[3],fimage));
		}
	}
	public function reset():void {
		time = 0;
		frameIndex = 0;
	}
	
	public function advanceTime(dt:int,t2:int):Boolean {
		var fi0:int = frameIndex;
		time += dt;
		while (time >= frames[frameIndex].tEnd) {
			frameIndex++;
			if (frameIndex >= frames.length) {
				time %= animationDuration;
				frameIndex = 0;
			}
		}
//			trace("[time="+time+"] "+name+" "+fi0+"->"+frameIndex);
		return frameIndex != fi0;
	}
	
	public function dx():int {
		if (this.frames.length == 0) return 0;
		return this.frames[frameIndex].dx;
	}
	
	public function dy():int {
		if (this.frames.length == 0) return 0;
		return this.frames[frameIndex].dy;
	}
	
	public function image():CompositeLayer {
		if (this.frames.length == 0) return null;
		return this.frames[frameIndex].image;
	}
}
}

