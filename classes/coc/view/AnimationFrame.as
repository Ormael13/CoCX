package coc.view {
public class AnimationFrame {
	public var tStart:int;
	public var tEnd:int;
	public var dx:int;
	public var dy:int;
	public var image:CompositeLayer;
//	public var src:BitmapData;
//	public var dst:BitmapData;
	
	public function AnimationFrame(
			tStart:int,
			tEnd:int,
			dx:int,
			dy:int,
			image:CompositeLayer
			//			src:BitmapData
	) {
		this.tStart = tStart;
		this.tEnd = tEnd;
		this.dx = dx;
		this.dy = dy;
		this.image = image;
//		this.src = src;
//		this.dst = src ? new BitmapData(src.width, src.height, true, 0) : null;
	}
}
}
