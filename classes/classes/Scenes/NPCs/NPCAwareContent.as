/**
 * Created by aimozg on 08.01.14.
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.Scenes.FollowerInteractions;
import classes.Scenes.Places.TelAdre;
import classes.Scenes.SceneLib;

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
			return SceneLib.telAdre;
		}
		// Follower interactions
		protected function get finter():FollowerInteractions
		{
			return SceneLib.followerInteractions;
		}

		// Amily
		protected function get amilyScene():AmilyScene
		{
			return SceneLib.amilyScene;
		}

		public function amilyFollower():Boolean
		{
			return SceneLib.amilyScene.amilyFollower();
		}
		// Anemone
		protected function get anemoneScene():AnemoneScene
		{
			return SceneLib.anemoneScene;
		}
		// Arian
		protected function get arianScene():ArianScene
		{
			return SceneLib.arianScene;
		}
		public function arianFollower():Boolean
		{
			return SceneLib.arianScene.arianFollower();
		}
		// Celess
		protected function get celessScene():CelessScene
		{
			return CelessScene.instance;
		}
		// Ceraph
		protected function get ceraphScene():CeraphScene
		{
			return SceneLib.ceraphScene;
		}
		protected function get ceraphFollowerScene():CeraphFollowerScene
		{
			return SceneLib.ceraphFollowerScene;
		}
		public function ceraphIsFollower():Boolean
		{
			return SceneLib.ceraphFollowerScene.ceraphIsFollower();
		}
		// Ember
		protected function get emberScene():EmberScene
		{
			return SceneLib.emberScene;
		}
		public function followerEmber():Boolean
		{
			return SceneLib.emberScene.followerEmber();
		}
		public function emberMF(man:String,woman:String):String
		{
			return SceneLib.emberScene.emberMF(man,woman);
		}
		// Ayayayane
		protected function get ayaneFollower():AyaneFollower{
			return SceneLib.ayaneFollower;
		}
		public function followerAyane():Boolean{
			return SceneLib.ayaneFollower.followerAyane();
		}
		// Exgartuan
		protected function get exgartuan():Exgartuan
		{
			return SceneLib.exgartuan;
		}
		// Forgefather
		protected function get ForgeFather():Forgefather
		{
			return SceneLib.forgefatherScene;
		}
		// Helia
		protected function get helScene():HelScene
		{
			return SceneLib.helScene;
		}
		protected function get helFollower():HelFollower
		{
			return SceneLib.helFollower;
		}
		public function followerHel():Boolean
		{
			return SceneLib.helScene.followerHel();
		}
		// Helia spawn
		protected function get helSpawnScene():HelSpawnScene
		{
			return SceneLib.helSpawnScene;
		}

		public function helPregnant():Boolean
		{
			return SceneLib.helSpawnScene.helPregnant();
		}
		public function helspawnFollower():Boolean
		{
			return SceneLib.helSpawnScene.helspawnFollower();
		}

		// Holli
		protected function get holliScene():HolliScene
		{
			return SceneLib.holliScene;
		}
		// Isabella
		protected function get isabellaScene():IsabellaScene
		{
			return SceneLib.isabellaScene;
		}
		protected function get isabellaFollowerScene():IsabellaFollowerScene
		{
			return SceneLib.isabellaFollowerScene;
		}

		public function isabellaFollower():Boolean
		{
			return SceneLib.isabellaFollowerScene.isabellaFollower();
		}

		public function isabellaAccent():Boolean
		{
			return SceneLib.isabellaFollowerScene.isabellaAccent();
		}

		// Izma
		public function izmaFollower():Boolean
		{
			return SceneLib.izmaScene.izmaFollower();
		}
		protected function get izmaScene():IzmaScene
		{
			return SceneLib.izmaScene;
		}
		// Jojo
		protected function get jojoScene():JojoScene
		{
			return SceneLib.jojoScene;
		}
		protected function get joyScene():JoyScene
		{
			return SceneLib.joyScene;
		}
		protected function get monk():Number {
			return JojoScene.monk;
		}
		public function campCorruptJojo():Boolean
		{
			return SceneLib.jojoScene.campCorruptJojo();
		}
		// Kiha
		protected function get kihaFollower():KihaFollower
		{
			return SceneLib.kihaFollower;
		}
		protected function get kihaScene():KihaScene
		{
			return SceneLib.kihaScene;
		}

		public function followerKiha():Boolean
		{
			return SceneLib.kihaFollower.followerKiha();
		}

		// Latex Girl
		protected function get latexGirl():LatexGirl
		{
			return SceneLib.latexGirl;
		}
		public function latexGooFollower():Boolean
		{
			return SceneLib.latexGirl.latexGooFollower();
		}
		// Marble
		protected function get marbleScene():MarbleScene
		{
			return SceneLib.marbleScene;
		}
		protected function get marblePurification():MarblePurification
		{
			return SceneLib.marblePurification;
		}
		public function marbleFollower():Boolean
		{
			return SceneLib.marbleScene.marbleFollower();
		}
		// Milk slave
		public function milkSlave():Boolean
		{
			return SceneLib.milkWaifu.milkSlave();
		}
		protected function get milkWaifu():MilkWaifu
		{
			return SceneLib.milkWaifu;
		}
		// Raphael
		protected function raphael():Raphael
		{
			return SceneLib.raphael;
		}
		public function RaphaelLikes():Boolean
		{
			return SceneLib.raphael.RaphaelLikes();
		}
		// Rathazul
		protected function rathazul():Rathazul
		{
			return SceneLib.rathazul;
		}
		// Sheila
		protected function get sheilaScene():SheilaScene
		{
			return SceneLib.sheilaScene;
		}
		// Shouldra
		protected function get shouldraFollower():ShouldraFollower
		{
			return SceneLib.shouldraFollower;
		}

		protected function get shouldraScene():ShouldraScene
		{
			return SceneLib.shouldraScene;
		}

		public function followerShouldra():Boolean
		{
			return SceneLib.shouldraFollower.followerShouldra();
		}

		// Sophie
		protected function get sophieBimbo():SophieBimbo
		{
			return SceneLib.sophieBimbo;
		}
		protected function get sophieScene():SophieScene
		{
			return SceneLib.sophieScene;
		}

		protected function get sophieFollowerScene():SophieFollowerScene
		{
			return SceneLib.sophieFollowerScene;
		}

		public function bimboSophie():Boolean
		{
			return SceneLib.sophieBimbo.bimboSophie();
		}

		public function sophieFollower():Boolean
		{
			return SceneLib.sophieFollowerScene.sophieFollower();
		}
		// Urta
		public function urtaLove(love:Number = 0):Boolean {
			return SceneLib.urta.urtaLove(love);
		}
		protected function get urta():Urta
		{
			return SceneLib.urta;
		}
		protected function get urtaPregs():UrtaPregs
		{
			return SceneLib.urtaPregs;
		}
		protected function get urtaHeatRut():UrtaHeatRut
		{
			return SceneLib.urtaHeatRut;
		}
		// Valeria
		protected function get valeria():ValeriaScene
		{
			return SceneLib.valeria;
		}
		// Vapula
		protected function get vapula():Vapula
		{
			return SceneLib.vapula;
		}
		public function vapulaSlave():Boolean
		{
			return SceneLib.vapula.vapulaSlave();
		}
	}
}