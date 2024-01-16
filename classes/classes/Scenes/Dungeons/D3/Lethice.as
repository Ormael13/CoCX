package classes.Scenes.Dungeons.D3
{
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSpell;
import classes.Scenes.Combat.CombatAbilities;
import classes.Scenes.Combat.CombatAbility;
import classes.Scenes.SceneLib;
import classes.StatusEffectType;
import classes.StatusEffects;
import classes.internals.WeightedDrop;

import coc.view.CoCButton;

import flash.utils.Dictionary;

import mx.formatters.NumberFormatter;

public class Lethice extends Monster
	{
		public function Lethice()
		{
			this.a = "";
			this.short = "Lethice";
			this.long = "";
			this.tallness = 12 * 9;
			this.createVagina(false, 3, 3);
			this.createBreastRow(8);
			this.balls = 2;
			this.ballSize = 4;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			initStrTouSpeInte(330, 400, 200, 400);
			initWisLibSensCor(250, 220, 100, 100);
			this.weaponName = "whip";
			this.weaponAttack = 170;
			this.weaponVerb = "whip";
			this.armorName = "wraps";
			this.armorDef = 80;
			this.armorMDef = 160;
			this.bonusHP = 5000;
			this.bonusLust = 400;
			this.gems = 1200 + rand(100);
			this.additionalXP = 7000;
			this.level = 80;
			this.lustVuln = 0.15;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Diehard, 0, 0, 0, 0);
			this.createPerk(PerkLib.ImprovedDiehard, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 80, 0, 0, 0);//v1 = enemy lvl
			this.drop = new WeightedDrop(weapons.L_WHIP, 1);
			this.checkMonster();
		}
		override public function get long():String
		{
			var str:String = "";
			if (_fightPhase == 1)
			{
				str += "Lethice is the epitome of all things demonic. From her luxurious purple hair, interwoven with black roses, to her pink skin and goat-like horns, she is the perfect image of sensual, enticing corruption. Tall heels of bone complement her revealing, black clothes. They look almost like a nun’s habit, but pared down to an almost fetishistic extreme. Her slim breasts provide just a hint of shape to the diaphanous fabric, a promise of feminine delights instead of the garish acres of flesh her outfit displays. Outsized wings, like those of a dragon, hold Lethice aloft as she zips about her throne room, gathering her corruptive magics. The strangely slit pupils of her black-rimmed eyes never seem to leave you.";
				if(dictOrder.length>0){
					if(roundCheck==1){
						str += "\n\nA sudden unreasoning <b>fear</b> took hold onto you briefly"

						if(flags[kFLAGS.D3_DOPPLEGANGER_DEFEATED]==1){
							str += " not unlike the strange mirror you faced earlier in this accursed fortress"
						}

						str+=". Then you notice a strange contortion behind Lethice, as if there is something translucent resides there, thought of Lethice likely has some tricks under her sleeve instill intense anxiety into you. ";

						if(dictOrder.indexOf("physical")>-1){
							str += "Quickly rushing towards her in hope to finish the fight, your suspicion became clear as you closing in, reveals a large <b>"+wheelHandleDesc()+"</b>-handled wheel as it turned briefly, a loud clank follows before it stopped and fade back into nothingness. And the next thing you knew you realised that Lethice intercept your attack, completely still as if the force you put into your strike was never there in the first place, then you felt the sensation being pushed back,";
						}
						else{
							str += "Quickly you use the recast the same ability at her with the aid of mana trace still remained in hope to land some hits before she fully recover, your suspicion became clear as a large <b>"+wheelHandleDesc()+"</b>-handled wheel reveals itself as it turned briefly, a loud clank follows before it stopped and fade back into nothingness. And the next thing you knew your spell dissipated as it made contact with her seemingly. Noticed your attack leaves not even a bruise after and an congregate of <b>identical</b> mana signature from her,"
						}

						str += " Immediately disengage and distance yourself with her as you concluded: something must've happened after the wheel turned, otherwise Lethice could've blocking your attack earlier in the same fashion, perhaps you should attempt <b>alternate strategy</b> and taking note <b>how many times</b> the wheel has turned.\n";
					}
					str += wheelHandleString();
					// Bookmark for wheels turning count
					if(dictOrder.indexOf("hplossimmune")>-1){
						str += "\n\nPerhaps out of your sheer willpower or rage you still manage to stand up to fight for another day, seeing Lethice's grin in response, you realized that <b>you might not able to survive</b> another blow from her should you still retain your grievous injuries!"
					}
					if(dictOrder.indexOf("lustlossimmune")>-1){
						str += "\n\nDespite how overwhelmingly aroused you are right now, you still manage to continue fighting thanks to your inability to orgasm in combination with your new founded animal instincts from the mutations you went through. Despite the advantage you have garnered, some part of you can't help but think that <b>you might really GIVE IN</b> if Lethice push your arousal to your limits once again!"
					}
				}

				// Minimum HP = player current HP - damage (60% of max HP)
				hpLimit = Math.round(player.HP - (player.maxOverHP() * 0.6));
				// Maximum Lust = player current lust + lust damage (60% of max lust)
				lustLimit = Math.round(player.lust + (player.maxOverLust() * 0.6));
			}
			else if (_fightPhase == 2)
			{
				str += "You're completely surrounded by demons! The members of Lethice's corrupted court have flooded the throne hall like a sea of tainted flesh, crushing in on you with the sheer weight of bodies being thrown against you. Incubi, succubi, and forms between and combining them all grasp and thrust at you, trying to overwhelm you with desire for their inhuman bodies and the unspeakable pleasures only demons command.";
				if (hasStatusEffect(StatusEffects.Blind))
				{
					str += " The demons have relented somewhat, clutching at their eyes and screaming in frustration and panic thanks to your potent spell!";
				}
				else if (hasStatusEffect(StatusEffects.OnFire))
				{
					str += " More than a few of the court are screaming in terror, rolling on the ground and trying desperately to put out the flames you've bathed them in! Turns out Marethian demons aren't all that immune to fire!";
				}
			}
			else
			{
				str += "Lethice is the epitome of all things demonic. From her luxurious purple hair, interwoven with black roses, to her pink skin and goat-like horns, she is the perfect image of sensual, enticing corruption. Tall heels of bone complement her revealing, black clothes. They look almost like a nun’s habit, but pared down to an almost fetishistic extreme. Her slim breasts provide just a hint of shape to the diaphanous fabric, a promise of feminine delights instead of the garish acres of flesh her outfit displays. Standing astride her throne";
				str += ", Lethice regards you with a snarl and a crack of her flaming whip. Her yellow-black eyes are wide with fury, the pointed tips of her teeth bared in a snarl. Gorged with lethicite, the enraged demon queen is determined to finish you. Her endurance can’t possible hold for too much longer. You can beat her!";

				if (_fightPhase == 3 && _defMode != 0)
				{
					if (_defMode == 1) str += "\nLethice is standing ready for your next attack, ready to defend against any strike. Perhaps you could surprise her with something else?";
					else if (_defMode == 2) str += "\nLethice is smirking and confident, prepared to resist any sort of libidinous advance, but her posture is ill-suited to deflecting attacks."
				}
				str += wheelHandleString();
				if(dictOrder.indexOf("hplossimmune")>-1){
					str += "\n\nPerhaps out of your sheer willpower or rage you still manage to stand up to fight for another day, seeing Lethice's grin in response, you realized that <b>you might not able to survive</b> another blow from her should you still retain your grievous injuries!"
				}
				if(dictOrder.indexOf("lustlossimmune")>-1){
					str += "\n\nDespite how overwhelmingly aroused you are right now, you still manage to continue fighting thanks to your inability to orgasm in combination with your new founded animal instincts from the mutations you went through. Despite the advantage you have garnered, some part of you can't help but think that <b>you might really GIVE IN</b> if Lethice push your arousal to your limits once again!"
				}

				// Minimum HP = player current HP - damage (60% of max HP)
				hpLimit = Math.round(player.HP - (player.maxOverHP() * 0.6));
				// Maximum Lust = player current lust + lust damage (60% of max lust)
				lustLimit = Math.round(player.lust + (player.maxOverLust() * 0.6));
			}

			if (player.hasStatusEffect(StatusEffects.LethicesRapeTentacles))
			{
				str += "\n\nA forest of black tentacles sprout from the floor, snaring any demons unlucky enough to venture close - or any champions unlucky enough to be in the center of it all.";
				if (player.statusEffectv3(StatusEffects.LethicesRapeTentacles) != 0) outputText("<b> Unfortunately, they’ve grabbed you. You need to break free to do anything! </b>");
				if (player.hasStatusEffect(StatusEffects.KnowsWhitefire))
				{
					str += " A blast of white-fire could probably dispel them, or you could rely on your";
					if (player.canFly()) str += " flight";
					else str += " quickness";
					str += " to stay safe. Either way, you’re free for now.";
				}
			}

			if (game.monster.hasStatusEffect(StatusEffects.Shell))
			{
				str += "\n\n<b>Lethice is surrounded by a shimmering dome of magical energy. Spells and ranged attacks will be ineffective!</b>";
			}

			if (player.hasStatusEffect(StatusEffects.PigbysHands))
			{
				str += "\n\nInvisible hands roam over your body, stroking you in ways that no one but a lover ever should. They won’t stop, and they won’t slow. You’ll have to try to ignore their arousing caresses.";
			}

			return str;
		}

		// Dictonary doesnt preserve order smh
		private var dictOrder:Array = [];
		private var dictValue:Array = [];
		private var dictHistory:Array = [];
		private var dictAttacked:Array = [];
		private var roundCheck:int = 0;
		private var decayCheck:Boolean = false;
		private var companionCheck:Boolean = false;
		private var hpLimit:Number = 0;
		private var lustLimit:Number = 0;

		private function furubeYuraYuraYatsukaNoTsurugiIkaishinshoMakora():void{
			var _statusEffects:Array = statusEffects;

			// outputText("Start of Status Effect Debug\n");

			// Append attacked damage type into immunity from last round
			// Since I dont want Lethice to become immune immediately (literally unplayable)

			for(var __i:int=0;__i<dictAttacked.length;__i++){
				var ___index:int = dictOrder.indexOf(dictAttacked[__i]);
				if(___index>-1){
					dictOrder.removeAt(___index);
					dictValue.removeAt(___index);
				}

				dictOrder.push(dictAttacked[__i]);
				dictValue.push(115);

				sizeCheck();
			}

			dictAttacked = [];

			// Append status effect immmunity and make Lethice immune to adapted debuff
			for(var i:int=0; i < _statusEffects.length;i++){
				// outputText( statusEffects[i].stype.id + " "+ statusEffects[i].value1 + " \n");
				// Good job if you didnt use value1 for duration check
				// Check for Shell becuz fucking
				if(_statusEffects[i].stype.id!="Shell"){
					var _index:int = dictOrder.indexOf(_statusEffects[i].stype.id);
					if(_index>-1){
						_statusEffects[i].value1 = 1;
						dictOrder.removeAt(_index);
						dictValue.removeAt(_index);

						// Re add Immunity if you trigger deflect lul
						dictOrder.push(_statusEffects[i].stype.id);
						dictValue.push(115);
					}
					else{
						if(_statusEffects[i].value1>2){
							// Add Immunity
							dictOrder.push(_statusEffects[i].stype.id);
							dictValue.push(115);

							decayCheck = true;

							sizeCheck();
						}
					}
				}
			}

			// Two condition to trigger immunity decay
			// Either add status effect immunity or damage type immunity
			// Prevent player just get over the gimmick by spamming wait
			if(decayCheck){
				// To prevent modifying looping array
				var tmpOrder:Array = [];
				var tmpValue:Array = [];

				roundCheck++;

				for(var _i:int=0;_i<dictOrder.length;_i++){
					// Remove immunity if lifetime less than 15
					if(dictValue[_i]>14){
						tmpOrder.push(dictOrder[_i]);
						tmpValue.push(dictValue[_i]-15);
					}
				}

				dictOrder = tmpOrder;
				dictValue = tmpValue;
			}

			// outputText( "\nDictionary size: " + dictOrder.length + " \nFirst key: " + dictOrder[0] + " \n");
			// outputText("End of Status Effect Debug\n");

			decayCheck = false;
		}
		private function sizeCheck():void{
			// Limit immunity down to 9, remove the first added immunity
			if(dictOrder.length>(3+flags[kFLAGS.GAME_DIFFICULTY])){
				dictOrder.removeAt(0);
				dictValue.removeAt(0);
			}
		}
		private function wheelHandleDesc():String{
			var numberWheel:String = "";

			switch(3+flags[kFLAGS.GAME_DIFFICULTY]){
				case 3:
					numberWheel = "three";
					break;
				case 4:
					numberWheel = "four";
					break;
				case 5:
					numberWheel = "five";
					break;
				case 6:
					numberWheel = "six";
					break;
				case 7:
					numberWheel = "seven";
					break;
				case 8:
					numberWheel = "eight";
					break;
			}

			return numberWheel;
		}
		private function wheelHandleString():String{
			var printString:String = "";
			var wheelTurned:Number = 0;
			var tmp:Array = [];

			for(var ___i:int = 0;___i<dictOrder.length;___i++){
				if(dictHistory.indexOf(dictOrder[___i])<0){
					wheelTurned +=1;
				}
				tmp.push(dictOrder[___i]);
			}

			dictHistory = tmp;

			printString += "\n\nYou noticed as the <b>"+wheelHandleDesc()+"</b>-handled wheel behind Lethice reveals and turned <b>" + wheelTurned +" times</b> shortly before concealing itself once more.";

			if(wheelTurned==0){
				printString = "\n\nWheel behind Lethice currently has not reveal itself. Perhaps you should try something else?";
			}

			return printString;
		}
		private function statusHandler(string:String=""):Boolean{
			// Append status effect immmunity and make Lethice immune to adapted debuff
			if(dictOrder.indexOf(string)<0){
				// Add Immunity
				dictOrder.push(string);
				dictValue.push(115);

				decayCheck = true;

				sizeCheck();
				return false;
			}
			else{
				return true;
			}
		}
		override protected function handleConstricted():Boolean{
			return statusHandler("constrict");
		}
		override protected function handleStun():Boolean{
			return statusHandler("stun");
		}
		override protected function handleFear():Boolean{
			return statusHandler("fear");
		}
		override protected function handleConfusion():Boolean{
			return statusHandler("confuse");
		}
		override public function handleStatusEffects(statusEffect:StatusEffectType):Boolean{
			var string:String = "";

			switch(statusEffect){
				case StatusEffects.OrcaPlay:
					string = "play with"
					break;
				case StatusEffects.Straddle:
					string = "straddle on"
					break;
				case StatusEffects.Provoke:
					string = "provoke"
					break;
				case StatusEffects.OrcaHasWackedFinish:
					string = "slap your tail onto"
					break;
				default:
					string = "restrain";
			}
			if(_fightPhase != 2 && statusHandler(statusEffect.id)){
				outputText("\n\nAs you attempt to " + string + " Lethice, much to your surprise she remain unfazed. Looks like she has adapted to your ability.");
				return true;
			}
			else{
				return false;
			}
		}
		override public function combatRoundUpdate():void{
			if(_fightPhase!=2){
				furubeYuraYuraYatsukaNoTsurugiIkaishinshoMakora();
			}
			super.combatRoundUpdate();
		}
		private function adaptionDeflect(damage:Number, font:String, dict:String="physical", damageType:Number=0):Number {
			if(_fightPhase!=2){
				if(companionCheck){
					// Companion attack will never be deflected to player since it will be skipped once adapted
					dict = "companion";
				}
				var index:int = dictOrder.indexOf(dict);
				if(index>-1){
					var numberformat:NumberFormatter = new NumberFormatter();
					var deflectDamage:Number = Math.round(damage * (dictValue[index]/100));
					var dmgText:String = numberformat.format(Math.floor(Math.abs(deflectDamage)));
					switch(dict){
						case "lust":
							player.takeLustDamage(deflectDamage);
							break;
						case "true":
							player.HP -= deflectDamage;
							break;
						default:
							player.takeDamage(deflectDamage,damageType);

					}
					outputText("<b>([font-" + font + "]" + "Deflected! " + dmgText + "[/font])</b>");

					if(player.HP < hpLimit){
						player.HP = hpLimit;
					}

					if(player.lust > lustLimit){
						player.lust = lustLimit;
					}

					dictAttacked.push(dict);

					return damage-deflectDamage;
				}
				else {
					dictAttacked.push(dict);
					decayCheck = true;
				}
			}

			return damage;
		}
		override public function doDamageBefore(damage:Number):Number{
			return adaptionDeflect(damage,"damage");
		}
		override public function doMagicDamageBefore(damage:Number):Number{
			return adaptionDeflect(damage,"damage","magic",4);
		}
		override public function doFireDamageBefore(damage:Number):Number{
			return adaptionDeflect(damage,"fire","fire",5);
		}
		override public function doIceDamageBefore(damage:Number):Number{
			return adaptionDeflect(damage,"cold","cold",6);
		}

		override public function doLightningDamageBefore(damage:Number):Number{
			return adaptionDeflect(damage,"lightning","lightning",7);
		}

		override public function doDarknessDamageBefore(damage:Number):Number{
			return adaptionDeflect(damage,"dark","dark",8);
		}

		override public function doPoisonDamageBefore(damage:Number):Number{
			return adaptionDeflect(damage,"poison","poison",9);
		}

		override public function doWindDamageBefore(damage:Number):Number{
			return adaptionDeflect(damage,"wind","wind",10);
		}

		override public function doWaterDamageBefore(damage:Number):Number{
			return adaptionDeflect(damage,"water","water",11);
		}

		override public function doAcidDamageBefore(damage:Number):Number{
			return adaptionDeflect(damage,"acid","acid",13);
		}

		override public function doEarthDamageBefore(damage:Number):Number{
			return adaptionDeflect(damage,"earth","earth",12);
		}

		override public function doTrueDamageBefore(damage:Number):Number{
			return adaptionDeflect(damage,"damage","true");
		}

		override protected function applyTease(lustDelta:Number, display:Boolean = true):void{
			lustDelta = adaptionDeflect(lustDelta,"lust","lust");
			if(lustDelta>0){
				super.applyTease(lustDelta, display);
			}
		}

		override public function preCompanionSeal(companionName:String):Boolean{
			if(_fightPhase!=2){
				if(dictOrder.indexOf("companion")>-1){
					companionCheck = false;
					outputText("\n\nAs you recuperate from your last move, " + companionName + " attempts to attack Lethice only to be perfectly intercepted, leaving her unharmed.");
					return false;
				}
				companionCheck = true;
			}
			return true;
		}

		override public function postCompanionAction():void{
			companionCheck = false;
		}

		override public function postPlayerBusyBtnSpecial(btnSpecial1:CoCButton, btnSpecial2:CoCButton):void{
			if (player.hasStatusEffect(StatusEffects.LethicesRapeTentacles)) {
				if (player.lust < SceneLib.combat.magic.getWhiteMagicLustCap() && player.hasStatusEffect(StatusEffects.KnowsWhitefire)
						&& ((!player.hasPerk(PerkLib.BloodMage) && player.mana >= 30) || (player.hasStatusEffect(StatusEffects.BloodMage) && ((player.HP + 30) > (player.minHP() + 30))))) {
					btnSpecial1.show("Dispel", dispellRapetacles);
				}
			}
		}

		override public function postPlayerAbility(ability:CombatAbility, display:Boolean = true):void {
			if (fightPhase == 3 && ability is AbstractSpell && ability.hasTag(CombatAbility.TAG_DAMAGING)) {
				if (display) outputText("\n\n<i>\"Ouch. Such arcane skills for one so uncouth,\"</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her." + 
					" <i>\"How will you beat me without your magics?\"</i>\n\n");
				createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (_fightPhase == 1)
			{
				// furubeYuraYuraYatsukaNoTsurugiIkaishinshoMakora();
				phase1Ends(hpVictory);
				return;
			}
			else if (_fightPhase == 2)
			{
				// Demon horde arrives to buy time for Lethice to adapt to your attack haha
				phase2Ends(hpVictory);
				return;
			}
			SceneLib.d3.lethice.defeated(hpVictory);
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.isGargoyle()) SceneLib.d3.gargoyleBadEndD3();
			else SceneLib.d3.lethice.won(hpVictory, pcCameWorms);
		}
		
		private var _roundCount:int = 0;
		private var _fightPhase:int = 1;
		public function get fightPhase():int { return _fightPhase; }
		private var _defMode:int = 0; // 0- none, 1- hp, 2- lust

		override protected function performCombatAction():void
		{
			_roundCount++;

			switch (_fightPhase)
			{
				case 1: phase1(); break;
				case 2: phase2(); break;
				case 3: phase3(); break;
				default: phase1(); break;
			}

			// Lettuce now adapt to player loss immunity HA
			if(_fightPhase!=2){
				if(player.HP<=player.minHP() + 1 && (player.hasStatusEffect(StatusEffects.TooAngryTooDie) || player.hasPerk(PerkLib.Immortality) || player.hasPerk(PerkLib.WhatIsReality))){
					if(dictOrder.indexOf("hplossimmune")>-1){
						doNext(SceneLib.combat.endHpLoss);
					}
					else{
						dictOrder.push("hplossimmune");
						dictValue.push(999);

						decayCheck = true;
					}
				}
				if(player.lust>=player.maxOverLust()){
					if(dictOrder.indexOf("lustlossimmune")>-1){
						doNext(SceneLib.combat.endLustLoss);
					}
					else{
						dictOrder.push("lustlossimmune");
						dictValue.push(999);

						decayCheck = true;
					}
				}
			}
		}

		private function phase1():void
		{
			var atks:Array = [demonicArouse, demonfire];
			if (_roundCount % 10 == 3) atks.push(rapetacles);
			if (!player.hasStatusEffect(StatusEffects.Blind)) atks.push(wingbuffet);
			atks[rand(atks.length)]();
		}

		private function demonicArouse():void
		{
			outputText("Lethice’s hands blur in a familiar set of arcane motions, similar to the magical gestures you’ve seen from the imps. Hers are a thousand times more intricate. Her slender fingers move with all the precision of a master artist’s brush, wreathed in sparks of black energy.");
			var l:Number = player.lib + player.cor + 125;
			if (player.hasStatusEffect(StatusEffects.MinotaurKingsTouch)) l *= 1.25;
			player.takeLustDamage(l, true);	
			if (player.lust <= (player.lust100 * 0.3)) outputText("\n\nYou feel strangely warm.");
			else if (player.lust <= (player.lust100 * 0.6)) outputText("\n\nBlood rushes to your groin as a surge of arousal hits you, making your knees weak.");
			else if (player.lust <= (player.lust100 * 0.75)) outputText("\n\nDespite the dire situation, your mind keeps filling with images of Lethice fully uncovered, her body poised just inches away. You can’t help but want her.");
			else if (player.lust <= (player.lust100 * 0.9)) outputText("\n\nThe dark power forces ideas into your mind, thoughts of you on your knees, hands shackled behind you and your mistress’s perfect, pretty pussy in front of you, awaiting your tongue. You barely shake it off.");
			else if (player.lust <= player.lust100) outputText("\n\nYour mind is filled with visions of lovely pussies, perfect tits, and one overriding emotion - submission. She’s making you want to give up and indulge in her tainted wiles, and the worst part is... you’re having a hard time coming up with a reason not to. You barely pull back from an all-consuming image of her slick, juicy snatch, shaking your head in wonderment. How can you possibly defeat her?");
			else outputText("You give yourself over to the alien imagery invading your mind, wallowing a dozen conflicting fantasies. In one, you’re tied to Lethice’s clit-piercing by a leash, lapping her spilled cunt-juice from the ground. In another, you’re begging her to let you tongue her asshole. Each is more perverse than the last, and they blend together into an endless tableau of submission.");
		}

		private function rapetacles():void
		{
			//Adds a button - Dispel - Only if PC knows Whitefire
			outputText("Lethice gestures at the ground underfoot. A pulse of black mist rolls out around you for dozens of feet in every direction. The crowd of watching demons pulls back fearfully, save for a few foolish slaves who blithely step into the magic circle. A second later, hundreds of oily, black tentacles emerge from the floor, unspooling from whatever horrible dimension they were summoned from. They immediately attack every living creature within reach, wrapping around wrists and ankles, violating vaginas and assholes alike. They come at you from every direction!");
			// v1 - remaining duration
			// v2 - rounds applied
			// v3 - grappled
			if (player.canFly())
			{
				outputText("\n\nYou laugh as you fly out of their reach, immune to their touches.");
				player.createStatusEffect(StatusEffects.LethicesRapeTentacles, 4 + rand(2), 0, 0, 0);
			}
			else if (player.getEvasionRoll())
			{
				outputText("\n\nYou manage to sidestep the grasping tentacles with ease.");
				player.createStatusEffect(StatusEffects.LethicesRapeTentacles, 4 + rand(2), 0, 0, 0);
			}
			else
			{
				outputText("\n\nYou aren’t fast enough to avoid them. They yank your arms and [legs] taut. Some burrow under your [armor], crawling toward your most sensitive, forbidden places.");
				player.createStatusEffect(StatusEffects.LethicesRapeTentacles, 4 + rand(2), 0, 1, 0);
			}
		}

		public function dispellRapetacles():void
		{
			clearOutput();
			if (player.statusEffectv3(StatusEffects.LethicesRapeTentacles) == 0)
			{
				outputText("You raise your arm and");
			}
			else
			{
				outputText("You struggle and manage to raise your arm against the tight grasp of the tentacles, managing to")
			}
			outputText(" spray forth a torrent of white flame, burning the shadowy constructs away in the light of your pure, focused fire. In the span of seconds, Lethice’s spell is gone.");
			EngineCore.doNext(SceneLib.combat.combatMenu);
			if (game.player.hasStatusEffect(StatusEffects.BloodMage)) game.player.HP -= 30;
			else game.player.mana -= 30;
			outputText("\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			SceneLib.combat.spellPerkUnlock();
			EngineCore.statScreenRefresh();
            SceneLib.combat.enemyAIImpl();
        }

		private function demonfire():void
		{
			//I can’t believe it’s not whitefire. Cannot be avoided/blocked. Medium damage.
			outputText("Lethice narrows her eyes, focusing her mind with deadly intent. She snaps her fingers and a gout of black, twisting flames engulfs you!");
			var damage:Number = (this.inte + 100 + rand(25)) * 10;
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 0.3;
			player.takeFireDamage(damage,true);
		}

		private function wingbuffet():void
		{
			outputText("Lethice flutters toward a burning brazier and flaps her wings, causing the flames to flare and thick gusts of smoke to flow past the assembled demons, straight at you!");

			if (player.getEvasionRoll())
			{
				outputText(" You manage to slide under the waves of smoke.");
			}
			else
			{
				outputText(" The cloying smoke gets in your eyes and your mouth, making you cough and sputter. Worst of all, you can’t see anything!");
				if (!player.isImmuneToBlind()) player.createStatusEffect(StatusEffects.Blind, 2, 0, 0, 0);
				player.takePhysDamage(1);
				outputText(" (1)");
			}
		}
		
		public function grappleStruggle():void
		{
			clearOutput();
			outputText("You pull with all your might against the grasping tentacles to no avail; their grip is simply too strong!");
            SceneLib.combat.enemyAIImpl();
        }
		
		public function grappleWait():void
		{
			clearOutput();
			outputText("You can't bring yourself to fight back against Lethice's tentaclespawn. The sensuous, coiling grasp around your limbs, their questing, pliant tips digging around inside your [armor]... you relax in their grip for a little while longer, too enticed by their movement to struggle right now.");
            SceneLib.combat.enemyAIImpl();
        }
		
		private function phase1Ends(hpVictory:Boolean):void
		{
			clearOutput();
			if (hpVictory)
			{
				if (player.canFly())
				{
					outputText("Even held aloft by her sprawling dragon wings, Lethice can’t hide from your righteous wrath.");
					outputText(" Taking wing yourself, you slam into the demoness, striking a final blow that sends her toppling to the ground. She shrieks and spirals, crashing into the hard stone floor just before her throne.");
				}
				else if (flags[kFLAGS.LAST_ATTACK_TYPE] == 1)
				{
					outputText("Even held aloft by her sprawling dragon wings, Lethice can’t hide from your righteous wrath.");
					outputText(" You draw your bowstring and let loose one last arrow, sending the missile hurtling through the air - and right into Lethice’s wing! The Demon Queen lets out an ear-piercing shriek of pain and, with her wing flopping weakly beside her, goes tumbling to the earth! She’s down!");
				}
				else if (flags[kFLAGS.LAST_ATTACK_TYPE] == 2)
				{
					outputText("Unable to resist your arcane assault, Lethice lets loose a howl of frustration and swoops back to the earth, mounting her throne once again.");
				}
			}
			else
			{
				outputText("Unable to resist your sensual assault, Lethice lets loose a howl of frustration and swoops back to the earth, mounting her throne once again.");
			}
			outputText("\n\n<i>\"I tire of this game!\"</i> she shouts, grasping at the arms of her towering throne. Suddenly, her gaze snaps from you, to the horde of demons clamoring in the stands. <i>\"What are you waiting for, fools!? Get [him]!\"</i>");
			outputText("\n\nOh, shit. You look up in time to see a cavalcade of demonic flesh swooping down from on high, bodies practically tumbling one over the other to get at you. The horde takes every physical form imaginable: towering, hulking brutish males, inhumanly curvaceous succubi, and the reverse of both - not to mention hermaphrodites masculine and feminine - and all with every sort of transformation. Bestial creatures, dragon-like incubi, and succubi whose skins range the colors of the rainbow and so, so much more come piling down the throne hall in a ceaseless barrage of flesh and decadence. They won’t stop until they’ve dragged you to the ground and fucked you into submission!");
			// 9999 reconfigure for the group
			HP   = maxOverHP();
			lust = 10;
			_fightPhase = 2;
			a = "the ";
			short = "demons";
			plural = true;
			pronoun1 = "they";
			pronoun2 = "them";
			pronoun3 = "their";
			if (hasStatusEffect(StatusEffects.PhysicalDisabled)) removeStatusEffect(StatusEffects.PhysicalDisabled);
			if (hasStatusEffect(StatusEffects.AttackDisabled)) removeStatusEffect(StatusEffects.AttackDisabled);
			SceneLib.combat.combatRoundOver();
		}

		private function phase2():void
		{
			var atks:Array = [demonLustMagic, dirtyDancing, hornyPoke, crushingBodies];
			if (rand(10) == 0 && !player.hasStatusEffect(StatusEffects.Blind)) atks.push(bukkakeTime);
			atks[rand(atks.length)]();
		}

		private function demonLustMagic():void
		{
			var l:Number = 0;
			outputText("Though the front rank of demons are compressed so tight against you by their cohorts that they can’t move, the second and third rings have more than ample room to move their arms about, tracing arcane runes in the air. You know you can resist the lust-magics of a mere demon, but so many at once...");
			if (rand(100) >= player.lib / 2)
			{
				outputText("\n\nYou close your eyes, focusing the entirety of your will inwards. Though a burn of arousal stings your flesh, you keep your mind centered long enough to resist the brunt of the demon's magic. Taking a deep breath, you let out a raging battle cry and shove the horde back, punishing those who dared try to ensorcell you.");
			}
			else if (player.lust <= (player.lust100 * 0.33))
			{
				outputText("\n\nYou try your hardest to push back the lustful, submissive thoughts that begin to permeate your mind, but against so many concentrated wills... even you can't hold back. You moan as the first hints of arousal spread through you, burning in your loins. What you wouldn't give for a fuck about now!");
				l = player.lib + player.cor + 100;
				if (player.hasStatusEffect(StatusEffects.MinotaurKingsTouch)) l *= 1.25;
				player.takeLustDamage(l, true);
			}
			else if (player.lust <= (player.lust100 * 0.66))
			{
				outputText("\n\nAt first, you try to think of something else... but in your state, that just ends up being sex: hot, dirty, sweaty fucking surrounded by a sea of bodies. With a gasp, you realize you've left yourself open to the demons, and they're all too happy to flood your mind with images of submission and wanton debauchery, trying to trick you into letting them take you!");
				l = player.lib + player.cor + 100;
				if (player.hasStatusEffect(StatusEffects.MinotaurKingsTouch)) l *= 1.25;
				player.takeLustDamage(l, true);
			}
			else
			{
				outputText("\n\nYou don't even try to resist anymore -- your mind is already a cornucopia of lustful thoughts, mixed together with desire that burns in your veins and swells in your loins, all but crippling your ability to resist. The demons only add to it, fueling your wanton imagination with images of hedonistic submission, of all the wondrous things they could do to you if you only gave them the chance. It's damn hard not to.");
				l = player.lib + player.cor + 100;
				if (player.hasStatusEffect(StatusEffects.MinotaurKingsTouch)) l *= 1.25;
				player.takeLustDamage(l, true);
			}
		}

		private function dirtyDancing():void
		{
			outputText("The demons closest to you are basically pinned between your body and those behind them, all surging forward to get at you - and half of them are being fucked or teased by the laggards, with cocks and over-sized clits thrusting with wild abandon. Nevertheless, the closest demons are just as determined as the others to make you theirs, even if their options are severely limited. So they do what they can: they dance and grind and thrust themselves against you, smearing your [armor] with milk and feminine excitement and musky, salty pre-cum between showing you with ample, soft flesh and hard muscle.");
			if (rand(100) >= player.lib / 2)
			{
				outputText("\n\nYou push back as hard as you can, throwing back the whorish bodies trying to capture your attentions. Several succubi whine and moan at you, pouting that their lustful dances weren't satisfying to you -- like you just insulted them on a personal level. Others are quick to replace them, though, instantly filling the gaps you leave in the crushing tide of bodies.");
			}
			else
			{
				if (player.lust <= (player.lust100 * 0.33)) outputText("\n\nYou try and push back, to ignore the lustful bodies and lurid performances going on around you, but the effect they have on you is undeniable -- heat spreads like wildfire through your [skinFurScales], and your [armor] suddenly feels a whole lot less comfortable.");
				else if (player.lust <= (player.lust100 * 0.66)) outputText("\n\nTry as you might to resist, the demons are having an effect on you! Your whole body is flushed with unbidden arousal, burning with lust for the demonic sluts pressing against you. The temptresses are almost enough to want to make you lay down your arms and bend one of them double for a good, hard fuck!");
				else outputText("\n\nOh gods! The way their bodies undulate, caressing and cumming, moaning as they're fucked from behind and transfer all of that energy to you, makes your body burn with desire. It's almost too much to bear!");
				var l:Number = player.lib + player.cor + 100;
				if (player.hasStatusEffect(StatusEffects.MinotaurKingsTouch)) l *= 1.25;
				player.takeLustDamage(l, true);
			}
		}

		private function hornyPoke():void
		{
			outputText("Several of the demons nearest you have grown immense sets of curling, sharp horns. When they can’t get at you to sexually provoke or hurl magic at you, they’re more than content to just give you an old-fashioned ram!");
			var ev:String = player.getEvasionReason();
			if (ev == EVASION_MISDIRECTION)
			{
				outputText(" At least, they try to! Too bad for them you’re already elsewhere in the crowd, well away from harm!");
			}
			else if (ev == EVASION_FLEXIBILITY)
			{
				outputText(" You contort and bend in ways a human never could, easily twisting between all the pairs of horns the demons can thrust at you. By the time they’re done, you’re sitting on top of a demon’s head, balanced on his antlers until with a furious howl he throws you back into the sea of maledicts.");
			}
			else if (ev == EVASION_EVADE)
			{
				outputText(" You manage to duck down enough to avoid the worst of the horn-spikes, and your [armor] deflects the rest!");
			}
			else if (ev != null)
			{
				outputText(" You deftly dodge out of the way!");
			}
			else
			{
				var damage:Number = 7000 - rand(player.touStat.core.value);
				outputText(" Several of the big, stout horns slam into you, given all the more force thanks to the crushing waves of demons pushing them forward. You yelp in pain as they score your flesh!");
				player.takePhysDamage(damage,true);
			}
		}

		private function crushingBodies():void
		{
			outputText("The sheer weight of a hundred demonic bodies crushing down on you is enough to make you cry out in discomfort, then pain. Are they just trying to crush you to death!?");
			if (player.getEvasionRoll())
			{
				outputText("\n\nYou drop to the ground, squirming between several of their legs until you get somewhere you can stand again -- this time without breaking your ribs. Howls of frustration and anger echo through the hall, and the horde just comes barreling down on your again!");
			}
			else
			{
				var damage:Number = 7000 - rand(player.touStat.core.value);
				outputText(" You squirm out of their crushing embrace, trying to crawl away on the ground, but if they can't squeeze you down the demons seem happy to trample you! You scream in alarm and pain as dozens of feet, hooves, claws, and other appendages come crushing down on you!");
				player.takePhysDamage(damage,true);
			}
		}

		private function bukkakeTime():void
		{
			outputText("Considering how half of the demon host is just getting fucked by whoever’s behind them, it’s just a question of how long they last before the cum starts flowing. The answer just happens to be now! You gasp and gag as the air is suddenly flooded by the reek of potent, virile jizz, and ropes of thick white spunk start flying through the air. This is less of a gank mob and more of an orgy now!");
			var ev:String = player.getEvasionReason();
			if (ev == EVASION_MISDIRECTION)
			{
				outputText(" You duck under the nearest group of succubi, happily letting the demonic hussies get plastering with the wave of flying spooge. They seem to enjoy it, too, and quickly you’re surrounded by less demonic fighting and much, much more infernal cock-sucking. Seems they’re hungry!");
			}
			else if (ev == EVASION_FLEXIBILITY)
			{
				outputText(" You do a graceful backflip out of the way, making sure it’s a group of eager succubi who get painted white with cum rather than you!");
			}
			else if (ev == EVASION_EVADE)
			{
				outputText(" You at least manage to close your eyes before the wave of spooge hits you, splattering all over your [armor].");
				player.takeLustDamage(Math.round(player.maxLust() * 0.05), true);
			}
			else if (ev != null)
			{
				outputText(" You grab the biggest incubus you can find and shove him in the way of the airborne bukkake, letting his burly back take the brunt of the demons’ load. He grunts in displeasure, giving you a rough shove back into the demonic gang-bang. <i>\"No escape!\"</i>");
			}
			else
			{
				outputText(" You take a huge, fat, musky glob of spunk right to the eyes! You yelp in alarm, trying to wipe the salty, burning demonic cock-cream out, but it's simply too thick! Yuck!");
				player.takeLustDamage(Math.round(player.maxLust() * 0.05), true);
				if (!player.isImmuneToBlind()) player.createStatusEffect(StatusEffects.Blind, 2 + rand(2), 0, 0, 0);
			}
		}

		private function phase2Ends(hpVictory:Boolean):void
		{
			clearOutput();
			if (hpVictory)
			{
				outputText("The last of the demons falls to your [weapon], crumpling into an unconscious lump before you. A few are crawling haplessly away, retreating to the stands with the rest of their fellows - those too timid to fight at all.");
			}
			else
			{
				outputText("Lethice’s minions have all but turned into an orgy, completely forgetting their original intent, no matter how much their draconic queen screeches for them to attack.");
			}
			outputText("\n\nWhile the demons are down, and Lethice is still recovering from your first skirmish, you have a much-needed moment to relieve the tensions starting to grow within you. Or you could press the attack, and take the fight to the queen.");
			EngineCore.menu();
			if (player.hasCock() || player.hasVagina()) EngineCore.addButton(0, "DemonFuck", p2DemonFuck, hpVictory);
			if (player.hasStatusEffect(StatusEffects.KnowsHeal)) EngineCore.addButton(1, "Heal", p2Heal);
			EngineCore.addButton(2, "Next", p2Next);
		}

		private function p2DemonFuck(hpVictory:Boolean):void
		{
			clearOutput();

			outputText("Rather than advance on Lethice, you turn your attention to the pile of demons");
			if (hpVictory) outputText(" lying stunned and helpless");
			else outputText(" who’ve fallen into a frenzied orgy");
			outputText(" on the floor. One in particular catches your attention: a purple-skinned harlot of an omnibus, with bone-formed high heels and voluptuous breasts and hips and a throbbing canine’s cock swinging between her legs, resting over a positively massive pair of balls, more like what you’d expect to be swinging under a centaur’s shaft. You reach down and grab her by her curling horns, pulling her off the crotch of another demon and pulling your [armor] aside to reveal your own");
			if (player.hasCock()) outputText(" cock.");
			else outputText(" cunt.");

			outputText("\n\n<i>\"O-oh my!\"</i> she purrs, black eyes batting at you as you make your intentions clear. <i>\"Here I thought you were saving this for the queen.\"</i>");
			outputText("\n\nYou growl for her to get started, prompting her to slither out a forked tongue to");
			if (player.hasCock()) outputText(" wrap around your [cock]");
			else outputText(" lap across the lips of your [cunt]");
			outputText(". Shudders of pleasure almost instantly begin to wrack your body, reacting to the demoness’s talented touch. She’s certainly skilled with her tongue, flicking and licking and caressing your sex with vigorous determination. You guide her movements by her demonic horns at first, but soon find yourself too busy gasping and moaning to try and control her - there’s no point, when she’s this good at");
			if (!player.hasCock()) outputText(" munching rug.");
			else outputText(" sucking cock.");
			outputText("\n\nAround you, spurred on by your face-fucking the omnibus, the defeated demon court undulates in waves of orgiastic pleasure, gleefully sucking each other’s cocks, penetrating any hole they can find, or simply rolling on the floor locked in each other’s sensual embraces. Those that didn’t join the fight hoot and holler from the stands, encouraging you to fuck the omnibus like the eager slut she is. For her part, the horny demon just smirks up at you between long, loving licks across your sex.");

			// [Oral Finish] [Fuck Demoncunt] [Ride Dogcock]
			EngineCore.menu();
			EngineCore.addButton(0, "OralFinish", oralFinish);
			if (player.hasCock()) EngineCore.addButton(1, "FuckDemon", fuckDemon);
			EngineCore.addButton(2, "RideCock", rideCock);
		}

		private function oralFinish():void
		{
			clearOutput();

			if (player.hasCock())
			{
				outputText("You ignore the horde’s jeers, grinding your hips against the omnibus’s face until you feel the tell-tale rise of climax surging through you. Her throat bulges around your [cock] and the load of salty spunk you pour down her gullet, right up until you pull out and give her face a showering for good measure.");
				outputText("\n\nSated, you give the well-used omnibus a shove back into the demon fuck-pile and ready your [weapon]. Confident in your readiness, you advance on Lethice.");
			}
			else
			{
				outputText("You disregard the demons’ demands, instead focusing on grinding your hips on the omnibus’s face, slathering her chin and cheeks with slick feminine excitement. She moans in appreciation, wrapping a hand around her over-sized doggy-cock and stroking it furiously to the same rhythm of her tongue’s exploration of your [cunt]. With such single-minded intention, it doesn’t take the demon slut long at all to bring you to a well-deserved climax - and herself as well, spraying a thick, musky rope of cum across your [feet] while you smear her face with orgasmic juices.");
				outputText("\n\nSated, you give the well-used omnibus a shove back into the demon fuck-pile and ready your [weapon]. Confident in your readiness, you advance on Lethice.");
			}

			player.orgasm();
			beginPhase3(true);
		}

		private function fuckDemon():void
		{
			clearOutput();

			outputText("The demons’ urging tears down your self-control, and with a grunt of effort and desire, you shove the omnibus down on her back. She yelps with surprise, but her fall is cushioned by the massive, milky tits of a cow-girl-turned-demon behind her who’s busily sucking a pair of demonic dongs. Your omnibus recovers from her surprise in a heartbeat, turning it into a luxurious stretch that spreads her pussy-lips open under the hefty, churning weight of her equine-like balls.");
			outputText("\n\nYou lunge on her the moment you see that vermillion slit opening, driving your [cock] to the hilt inside the sloppy twat and making the omnibus moan with delight. Her canid cock bobs up at full mast, poking at your [chest]");
			if (player.hasFuckableNipples()) outputText(" until you give her a wicked grin and guide the tip inside your [nipple]");
			else outputText(" and smearing your [skinFurScales] with pre");
			outputText(". You grab her melon-sized tits and squeeze them as hard as you can while you hammer your [hips] forward, taking advantage of the silky-wet vice of her twat to milk yourself to orgasm. She’s practically an ona-hole for you, only able to squirm around and moan while you pound away.");
			outputText("\n\nSuddenly, your entire body tenses, shivering with new sensation. You look over your shoulder in time to see another succubus crawling up behind you, running her tongue through the crack of your ass");
			if (player.hasBalls()) outputText(" and around your balls");
			else outputText(" down to the base of your cock");
			outputText(". Another demoness snuggles up behind you, pressing a hefty pair of jugs into your back and murmuring about how she wants to see you breed that hermaphroditic cum-slut under you.");
			outputText("\n\nWith more and more demons crawling up over you, urging you to cement your victory on their companion or adding to your pleasure with mouths and corrupted tongues, it’s not long before you surrender to your body’s carnal demands. Giving one last, mighty thrust into the omnibus’s twat, you grunt with the surging pleasure of cum swelling through your shaft, spilling out and basting the demoness’s womb. She cries out, bucking her hips against you and quickly following you with a shot of her own");
			if (!player.hasFuckableNipples()) outputText(" that splatters all over your chest");
			else outputText(" right into your tit");
			outputText("! You give her a reproachful look, still grinding your hips as the aftershocks of orgasm pass.");
			outputText("\n\n<i>\"Not sorry,\"</i> she giggles, running a finger around her cum-smeared twat and pushing every spare droplet back in as you pull out. <i>\"Mmm, that’ll make for a lovely brood of imps, </i>Champion<i>!\"</i>");
			outputText("\n\nShuddering at the thought, you grab your gear and stagger up and away, leaving the demons to finish each other off. Confident in your readiness, you advance on Lethice.");

			player.orgasm();
			beginPhase3(true);
		}

		private function rideCock():void
		{
			clearOutput();

			outputText("Considering the demons seem intent on having you get down and dirty with their defeated compatriot, you figure you might as well get the most out of the moment. Lethice doesn’t seem to be in any hurry to resume your battle, after all!");
			outputText("\n\nYou give the buxom demon hermaphrodite down on her ass, letting her rest her head in the lap of another cow-girl demon who’s busy sucking off a two-cock’d incubus, and crawl up her shapely red body. <i>\"Oooh,\"</i> the omnibus coos as her throbbing red rocket is pressed between your bodies. <i>\"Gonna go for a ride, Champion?\"</i>");
			outputText("\n\nDamn right you are. You grab her tits, sinking your fingers into the soft, crimson udders as you straddle her hips and grind your [vagOrAss] against the demon’s tumescent shaft. She’s hung like a stud, rock hard and ready to roll before you even get near her pointed crown. You feel her hands grasp your [hips], guiding you down until your [vagOrAss] is sinking onto her thick rod. Your belly bulges with the sheer length of cockflesh sliding into you, and your mind goes blank with overwhelming pleasure.");
			outputText("\n\nIt takes you a moment to recover from the initial shock, but when you do, you start moving with a vengeance, bouncing on the demonic doggy-cock with mounting speed. Its owner moans and squirms beneath you, too weakened from your fight to do anything but go along for the ride. Still, her big, black nipples are hard as rocks in your hand, and her pussy soaks both your thighs in her ever-rising excitement.");
			outputText("\n\nSuddenly, your entire body tenses, shivering with new sensation. You look over your shoulder in time to see another succubus crawling up behind you,");
			if (player.hasVagina()) outputText(" licking at your [cunt]");
			else outputText(" reaching around to give your unused [cocks] a tug}. Another demoness snuggles up behind you, pressing a hefty pair of jugs into your back and murmuring about how she wants to see you get bred by that hermaphroditic stud under you.");
			outputText("\n\nWith more and more demons crawling up over you, urging you to cement your victory on their companion or adding to your pleasure with mouths and corrupted tongues, it’s not long before you surrender to your body’s carnal demands. You grind your hips hard and fast against the demoness’s mis-matched crotch, loving the way her churning black balls ride in your ass, the way her fist-thick knot hammers against your [vagOrAss]. With so many sensations assaulting your body, it’s impossible to hold back. Screaming your ecstasy for the whole hall to hear, you climax, body shuddering and clenching hard around the thick demonic cock spreading you open.");
			outputText("\n\nThe demoness isn’t far behind. She grabs your hips hard enough that her nails score your flesh, and you feel a rush of sticky, wet heat flooding your");
			if (player.hasVagina()) outputText(" womb");
			else outputText(" bowels");
			outputText(". You only barely keep your wits about you enough to push her back down before she can force her knot inside you, though you’re treated to a veritable waterfall of white spunk pouring out of your well-bred hole instead.");
			outputText("\n\n<i>\"I can see why they call you ‘Champion,’\"</i> the demon purrs as her spunk-slathered red prick flops against her belly. <i>\"Maybe after our queen beats you down, I’ll come visit you in the breaking tanks... I could always use another eager little broodmare.\"</i>");
			outputText("\n\nYou shove the demoness away, suddenly reminded of her true nature. At least for now, you’re sated. Confident in your readiness, you advance on Lethice.");

			player.orgasm();
			beginPhase3(true);
		}

		private function p2Heal():void
		{
			clearOutput();
			outputText("Drawing on your magic, you use the opportunity to mend your wounds. No foe dares challenge you during the brief lull in battle, enabling you to maintain perfect concentration. With your flesh freshly knit and ready for battle, you look to Lethice.");
			CombatAbilities.Heal.doEffect(false);
			beginPhase3(true);
		}

		private function p2Next():void
		{
			clearOutput();

			outputText("<i>\"Useless whelps,\"</i> Lethice growls, rising back to her feet and spreading her");
			outputText(" draconic wings behind herself, letting them flare out to their full majesty. She grabs a whip from her flank and uncoils it with a snap, cracking it just over your head. Black fire seethes on the length of the whip, burning with corrupt magics that make the air reek of sex and desire around her.");
			outputText("\n\n<i>\"Very well, Champion,\"</i> she snarls, throwing aside her goblet of Lethicite. The crystals go scattering as the vessel shatters on the flagstone, and in an instant even the defeated demons are scrambling for the gems, making the floor you fight on a rabid hell to walk through. <i>\"I see I’ll have to finish you myself! Let us see what you’re really made of... before I rape your soul out of your body!\"</i>");

			var str:String = "";
			if(dictOrder.length>0){
				if(roundCheck==1){
					str += "\n\n 'Well, This should be easy! After all you destroy her in an instant just earlier.', you grin. But then a sudden unreasoning <b>fear</b> took hold onto you briefly"

					if(flags[kFLAGS.D3_DOPPLEGANGER_DEFEATED]==1){
						str += " not unlike the strange mirror you faced earlier in this accursed fortress"
					}

					str+=". Then you notice a strange contortion behind Lethice, as if there is something translucent resides there, thought of Lethice likely has some tricks under her sleeve instill intense anxiety into you. ";


					if(dictOrder.indexOf("physical")>-1){
						str += "Quickly rushing towards her in hope to finish the fight, your suspicion became clear as you closing in, reveals a large <b>"+wheelHandleDesc()+"</b>-handled wheel as it turned briefly, a loud clank follows before it stopped and fade back into nothingness. And the next thing you knew you realised that Lethice intercept your attack, completely still as if the force you put into your strike was never there in the first place, then you felt the sensation being pushed back,";
					}
					else{
						str += "Quickly you use the recast the same ability at her with the aid of mana trace still remained in hope to land some hits before she fully recover, your suspicion became clear as a large <b>"+wheelHandleDesc()+"</b>-handled wheel reveals itself as it turned briefly, a loud clank follows before it stopped and fade back into nothingness. And the next thing you knew your spell dissipated as it made contact with her seemingly. Noticed your attack leaves not even a bruise after and an congregate of <b>identical</b> mana signature from her,"
					}

					str += " Immediately disengage and distance yourself with her as you concluded: something must've happened after the wheel turned, otherwise Lethice could've blocking your attack earlier in the same fashion, perhaps you should attempt <b>alternate strategy</b> and taking note <b>how many times</b> the wheel has turned.\n";

					outputText(str);
				}
			}

			beginPhase3(false);
		}

		private function beginPhase3(doLethNext:Boolean):void
		{
			// 9999 configure phase 3

			_fightPhase = 3;
			HP   = maxOverHP();
			lust = 10;
			_defMode = 1;
			
			a = "";
			short = "Lethice";
			plural = false;
			pronoun1 = "she";
			pronoun2 = "her";
			pronoun3 = "her";
			
			EngineCore.menu();
			
			if (doLethNext) EngineCore.addButton(0, "Next", p2Next);
			else SceneLib.combat.combatRoundOver();
		}

		private function phase3():void
		{
			//Every turn she boosts her defense against lust or HP depending on how the PC damaged her.
			
			// If you hit her with a physical attack, the next turn she’ll have massive evasion (200 speed or some shit) and massively boosted defense.
			// GEDNOTE: We can't really do this- CoCs combat was NEVER designed with that in mind wrt to enemy stats, it would mean modifying EVERY player attack, spell and special to account for it. However, I figured out a potential workaround that covers this so....
			
			// If you hit her with a lusty-damaging attack, she will become immune to lust damage for one turn. Might also have other special resistances too. Will detail in text in the \"Reactions\" section.
			
			if (flags[kFLAGS.LAST_ATTACK_TYPE] == 1 || flags[kFLAGS.LAST_ATTACK_TYPE] == 2 || flags[kFLAGS.LAST_ATTACK_TYPE] == 4) _defMode = 1;
			else _defMode = 2;

			if (_defMode == 1)
			{
				outputText("Lethice dabs at her injury, then licks her finger, smiling sensually. She seems excited and invigorated. Scales appear over her skin, and her spaded tail swishes back and forth in a blur, too fast to follow.\n\n");
				speStat.core.value = 800;
				armorDef = 600;
				lustVuln = 1.125;
			}
			else
			{
				outputText("Shuddering, the Demon Queen steels herself. Her curves soften visibly as she prepares herself for additional arousing efforts, forgoing physical defense.\n\n");
				speStat.core.value = 200;
				armorDef = 36;
				lustVuln = 0.0;
			}

			if (_roundCount == 5) gropehands();
			else
			{
				var atks:Array = [parasiteThrowingStars, whiptrip, sonicwhip];
				if (!player.hasStatusEffect(StatusEffects.WhipSilence)) atks.push(whipchoke);

				atks[rand(atks.length)]();
			}
		}

		private function parasiteThrowingStars():void
		{
			outputText("Lethice retrieves three squirming, star-shaped creatures from beneath her clothes and flings them at you. A split second after they leave her hand, needles burst from their edges!");
			var ev:String = player.getEvasionReason();
			if (ev == EVASION_EVADE)
			{
				outputText(" You barely avoid the living throwing stars.");
			}
			else if (ev == EVASION_MISDIRECTION)
			{
				outputText(" Your misdirecting movements allow you to avoid the living throwing stars.");
			}
			else if (ev == EVASION_FLEXIBILITY)
			{
				outputText(" You bend over backwards to avoid the living throwing stars.");
			}
			else if (ev != null)
			{
				outputText(" The living throwing stars whistle by you, barely missing you.");
			}
			else
			{
				var l:Number = player.lib + player.cor + 100;
				if (player.hasStatusEffect(StatusEffects.MinotaurKingsTouch)) l *= 1.25;
				player.takeLustDamage(l, true);
				
				var damage:Number = str + weaponAttack - rand(player.touStat.core.value);
				damage = player.takePhysDamage(damage);

				outputText(" You can’t avoid them all! One clips you on its way past, ripping into your [skin] and leaving you feeling... flushed and hot in its wake.");
				if (player.hasCock())
				{
					outputText(" There’s suddenly a dearth of room in the crotch of your [armor], rubbing distractingly and slowing you with added weight. <b>[EachCock] has grown bigger!</b>");

					player.increaseEachCock(1);
				}
				else if (player.biggestTitSize() <= 0)
				{
					outputText(" The inside of your [armor] is suddenly pressing back on your [nipples]. <b>You’ve grown breasts!</b> That bitch!");
					player.growTits(3, player.breastRows.length, false, 2);
				}
				else
				{
					outputText(" There’s suddenly a dearth of room in the chest of your [armor]. Your [chest] are expanding, bouncing distractingly and slowing you with the extra weight!");
					player.growTits(2, player.breastRows.length, false, 2);
				}
				if(damage > 0){
					outputText(" (" + damage + ")");
				}
			}
		}

		private function whiptrip():void
		{
			//Light damages even on avoidance. Can stun.
			outputText("Lethice slashes her whip in a wide, low arc.");

			var minDamage:Boolean = false;
			if (player.getEvasionRoll())
			{
				outputText(" You jump over it at the last second, the heat singing your [feet].");
				minDamage = true;
			}
			else
			{
				outputText("You try to avoid it, but the burning weapon catches your [leg], simultaneously scorching your flesh and attempting to pull you off balance.");

				if (!player.hasPerk(PerkLib.Resolute) && rand(player.touStat.core.value) <= 25)
				{
					outputText(" The ground rushes up at you awful fast. Lethice has tripped you, <b>stunning you!</b>");
					player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				}
				else
				{
					outputText(" Lethice is going to need to pull a lot harder if she wants to trip you.");
				}
			}

			var damage:Number;
			if (minDamage)
			{
				damage = (25 + weaponAttack) * 10 - rand(player.touStat.core.value);
			}
			else
			{
				damage = (100 + weaponAttack + str) * 10 - rand(player.touStat.core.value);
			}

			player.takeMagicDamage(damage, true);
		}

		private function sonicwhip():void
		{
			outputText("Lethice raises her sizzling, flame-spitting whip high up overhead, then snaps her arm out and back in an instant, cracking the whip so hard that it gives birth to a shockwave of flame and cacophonous thunder. There’s no avoiding the all-encompassing wave of energy. There’s not even time to brace yourself. It slams into you, rattling bones and scorching flesh.");

			var damage:Number = (75 + weaponAttack + str) * 10;
			player.takeMagicDamage(damage,true);
		}

		private function whipchoke():void
		{
			outputText("<i>\"Silence your prattling, curr.\"</i> Lethice strikes out with her whip, aimed at your neck!");
			var ev:String = player.getEvasionReason();
			if (ev == EVASION_EVADE)
			{
				outputText(" You evade the targeted strike.");
			}
			else if (ev == EVASION_FLEXIBILITY)
			{
				outputText(" You twist aside at the last moment.");
			}
			else if (ev == EVASION_MISDIRECTION)
			{
				outputText(" Raphael taught you well. Lethice failed to account for your misleading movements and swung wide.");
			}
			else if (ev != null)
			{
				outputText(" You barely avoid it.");
			}
			else
			{
				outputText("\n\nYou gasp when the burning cord encircles your throat, unable to speak and unable to discern why the licking flames haven’t scorched the flesh from your face. Laughing, the queen snaps her end of the whip off like a rotten cord, dropping the burning length to the ground with disdain. The unattached end loops around your neck again and again, binding tight. At the same time, fresh flame boils out of the tightly held handle, revealing a sinuously slithering implement of pain no worse for the wear.");
				outputText("\n\n<b>You are effectively silenced!</b>");
				var damage:Number = weaponAttack + 25 - rand(player.touStat.core.value);
				player.takePhysDamage(damage,true);
				player.createStatusEffect(StatusEffects.WhipSilence, 3, 0, 0, 0);
			}
		}

		private function gropehands():void
		{
			outputText("<i>\"Let’s see how you fight while you’re being groped, shall we? A shame Pigby isn’t around to see how I’ve improved his hands,\"</i> Lethice murmurs. Cupping her hands into a parody of lecher’s grip, the corruptive Queen squeezes and chants. Immediately, you feel phantasmal hands all over your body, reaching through your armor to fondle your bare [skinFurScales]. Digits slip into your [butt]. Fingertips brush your [nipples]. Warm palms slide down your quivering belly toward your vulnerable loins.");
			outputText("\n\nYou glare daggers at Lethice, but she merely laughs. <i>\"A shame I never got to convince him that his hands were so much more effective when used like this.\"</i>");
			player.takeLustDamage(5, true);
			player.createStatusEffect(StatusEffects.PigbysHands, 0, 0, 0, 0);
		}
	}
}
