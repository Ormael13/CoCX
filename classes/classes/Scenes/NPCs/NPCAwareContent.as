/**
 * Created by aimozg on 08.01.14.
 */
package classes.Scenes.NPCs
{
	import classes.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.FollowerInteractions;
	import classes.Scenes.Places.TelAdre;

	/**
	 * Contains handy references to scenes and methods
	 */
	public class NPCAwareContent extends BaseContent
	{
		public function NPCAwareContent()
		{

		}
		// Common scenes
		protected function get telAdre():TelAdre
		{
			return kGAMECLASS.telAdre;
		}
		// Follower interactions
		protected function get finter():FollowerInteractions
		{
			return kGAMECLASS.followerInteractions;
		}

		// Amily
		protected function get amilyScene():AmilyScene
		{
			return kGAMECLASS.amilyScene;
		}

		public function amilyFollower():Boolean
		{
			return kGAMECLASS.amilyScene.amilyFollower();
		}
		// Anemone
		protected function get anemoneScene():AnemoneScene
		{
			return kGAMECLASS.anemoneScene;
		}
		// Arian
		protected function get arianScene():ArianScene
		{
			return kGAMECLASS.arianScene;
		}
		public function arianFollower():Boolean
		{
			return kGAMECLASS.arianScene.arianFollower();
		}
		// Ceraph
		protected function get ceraphScene():CeraphScene
		{
			return kGAMECLASS.ceraphScene;
		}
		protected function get ceraphFollowerScene():CeraphFollowerScene
		{
			return kGAMECLASS.ceraphFollowerScene;
		}
		public function ceraphIsFollower():Boolean
		{
			return kGAMECLASS.ceraphFollowerScene.ceraphIsFollower();
		}
		// Ember
		protected function get emberScene():EmberScene
		{
			return kGAMECLASS.emberScene;
		}
		public function followerEmber():Boolean
		{
			return kGAMECLASS.emberScene.followerEmber();
		}
		public function emberMF(man:String,woman:String):String
		{
			return kGAMECLASS.emberScene.emberMF(man,woman);
		}
		// Exgartuan
		protected function get exgartuan():Exgartuan
		{
			return kGAMECLASS.exgartuan;
		}
		// Helia
		protected function get helScene():HelScene
		{
			return kGAMECLASS.helScene;
		}
		protected function get helFollower():HelFollower
		{
			return kGAMECLASS.helFollower;
		}
		public function followerHel():Boolean
		{
			return kGAMECLASS.helScene.followerHel();
		}
		// Helia spawn
		protected function get helSpawnScene():HelSpawnScene
		{
			return kGAMECLASS.helSpawnScene;
		}

		public function helPregnant():Boolean
		{
			return kGAMECLASS.helSpawnScene.helPregnant();
		}
		public function helspawnFollower():Boolean
		{
			return kGAMECLASS.helSpawnScene.helspawnFollower();
		}

		// Holli
		protected function get holliScene():HolliScene
		{
			return kGAMECLASS.holliScene;
		}
		// Isabella
		protected function get isabellaScene():IsabellaScene
		{
			return kGAMECLASS.isabellaScene;
		}
		protected function get isabellaFollowerScene():IsabellaFollowerScene
		{
			return kGAMECLASS.isabellaFollowerScene;
		}

		public function isabellaFollower():Boolean
		{
			return kGAMECLASS.isabellaFollowerScene.isabellaFollower();
		}

		public function isabellaAccent():Boolean
		{
			return kGAMECLASS.isabellaFollowerScene.isabellaAccent();
		}

		// Izma
		public function izmaFollower():Boolean
		{
			return kGAMECLASS.izmaScene.izmaFollower();
		}
		protected function get izmaScene():IzmaScene
		{
			return kGAMECLASS.izmaScene;
		}
		// Jojo
		protected function get jojoScene():JojoScene
		{
			return kGAMECLASS.jojoScene;
		}
		protected function get joyScene():JoyScene
		{
			return kGAMECLASS.joyScene;
		}
		protected function get monk():Number {
			return kGAMECLASS.monk;
		}
		public function campCorruptJojo():Boolean
		{
			return kGAMECLASS.jojoScene.campCorruptJojo();
		}
		// Kiha
		protected function get kihaFollower():KihaFollower
		{
			return kGAMECLASS.kihaFollower;
		}
		protected function get kihaScene():KihaScene
		{
			return kGAMECLASS.kihaScene;
		}

		public function followerKiha():Boolean
		{
			return kGAMECLASS.kihaFollower.followerKiha();
		}

		// Latex Girl
		protected function get latexGirl():LatexGirl
		{
			return kGAMECLASS.latexGirl;
		}
		public function latexGooFollower():Boolean
		{
			return kGAMECLASS.latexGirl.latexGooFollower();
		}
		// Marble
		protected function get marbleScene():MarbleScene
		{
			return kGAMECLASS.marbleScene;
		}
		protected function get marblePurification():MarblePurification
		{
			return kGAMECLASS.marblePurification;
		}
		public function marbleFollower():Boolean
		{
			return kGAMECLASS.marbleScene.marbleFollower();
		}
		// Milk slave
		public function milkSlave():Boolean
		{
			return kGAMECLASS.milkWaifu.milkSlave();
		}
		protected function get milkWaifu():MilkWaifu
		{
			return kGAMECLASS.milkWaifu;
		}
		// Raphael
		protected function raphael():Raphael
		{
			return kGAMECLASS.raphael;
		}
		public function RaphaelLikes():Boolean
		{
			return kGAMECLASS.raphael.RaphaelLikes();
		}
		// Rathazul
		protected function rathazul():Rathazul
		{
			return kGAMECLASS.rathazul;
		}
		// Sheila
		protected function get sheilaScene():SheilaScene
		{
			return kGAMECLASS.sheilaScene;
		}
		// Shouldra
		protected function get shouldraFollower():ShouldraFollower
		{
			return kGAMECLASS.shouldraFollower;
		}

		protected function get shouldraScene():ShouldraScene
		{
			return kGAMECLASS.shouldraScene;
		}

		public function followerShouldra():Boolean
		{
			return kGAMECLASS.shouldraFollower.followerShouldra();
		}

		// Sophie
		protected function get sophieBimbo():SophieBimbo
		{
			return kGAMECLASS.sophieBimbo;
		}
		protected function get sophieScene():SophieScene
		{
			return kGAMECLASS.sophieScene;
		}

		protected function get sophieFollowerScene():SophieFollowerScene
		{
			return kGAMECLASS.sophieFollowerScene;
		}

		public function bimboSophie():Boolean
		{
			return kGAMECLASS.sophieBimbo.bimboSophie();
		}

		public function sophieFollower():Boolean
		{
			return kGAMECLASS.sophieFollowerScene.sophieFollower();
		}
		// Urta
		public function urtaLove(love:Number = 0):Boolean {
			return kGAMECLASS.urta.urtaLove(love);
		}
		protected function get urta():Urta
		{
			return kGAMECLASS.urta;
		}
		protected function get urtaPregs():UrtaPregs
		{
			return kGAMECLASS.urtaPregs;
		}
		protected function get urtaHeatRut():UrtaHeatRut
		{
			return kGAMECLASS.urtaHeatRut;
		}
		// Valeria
		protected function get valeria():Valeria
		{
			return kGAMECLASS.valeria;
		}
		// Vapula
		protected function get vapula():Vapula
		{
			return kGAMECLASS.vapula;
		}
		public function vapulaSlave():Boolean
		{
			return kGAMECLASS.vapula.vapulaSlave();
		}

	}
}
