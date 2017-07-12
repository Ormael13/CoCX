/**
 * ...
 * @author Zevos
 */
package classes.Scenes.Places.HeXinDao 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.internals.*;
	import classes.Scenes.Places.HeXinDao.IgnisArenaSeerScene;

	public class IgnisArenaSeer extends Monster
	{
		public var ignisfight:IgnisArenaSeerScene = new IgnisArenaSeerScene();
		
		public function IgnisCastsNuke():void {
			outputText("Ignis raises his palm, a orb of fire appearing above it.  Then without warning, the fire radiates out with the force of an explosion! You are buffeted by wave after wave of flames, burning hotter than you could have ever imagined. ");
			if (player.findPerk(PerkLib.SoulSprite) > 0 || player.findPerk(PerkLib.Archmage) > 0) outputText("You try and cast makeshift defenses around yourself, with limited success. ");
			outputText("You try and huddle down and take shelter from the infernal storm, but the fire is everywhere. Then, as suddenly as the flame came, they are gone.\n\n");
			this.createStatusEffect(StatusEffects.IgnisCastedNuke, 0, 0, 0, 0);
			var damage:Number = 15000;
			if (player.findPerk(PerkLib.SoulSprite) > 0 || player.findPerk(PerkLib.Archmage) > 0) damage -= 10000;
			if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				player.removeStatusEffect(StatusEffects.Blizzard);
				damage *= 0.5;
			}
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
			damage = Math.round(damage);
			player.takeDamage(damage, true);
		}
		
		public function IgnisCastsFoxFire():void {
			outputText("Holding out his palm, Ignis conjures a blaze of blue flames, dancing across his palm. He casts the flame towards you, the flames twisting mid air to foil your attempts to dodge them.  On contact, the azure fires burst like fireworks, covering the area around you with color and light. ");
			var damage:int = (inte/3 + rand(inte/2));
			if (inte >= 21 && inte < 41) damage += (inte / 2 + rand((inte * 3) / 4));
			if (inte >= 41 && inte < 61) damage += ((inte * 2) / 3 + rand(inte));
			if (inte >= 61 && inte < 81) damage += ((inte * 5) / 6 + rand(inte * 1.25));
			if (inte >= 81 && inte < 101) damage += (inte + rand(inte * 1.5));
			if (inte >= 101 && inte < 151) damage += ((inte * 1.25) + rand(inte * 1.75));
			if (inte >= 151 && inte < 201) damage += ((inte * 1.5) + rand(inte * 2));
			if (inte >= 201 && inte < 251) damage += ((inte * 1.75) + rand(inte * 2.25));
			if (inte >= 251 && inte < 301) damage += ((inte * 2) + rand(inte * 2.5));
			if (inte >= 301) damage += ((inte * 2.25) + rand(inte * 2.75));
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
			damage = Math.round(damage);
			player.takeDamage(damage, true);
			outputText(" ");
			var lustDmg:Number = player.lustVuln * ((this.inte / 10) + rand(player.lib + player.cor) / 5);
			lustDmg = Math.round(lustDmg);
			game.dynStats("lus", lustDmg, "resisted", false);
			if (!hasStatusEffect(StatusEffects.IgnisCounter)) createStatusEffect(StatusEffects.IgnisCounter, 1, 0, 0, 0);
			else addStatusValue(StatusEffects.IgnisCounter, 1, 1);
		}
		
		public function IgnisCastsComet():void {
			outputText("Ignis raises a hand, focusing with intensity.  From above comes a crystalline meteor, which you barely manage to dodge.  The crystal shatters upon contact with the ground, sending a shower of splinters that you cannot avoid. ");
			if (player.armorPerk == "Heavy" || player.armorPerk == "Ayo") outputText("Thankfully, your armor manages to absorb most of the impact. ");
			var damage:int = (inte/3 + rand(inte/2));
			if (inte >= 21 && inte < 41) damage += (inte / 2 + rand((inte * 3) / 4));
			if (inte >= 41 && inte < 61) damage += ((inte * 2) / 3 + rand(inte));
			if (inte >= 61 && inte < 81) damage += ((inte * 5) / 6 + rand(inte * 1.25));
			if (inte >= 81 && inte < 101) damage += (inte + rand(inte * 1.5));
			if (inte >= 101 && inte < 151) damage += ((inte * 1.25) + rand(inte * 1.75));
			if (inte >= 151 && inte < 201) damage += ((inte * 1.5) + rand(inte * 2));
			if (inte >= 201 && inte < 251) damage += ((inte * 1.75) + rand(inte * 2.25));
			if (inte >= 251 && inte < 301) damage += ((inte * 2) + rand(inte * 2.5));
			if (inte >= 301) damage += ((inte * 2.25) + rand(inte * 2.75));
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
			if (player.armorPerk != "Heavy" || player.armorPerk != "Ayo") damage *= 2;
			damage = Math.round(damage);
			player.takeDamage(damage, true);
			removeStatusEffect(StatusEffects.IgnisCounter);
		}
		
		override protected function performCombatAction():void
		{
			if (!this.hasStatusEffect(StatusEffects.IgnisCastedNuke)) IgnisCastsNuke();
			else {
				if (this.statusEffectv1(StatusEffects.IgnisCounter) > 2) IgnisCastsComet();
				else IgnisCastsFoxFire();
			}
			combatRoundOver();
		}
		/*
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			ignisfight.PCisBeatenByIgnisATarena();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			ignisfight.PCbeatenIgnisATarena();
		}
		*/
		public function IgnisArenaSeer() 
		{
			this.a = "";
			this.short = "Ignis, the Seer of the Arena";
			this.imageName = "ignis";
			this.long = "You’re facing Ignis, a kitsune seer.   The white furred kitsune is wearing a {hp<50:torn }grey kimono, flickering with magical flames. {Charged armor known:It seems Ignis is using a variant of charged armor. }Ignis’ left hand is lit up by an aura of blue flames, ready to flare up into gouts of foxfire at a moment’s notice. In his right hand is his metal staff, foxfire burning at it’s tip.";
			// this.plural = false;
			this.createCock(15,2.5,CockTypesEnum.FOX);
			this.balls = 2;
			this.ballSize = 4;
			this.cumMultiplier = 6;
			this.hoursSinceCum = 400;
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = rand(24) + 60;
			this.hipRating = HIP_RATING_SLENDER;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skinTone = "white";
			this.hairColor = "silver";
			this.hairLength = 13 + rand(20);
			initStrTouSpeInte(35, 55, 110, 105);
			initLibSensCor(60, 65, 45);
			this.weaponName = "staff";
			this.weaponVerb="smack";
			this.weaponAttack = 8 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "grey kimono";
			this.armorDef = 5 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 120;
			this.bonusLust = 20;
			this.lust = 20;
			this.lustVuln = 0.9;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 45;//mają wtedy tylko 2 ogony ale z czasem jak PC też rośnie w siłe z lvl-em bdą mieć awans to lvl może 18-20 i trzeci ogon plus wzmocnienie statów itp.
			this.gems = rand(20) + 20;
			this.drop = new WeightedDrop().
					add(consumables.MG_SFRP,1).
					add(consumables.FOXJEWL,4);
			this.tailType = TAIL_TYPE_FOX;
			this.str += 7 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 11 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 22 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 1460;//50hp x i 30% boost do statów
			checkMonster();
		}
		
	}

}