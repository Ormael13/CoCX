package classes
{
	import classes.assClass;
	import classes.breastRowClass;
	//import classes.cockClass;
	import classes.Cock;
	import classes.creature;
	import classes.itemSlotClass;
	import classes.perkClass;
	import classes.statusAffectClass;
	import classes.vaginaClass;

	import fl.controls.ComboBox; 
	import fl.data.DataProvider; 
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.*
	// import flash.events.Event;
	// import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.net.navigateToURL; 
	import flash.net.registerClassAlias;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.text.*;
	import flash.utils.ByteArray;

/****
	classes.CoC: The Document class of Corruption of the Champions.
****/
	
	public class CoC extends MovieClip
	{
		/****
			This is used purely for bodges while we get things cleaned up.
			Hopefully, anything you stick to this object can be removed eventually.
			I only used it because for some reason the Flash compiler wasn't seeing
			certain functions, even though they were in the same scope as the
			function calling them.
		****/
		public var semiglobalReferencer :* = {};

		public function CoC()
		{
			this.addFrameScript( 0, this.run );
		}

		public function run()
		{
			// big splat of include lines here...
			// These are relative to the current directory, which is /classes/classes.
			include "../../includes/akbal.as";
			include "../../includes/amily.as";
			include "../../includes/anemone.as";
			include "../../includes/ants.as";
			include "../../includes/appearance.as";
			include "../../includes/april_fools.as";
			include "../../includes/arian.as";
			include "../../includes/auntNancy.as";
			include "../../includes/bakery.as";
			include "../../includes/basilisk.as";
			include "../../includes/bazaar.as";
			include "../../includes/bee.as";
			include "../../includes/benoit.as";
			include "../../includes/brooke.as";
			include "../../includes/bunbun.as";
			include "../../includes/camp.as";
			include "../../includes/ceraph.as";
			include "../../includes/ceraphFollower.as";
			include "../../includes/chameleons.as";
			include "../../includes/charCreation.as";
			include "../../includes/customCharCreation.as";
			include "../../includes/cinnabar.as";
			include "../../includes/combat.as";
			include "../../includes/cotton.as";
			include "../../includes/descriptors.as";
			include "../../includes/doEvent.as";
			include "../../includes/dreams.as";
			include "../../includes/drider.as";
			include "../../includes/dungeon2Supplimental.as";
			include "../../includes/dungeonCore.as";
			include "../../includes/dungeonEvents.as";
			include "../../includes/dungeonHelSupplimental.as";
			include "../../includes/dungeonSandwitch.as";
			include "../../includes/edryn.as";
			include "../../includes/ember.as";
			include "../../includes/engineCore.as";
			include "../../includes/essrayle.as";
			include "../../includes/eventParser.as";
			include "../../includes/exgartuan.as";
			include "../../includes/exploration.as";
			include "../../includes/faerie.as";
			include "../../includes/fapArena.as";
			include "../../includes/fellatrix.as";
			include "../../includes/fera.as";
			include "../../includes/fetishCultist.as";
			include "../../includes/fetishZealot.as";
			include "../../includes/followerInteractions.as";
			include "../../includes/froggirl.as";
			include "../../includes/fuckingTree.as";
			include "../../includes/gangBangVillage.as";
			include "../../includes/gargoyle.as";
			include "../../includes/GlobalVariables.as";
			include "../../includes/gnoll.as";
			include "../../includes/gnoll_alternate.as";
			include "../../includes/goblin.as";
			include "../../includes/gooGirl.as";
			include "../../includes/harpy.as";
			include "../../includes/harpySophie.as";
			include "../../includes/harpySophieBimbo.as";
			include "../../includes/harpySophieFollower.as";
			include "../../includes/heckel.as";
			include "../../includes/heliaFollower.as";
			include "../../includes/heliaPreggers.as";
			include "../../includes/hellhound.as";
			include "../../includes/hellhoundInfested.as";
			include "../../includes/ifris.as";
			include "../../includes/imp.as";
			include "../../includes/InitialiseUI.as";
			include "../../includes/input.as";
			include "../../includes/isabella.as";
			include "../../includes/isabellaFollower.as";
			include "../../includes/items.as";
			include "../../includes/izma.as";
			include "../../includes/jasun.as";
			include "../../includes/jojo.as";
			include "../../includes/kaiju.as";
			include "../../includes/katherine.as";
			include "../../includes/kelly.as";
			include "../../includes/kelt.as";
			include "../../includes/kiha.as";
			include "../../includes/kihaFollower.as";
			include "../../includes/kitsunes.as";
			include "../../includes/latexy.as";
			include "../../includes/library.as";
			include "../../includes/lilium.as";
			include "../../includes/loppe.as";
			include "../../includes/lottie.as";
			include "../../includes/lumi.as";
			include "../../includes/maddie.as";
			include "../../includes/marae.as";
			include "../../includes/marble.as";
			include "../../includes/masturbation.as";
			include "../../includes/milkWaifu.as";
			include "../../includes/minerva.as";
			include "../../includes/minotaur.as";
			include "../../includes/minotaurGang.as";
			include "../../includes/naga.as";
			include "../../includes/niamh.as";
			include "../../includes/oasis.as";
			include "../../includes/OnLoadVariables.as";
			include "../../includes/ooze.as";
			include "../../includes/pregnancy.as";
			include "../../includes/Raphael.as";
			include "../../includes/rathazul.as";
			include "../../includes/rogar.as";
			include "../../includes/roxanne.as";
			include "../../includes/rubi.as";
			include "../../includes/runa.as";
			include "../../includes/salamander.as";
			include "../../includes/salon.as";
			include "../../includes/sandtrap.as";
			include "../../includes/sandwitch.as";
			include "../../includes/satyr.as";
			include "../../includes/scylla.as";
			include "../../includes/sexMachine.as";
			include "../../includes/sharkgirls.as";
			include "../../includes/sheila.as";
			include "../../includes/shouldra.as";
			include "../../includes/shouldraFollower.as";
			include "../../includes/spiderMorph.as";
			include "../../includes/spiderMorphMale.as";
			include "../../includes/startUp.as";
			include "../../includes/swordInStone.as";
			include "../../includes/symGear.as";
			include "../../includes/tamani.as";
			include "../../includes/tamaniDildo.as";
			include "../../includes/tamanisDaughters.as";
			include "../../includes/telAdre.as";
			include "../../includes/tentacle.as";
			include "../../includes/thanksgiving.as";
			include "../../includes/transform.as";
			include "../../includes/urta.as";
			include "../../includes/urtaPregs.as";
			include "../../includes/urtaQuest.as";
			include "../../includes/valaria.as";
			include "../../includes/valentines.as";
			include "../../includes/wanderer.as";
			include "../../includes/whitneyFarm.as";
			include "../../includes/worms.as";
			include "../../includes/xmas_bitch.as";
			include "../../includes/xmas_gats_not_an_angel.as";
			include "../../includes/xmas_jack_frost.as";
			include "../../includes/xmas_misc.as";


			
			include "../../includes/flagDefs.as";
			
			// we had two saves.as files. It was causing wierd issues.
			// I'm not sure how most of the files in /classes/classes/ are included
			// anyways, lets manually include it here until I read up on the include mechanics
			// of AS
			// I moved saves.as back into includes, to keep the class directories
			// free of any non-packaged files. - amygdala
			include "../../includes/saves.as";
			
			this.stop();
		}
	}
}