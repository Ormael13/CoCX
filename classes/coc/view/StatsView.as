package coc.view {
	import flash.display.MovieClip;
	import flash.display.Sprite;

	// Remove dynamic once you've added all the DOs as instance properties.
	public dynamic class StatsView extends Sprite {
		// add things from main view here?
		// yes because we'll need to update all the TFs and progress bars.
		public var upDownsContainer :Sprite;

		public function StatsView( mainView :MovieClip ) {
			super();

			if( ! mainView ) {
				return;
			}

			// glom on to things.
			// addChild ALL THE STATS.
		}

		// <- statsScreenRefresh
		public function refresh() :void {}

		// <- showStats
		public function show() {
			// make all the stats DOs visible.
			this.visible = true;
		};

		// <- hideStats
		public function hide() {
			// body...
			this.visible = false;
		};

		// <- hideUpDown
		public function hideUpDown() {
			// body...
		};
	}
}