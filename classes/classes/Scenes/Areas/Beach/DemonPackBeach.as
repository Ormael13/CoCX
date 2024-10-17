/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Beach
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.Tail;
import classes.Items.DynamicItems;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

public class DemonPackBeach extends Monster
	{
		
		override public function teased(lustDelta:Number, isNotSilent:Boolean = true, display:Boolean = true, aura:Boolean = false):void
		{
			outputText("\n");
			if(lustDelta == 0) outputText("\n" + capitalA + short + " seems unimpressed.");
			else if(lustDelta > 0 && lustDelta < 5) outputText("The demons slightly lessen the intensity of their attacks, and some even eye your assets as they strike.");
			else if(lustDelta >= 5 && lustDelta < 10) outputText("The demons are clearly avoiding damaging anything you might use for sex, lingering their hands on you a little longer after each blow. Some are even sneaking quick gropes with their free hands, and the air is thick with the scent of demonic lust from a dozen bodies.");
			else if(lustDelta >= 10) outputText("The demons are increasingly hesitant to strike, opting instead to sensuously stroke their hands over you. The scent of demonic lust fills the air, and part of the group has stopped fighting altogether, openly stroking themselves.");
			applyTease(lustDelta, display, aura);
		}
		
		public function DemonPackBeach()
		{
			this.a = "the ";
			this.short = "beach demons";
			this.imageName = "demonmob";
			this.long= "The group consists of roughly fifty tan-skinned demons, mostly humanoid in shape but with a wide variety of corruptions. You spot demonic high heels, twisting horns, and swinging cocks of all shapes and sizes. There even seems to be a shark head among them. You also notice a variety of breasts, from small ones to a pair so large they require a second person to carry them. Below those breasts is an equally diverse array of pussies, some dripping and others dry, often paired with a demonic dick.  The small crew carries no weapons, and what little clothing they wear is tattered, except for one hefty male wearing a cloak of what appears to be snakeskin draped his broad shoulders and an eye path over his left eye.  You spot an odd patch that reads, \"<i>42nd East Sea Company: Vaginal Clearance</i>\" on his shoulder.";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createCock(18,2);
			this.createCock(18,2,CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(8) + 70;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.bodyColor = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(170, 190, 80, 40);
			initWisLibSensCor(40, 150, 80, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 69;
			this.armorName = "demonic skin";
			this.armorDef = 55;
			this.armorMDef = 10;
			this.bonusHP = 200;
			this.bonusLust = 275;
			this.lust = 30;
			this.level = 45;
			this.gems = rand(60)+20;
			this.randomDropChance = 0.1;
			this.randomDropParams = {
				rarity: DynamicItems.RARITY_CHANCES_LESSER
			};
			this.drop = new WeightedDrop().addMany(1,
							consumables.SUCMILK,
							consumables.INCUBID,
							consumables.OVIELIX,
							consumables.B__BOOK);
			this.abilities = [
				{call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[]},
				{call: SceneLib.combat.packAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{call: SceneLib.combat.lustAttack, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[]},
			];
			this.tailType = Tail.DEMONIC;
			this.horns.type = Horns.DEMON;
			this.horns.count = 2;
			this.createPerk(PerkLib.EnemyLargeGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 45, 0, 0, 0);
			checkMonster();
		}
		
	}

}
