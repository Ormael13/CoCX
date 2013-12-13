package coc.test {
	import flash.display.MovieClip;
	import coc.model.GameModel;
	import coc.view.MainView;
	import classes.DefaultDict;

	public class TestMainView extends MovieClip {
		public var mainView :MainView;
		public var gameModel :GameModel;

		public function TestMainView() :void {
			// This variable is used to maintain a reference to the Test's
			// this in unbound functions.
			var testThis :TestMainView = this;

			this.gameModel = new GameModel();
			this.mainView = new MainView( this.gameModel );
			this.stage.addChild( this.mainView );

			this.gameModel.flags = new DefaultDict();

			trace( "MainView:", this.mainView );

			this.gameModel.flags[kFLAGS. 273 ] = 0;
			this.mainView.selectSprite( 2 );

			// TODO: put in actual callbacks here because that be how we do, now.
			this.mainView.setButton( 0, 'Lol' );
			this.mainView.setButton( 4, 'Poop' );
			this.mainView.setButton( 6, 'Penis' );
			this.mainView.setButton( 9, 'Clear Buttons' );
			this.mainView.setButton( 8, '' );

			trace( "test: hasButton( 'Lol' )?\n\t",
				this.mainView.hasButton( 'Lol' ), "(Should be 'true')" );

			trace( "test: indexOfButtonWithLabel( 'Poop' )?\n\t",
				this.mainView.indexOfButtonWithLabel( 'Poop' ), "(Should be '4')" );

			trace( "test: getButtonText( 6 ) =>\n\t",
				this.mainView.getButtonText( 6 ), "(Should be 'Penis')" );

			trace( "test: buttonTextIsOneOf( 6, [ 'Peepee', 'Dingaling', 'Penis', 'Cock', 'Doodle', 'Dick', 'Sausage' ] )\n\t",
				this.mainView.buttonTextIsOneOf( 6, [ 'Peepee', 'Dingaling', 'Penis', 'Cock', 'Doodle', 'Dick', 'Sausage' ] ),
				"(Should be 'true')" );

			trace( "test: buttonIsVisible( 0 ) =>\n\t",
				this.mainView.buttonIsVisible( 0 ),
				"(Should be 'true')" );

			trace( "test: buttonIsVisible( 8 ) =>\n\t",
				this.mainView.buttonIsVisible( 8 ),
				"(Should be 'false')" );

			trace( "test: menuButtonHasLabel( 'newGame', 'New Game' )?\n\t",
				this.mainView.menuButtonHasLabel( 'newGame', 'New Game' ),
				"(Should be 'true')" );

			function makeButtonTracer( name :String ) :Function {
				return function( event ) {
					trace( "You pressed the", name, "button!" );
				};
			}

			this.mainView.onNewGameClick = makeButtonTracer( "NewGame" );
			this.mainView.onDataClick = makeButtonTracer( "Data" );
			this.mainView.onStatsClick = makeButtonTracer( "Stats" );
			this.mainView.onLevelClick = makeButtonTracer( "Level" );
			this.mainView.onPerksClick = makeButtonTracer( "Perks" );
			this.mainView.onAppearanceClick = makeButtonTracer( "Appearance" );

			this.mainView.setButton( 2, 'Hide Menu' );
			this.mainView.setButton( 3, 'Show Menu' );
		};
	}
}