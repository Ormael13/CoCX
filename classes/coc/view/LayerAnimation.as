package coc.view {
import flash.display.BitmapData;

public class LayerAnimation {
	public var name: String;
	
	private var frames:/*AnimationFrame*/Array = [];
	private var animationDuration:int = 0;
	
	public function LayerAnimation(
			name: String
	) {
		this.name = name;
	}
	
	public function addFrame(
			frameDuration:int,
			dx:int,
			dy:int,
			layer:CompositeLayer
//			src:BitmapData
	): void {
		var tStart:int = this.animationDuration;
		var tEnd:int = tStart + frameDuration;
		this.animationDuration += frameDuration;
		this.frames.push(new AnimationFrame(tStart,tEnd,dx,dy,layer));
	}
	
	public function advanceTime(time:int, frameIndex:int):int {
		while (time >= frames[frameIndex].tEnd) {
			frameIndex++;
			if (frameIndex >= frames.length) {
				time %= animationDuration;
				frameIndex = 0;
			}
		}
		return frameIndex;
	}
	
	public function dx(frameIndex:int):int {
		if (this.frames.length == 0) return 0;
		return this.frames[frameIndex].dx;
	}
	
	public function dy(frameIndex:int):int {
		if (this.frames.length == 0) return 0;
		return this.frames[frameIndex].dy;
	}
	
	public function image(frameIndex:int):CompositeLayer {
		if (this.frames.length == 0) return null;
		return this.frames[frameIndex].image;
	}
}
}

