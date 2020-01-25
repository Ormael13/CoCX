/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Explore 
{
import classes.*;
import classes.GlobalFlags.*;
import classes.Appearance;
import classes.BodyParts.*;
import classes.BreastRowClass;
import classes.Cock;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.SceneLib;
import classes.VaginaClass;


	public class RNGod extends Monster
	{
		
		
		public function RNGod() 
		{
			this.a = " ";
			this.short = "RNGod";
			this.long = "You’re facing RNGod. As randomness of it telling " + player.mf("he", "she") +"'s probably stronger than you so why fight " + player.mf("him", "her") +"? Some rumors say that " + player.mf("he", "she") +"'s Lady Godiva parent. Crazy isn't it?";
			this.plural = false;
			this.tallness = player.tallness;
			if (player.balls > 0)
			{
				this.balls = player.balls;
				this.ballSize = player.ballSize;
			}
			else
			{
				this.balls = 0;
				this.ballSize = 0;
			}
			this.hoursSinceCum = player.hoursSinceCum;
			hips.type = player.hips.type;
			if (hips.type < 1) hips.type = 1;
			butt.type = player.butt.type;
			if (butt.type < 1) butt.type = 1;
			lowerBody = player.lowerBody;
			skinDesc = player.skinDesc;
			initStrTouSpeInte(player.str + rand(player.str), player.tou + rand(player.tou), player.spe + rand(player.spe), player.inte + rand(player.inte));
			initWisLibSensCor(player.wis + rand(player.wis), player.lib + rand(player.lib), player.sens + rand(player.sens), player.cor);
			this.weaponName = player.weaponName;
			this.weaponAttack = player.weaponAttack + rand(player.weaponAttack);
			this.weaponVerb = player.weaponVerb;
			this.armorDef = player.armorDef + rand(player.armorDef);
			this.armorMDef = player.armorMDef + rand(player.armorMDef);
			this.armorName = player.armorName;
			this.bonusHP = 500 * (1 + rand(10));
			this.bonusLust = 20 * (1 + rand(10));
			this.bonusMana = 100 * (1 + rand(10));
			this.bonusSoulforce = 100 * (1 + rand(10));
			this.lustVuln = 0.1 * (1 + rand(10));
			this.lust = 20;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = player.level + rand(11);
			this.ass.analLooseness = player.ass.analLooseness;
			this.ass.analWetness = player.ass.analWetness;
			if (player.cocks.length > 0)
			{
				for (var i:int = 0; i < player.cocks.length; i++)
				{
					this.createCock((player.cocks[i] as Cock).cockLength, (player.cocks[i] as Cock).cockThickness, (player.cocks[i] as Cock).cockType);
				}
			}
			if (player.vaginas.length > 0)
			{
				this.createVagina();
				(this.vaginas[0] as VaginaClass).vaginalLooseness = player.vaginas[0].vaginalLooseness;
				(this.vaginas[0] as VaginaClass).vaginalWetness = player.vaginas[0].vaginalWetness;
				(this.vaginas[0] as VaginaClass).virgin = player.vaginas[0].virgin;
			}
			//Genderless get forced to have a cunny
			if (player.vaginas.length == 0 && player.cocks.length == 0)
			{
				this.createVagina();
				(this.vaginas[0] as VaginaClass).vaginalLooseness = 2;
				(this.vaginas[0] as VaginaClass).vaginalWetness = 6;
				(this.vaginas[0] as VaginaClass).virgin = false;
			}
			this.breastRows = [];
			for (i = 0; i < player.breastRows.length; i++)
			{
				this.createBreastRow();
				var tbr:BreastRowClass = this.breastRows[i];
				var sbr:BreastRowClass = player.breastRows[i];
				
				tbr.breastRating = sbr.breastRating;
				tbr.breasts = sbr.breasts;
				tbr.fuckable = sbr.fuckable;
				tbr.lactationMultiplier = sbr.lactationMultiplier;
				tbr.milkFullness = sbr.milkFullness;
				tbr.nipplesPerBreast = sbr.nipplesPerBreast;
			}
			this.pronoun1 = "[he]";
			this.pronoun2 = "[him]";
			this.pronoun3 = "[his]";
			this.gems = rand(100);
			this.drop = NO_DROP;
			this.tailType = Tail.FOX;
			this.tail.count = 9;
			this.createPerk(PerkLib.EnemyGodType, 0, 0, 0, 0);
			if (rand(2) == 0) this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			if (rand(2) == 0) this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			if (rand(2) == 0) this.createPerk(PerkLib.EnemyFeralType, 0, 0, 0, 0);
			if (rand(2) == 0) this.createPerk(PerkLib.EnemyGhostType, 0, 0, 0, 0);
			if (rand(2) == 0) this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
			if (rand(2) == 0) this.createPerk(PerkLib.EnemyGooType, 0, 0, 0, 0);
			if (rand(2) == 0) this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			if (rand(2) == 0) {
				if (rand(4) == 0) this.createPerk(PerkLib.LightningNature, 0, 0, 0, 0);
				else if (rand(3) == 0) this.createPerk(PerkLib.DarknessNature, 0, 0, 0, 0);
				else if (rand(2) == 0) this.createPerk(PerkLib.IceNature, 0, 0, 0, 0);
				else this.createPerk(PerkLib.FireNature, 0, 0, 0, 0);
			}
			checkMonster();
		}
		
	}

}