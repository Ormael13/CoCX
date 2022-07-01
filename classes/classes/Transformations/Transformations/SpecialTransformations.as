package classes.Transformations.Transformations {
import classes.BodyParts.*;
import classes.GeneticMemories.SpecialsMem;
import classes.Items.MutationsHelper;
import classes.PerkLib;
import classes.Races.MantisRace;
import classes.Scenes.Metamorph;
import classes.Transformations.*;

/**
 * Base class for transformation events.
 */
public class SpecialTransformations extends MutationsHelper {
	/*
    * 	   █████  ████████ ██    ██ ██████ ██████
    *  	 ██    ██    ██    ██    ██ ██     ██   ██
    *  	 ██    ██    ██    ████████ █████  ██████
    *  	 ██    ██    ██    ██    ██ ██     ██   ██
    *  	  ██████     ██    ██    ██ ██████ ██   ██
    */

	/*
        */
	public const RemoveOvipositor:Transformation = new SimpleTransformation("Remove Oviposition",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "[pg]";

				if (player.hasPerk(PerkLib.SpiderOvipositor)) { //Remove dat shit!
					desc += "<b>Your ovipositor (and eggs) vanish since your body has become less spider-like.</b>";
					player.removePerk(PerkLib.SpiderOvipositor);
				}
				else if (player.hasPerk(PerkLib.BeeOvipositor)) { //Remove dat shit!
					desc += "<b>Your ovipositor (and eggs) vanish since your body has become less bee-like.</b>";
					player.removePerk(PerkLib.BeeOvipositor);
				}
				else if (player.hasPerk(PerkLib.MantisOvipositor)) { //Remove dat shit!
					desc += "<b>Your ovipositor (and eggs) vanish since your body has become less mantis-like.</b>";
					player.removePerk(PerkLib.MantisOvipositor);
				}
				else if (player.hasPerk(PerkLib.AntOvipositor)) { //Remove dat shit!
					desc += "<b>Your ovipositor (and eggs) vanish since your body has become less ant-like.</b>";
					player.removePerk(PerkLib.AntOvipositor);
				}

				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return !player.hasPerk(PerkLib.BeeOvipositor) && !player.hasPerk(PerkLib.SpiderOvipositor) && !player.hasPerk(PerkLib.MantisOvipositor) && !player.hasPerk(PerkLib.AntOvipositor);
			},
			// is possible
			function ():Boolean {
				return ((player.hasPerk(PerkLib.SpiderOvipositor) && (!player.isDrider() || player.tailType != Tail.SPIDER_ADBOMEN)) ||
						(player.hasPerk(PerkLib.BeeOvipositor) && player.tailType != Tail.BEE_ABDOMEN) ||
						(player.hasPerk(PerkLib.MantisOvipositor) && player.tailType != Tail.MANTIS_ABDOMEN) ||
						(player.hasPerk(PerkLib.AntOvipositor) && player.tailType != Tail.ANT_ABDOMEN));
			}
	);

	public const GainOvipositor:Transformation = new SimpleTransformation("Remove Oviposition",
			// apply
			function (doOutput:Boolean):void {
				if (player.tailType === Tail.BEE_ABDOMEN)
					TransformationUtils.applyTFIfNotPresent(transformations.OvipositorBee, doOutput);
				if (player.tailType === Tail.SPIDER_ADBOMEN)
					TransformationUtils.applyTFIfNotPresent(transformations.OvipositorSpider, doOutput);
				if (player.tailType === Tail.MANTIS_ABDOMEN)
					TransformationUtils.applyTFIfNotPresent(transformations.OvipositorMantis, doOutput);
				if (player.tailType === Tail.ANT_ABDOMEN)
					TransformationUtils.applyTFIfNotPresent(transformations.OvipositorAnt, doOutput);
			},
			// is present
			function ():Boolean {
				return !InCollection(player.tailType, Tail.BEE_ABDOMEN, Tail.SPIDER_ADBOMEN, Tail.MANTIS_ABDOMEN) ||
						player.hasPerk(PerkLib.SpiderOvipositor) || player.hasPerk(PerkLib.BeeOvipositor) || player.hasPerk(PerkLib.MantisOvipositor);
			}
	);

	public const OvipositorBee:Transformation = new SimpleTransformation("Bee Oviposition",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.RemoveOvipositor, doOutput);
				TransformationUtils.applyTFIfNotPresent(transformations.TailBee, doOutput);

				outputText("\n\nAn odd swelling starts in your insectile abdomen, somewhere along the underside.  Curling around, you reach back to your extended, bulbous bee part and run your fingers along the underside.  You gasp when you feel a tender, yielding slit near the stinger.  As you probe this new orifice, a shock of pleasure runs through you, and a tubular, black, semi-hard appendage drops out, pulsating as heavily as any sexual organ.  <b>The new organ is clearly an ovipositor!</b>  A few gentle prods confirm that it's just as sensitive; you can already feel your internals changing, adjusting to begin the production of unfertilized eggs.  You idly wonder what laying them with your new bee ovipositor will feel like...");
				outputText("\n\n(<b>Perk Gained:  Bee Ovipositor - Allows you to lay eggs in your foes!</b>)");
				player.createPerk(PerkLib.BeeOvipositor, 0, 0, 0, 0);

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SpecialsMem.getMemory(SpecialsMem.OVIPOSITOR));
			},
			// is present
			function ():Boolean {
				return player.hasPerk(PerkLib.BeeOvipositor);
			},
			// is possible
			function ():Boolean {
				return !player.hasPerk(PerkLib.BeeOvipositor) && player.tailType == Tail.BEE_ABDOMEN;
			}
	);

	public const OvipositorSpider:Transformation = new SimpleTransformation("Spider Oviposition",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.RemoveOvipositor, doOutput);
				TransformationUtils.applyTFIfNotPresent(transformations.TailSpider, doOutput);
				TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyDrider, doOutput);

				desc += "[pg]An odd swelling sensation floods your spider half.  Curling your abdomen underneath you for a better look, you gasp in recognition at your new 'equipment'!  Your semi-violent run-ins with the swamp's population have left you <i>intimately</i> familiar with the new appendage.  <b>It's a drider ovipositor!</b>  A few light prods confirm that it's just as sensitive as any of your other sexual organs.  You idly wonder what laying eggs with this thing will feel like..."+
						"[pg](<b>Perk Gained:  Spider Ovipositor - Allows you to lay eggs in your foes!</b>)";
				//V1 - Egg Count
				//V2 - Fertilized Count
				player.createPerk(PerkLib.SpiderOvipositor, 0, 0, 0, 0);

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SpecialsMem.getMemory(SpecialsMem.OVIPOSITOR));
			},
			// is present
			function ():Boolean {
				return player.hasPerk(PerkLib.SpiderOvipositor);
			},
			// is possible
			function ():Boolean {
				return !player.hasPerk(PerkLib.SpiderOvipositor) && player.isDrider() && player.tailType == Tail.SPIDER_ADBOMEN;
			}
	);

	public const OvipositorMantis:Transformation = new SimpleTransformation("Mantis Oviposition",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.RemoveOvipositor, doOutput);
				TransformationUtils.applyTFIfNotPresent(transformations.SkinChitin(Skin.COVERAGE_LOW, {colors: MantisRace.MantisChitinColors}), doOutput);
				TransformationUtils.applyTFIfNotPresent(transformations.TailMantis, doOutput);

				desc +="[pg]An odd swelling starts in your insectile abdomen, somewhere along the underside.  Curling around, you reach back to your extended, bulbous mantis part and run your fingers along the underside.  You gasp when you feel a tender, yielding slit near the end.  As you probe this new orifice, a shock of pleasure runs through you, and a tubular, green, semi-hard appendage drops out, pulsating as heavily as any sexual organ.  <b>The new organ is clearly an ovipositor!</b>  A few gentle prods confirm that it's just as sensitive; you can already feel your internals changing, adjusting to begin the production of unfertilized eggs.  You idly wonder what laying them with your new mantis ovipositor will feel like..."+
						"[pg](<b>Perk Gained:  Mantis Ovipositor - Allows you to lay eggs in your foes!</b>)";
				player.createPerk(PerkLib.MantisOvipositor, 0, 0, 0, 0);

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SpecialsMem.getMemory(SpecialsMem.OVIPOSITOR));
			},
			// is present
			function ():Boolean {
				return player.hasPerk(PerkLib.MantisOvipositor);
			},
			// is possible
			function ():Boolean {
				return player.hasCoatOfType(Skin.CHITIN) && !player.hasPerk(PerkLib.MantisOvipositor) && player.tailType == Tail.MANTIS_ABDOMEN;
			}
	);

	public const OvipositorAnt:Transformation = new SimpleTransformation("Mantis Oviposition",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.RemoveOvipositor, doOutput);
				TransformationUtils.applyTFIfNotPresent(transformations.TailAnt, doOutput);

				outputText("[pg]An odd swelling starts in your insectile abdomen, somewhere along the underside.  Curling around, you reach back to your extended, bulbous ant part and run your fingers along the underside.  You gasp when you feel a tender, yielding slit near the end.  As you probe this new orifice, a shock of pleasure runs through you, and a tubular, tan, semi-hard appendage drops out, pulsating as heavily as any sexual organ.  <b>The new organ is clearly an ovipositor!</b>  A few gentle prods confirm that it's just as sensitive; you can already feel your internals changing, adjusting to begin the production of unfertilized eggs.  You idly wonder what laying them with your new ant ovipositor will feel like...");
				outputText("\n\n(<b>Perk Gained:  Ant Ovipositor - Allows you to lay eggs in your foes!</b>)");
				player.createPerk(PerkLib.AntOvipositor, 0, 0, 0, 0);

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SpecialsMem.getMemory(SpecialsMem.OVIPOSITOR));
			},
			// is present
			function ():Boolean {
				return player.hasPerk(PerkLib.AntOvipositor);
			},
			// is possible
			function ():Boolean {
				return !player.hasPerk(PerkLib.AntOvipositor) && player.tailType == Tail.ANT_ABDOMEN;
			}
	);


	/*
*/
}
}
