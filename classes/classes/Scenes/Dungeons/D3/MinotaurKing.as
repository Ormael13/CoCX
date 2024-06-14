package classes.Scenes.Dungeons.D3
{
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.CockTypesEnum;
import classes.GlobalFlags.kFLAGS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.internals.WeightedDrop;
import classes.EngineCore;

import coc.view.CoCButton;

public class MinotaurKing extends Monster
	{
		public function MinotaurKing()
		{
			if (player.hasStatusEffect(StatusEffects.SoulArena)) {
				this.short = "minotaur challanger";
				initStrTouSpeInte(140, 140, 100, 45);
				initWisLibSensCor(35, 160, 20, 100);
				this.weaponAttack = 90;
				this.armorDef = 60;
				this.armorMDef = 40;
				this.bonusHP = 5000;
				this.bonusLust = 197;
				this.gems = 10 + rand(20);
				this.additionalXP = 300;
				this.level = 17;
			}
			else {
				this.short = "minotaur king";
				initStrTouSpeInte(390, 390, 200, 90);
				initWisLibSensCor(70, 320, 40, 100);
				this.weaponAttack = 190;
				this.armorDef = 120;
				this.armorMDef = 80;
				this.bonusHP = 5000;
				this.bonusLust = 437;
				this.gems = 1000 + rand(200);
				this.additionalXP = 3000;
				this.level = 77;
			}
			this.a = "the ";
			this.long = "";
			this.tallness = 12 * 14;
			this.createCock(24, 5, CockTypesEnum.HORSE);
			this.createBreastRow(0);
			this.balls = 2;
			this.ballSize = 4;
			this.hoursSinceCum = 9999;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.weaponName = "axe";
			this.weaponVerb = "swing";
			this.armorName = "rags";
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Diehard, 0, 0, 0, 0);
			this.createPerk(PerkLib.ImprovedDiehard, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.drop = NO_DROP;
			drop = new WeightedDrop(consumables.PROMEAD, 1);
			//I don’t know if we ever got multiple item drops set up for CoC. If we did, have this guy drop a five-stack of God’s Mead for the Lethice fight. Otherwise, perhaps drop a single item that will full heal once?
			this.checkMonster();
			_lastSpellCastCount = flags[kFLAGS.SPELLS_CAST];
		}

		override public function get long():String
		{
			if (!_orgasms == 0)
			{
				return "Positioned "+(player.hasStatusEffect(StatusEffects.SoulArena)?"before you":"between you and the Demon Queen")+" is an opponent of singular size and stature - the Minotaur "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Challanger":"King")+". He is a beast beyond measure, covered in shaggy fur and a few scraps of leather that do nothing to hide the pillar of flared cuntplow between his legs. In his hands is a gigantic axe, though he seems loathe to use it, preferring to rely on the erotic scent emanating from between his legs. He smells virile, strong, and more alluring than you’d expect. You’d best be careful not to dwell on it.";
			}
			else
			{
				var str:String = "Still standing "+(player.hasStatusEffect(StatusEffects.SoulArena)?"before you":"between you and the Demon Queen")+", the Minotaur "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Challanger":"King")+" is breathing heavily. His cock is slathered with the residue of his own potent orgasm. His immense, 14 foot tall form hunches slightly as he stares at you, one hand still clutching to his axe. Driving him back to his peak would undoubtedly push him even beyond his considerable endurance. The only problem is that alluring <i>aroma</i> that surrounds him, suffusing the air with the scent of sweaty bedroom romps and sizzling pleasure. You better finish him quick.";
				//Excellia description
                if (!player.hasStatusEffect(StatusEffects.MinoKing)) { 
                    if (lust < 40)
                        str += "\n\nBeneath his legs is a favorite "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Lacta Bovina slut and wife at the same time":"slut, Excellia by name")+". She stays just out of his way, showcasing the curvaceous nature of her figure and the ripeness of her sex, occasionally running her fingers across a strange tattoo laid upon her belly. You’d best keep your attentions on the fight ahead.";
                    else if (lust < 80)
                        str += "\n\nBeneath his legs is the fallen form of his "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Lacta Bovina slutty wife":"favored slut, Excellia")+". He steps carefully around the insensate cow-girl but never lets her out of arm’s reach, his eyes flicking to the moistness of her sex from time to time.";
                    else
                        str += "\n\nBeneath his legs is the creampied form of his "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Lacta Bovina slutty wife":"favored slut, Excellia")+". Milk-white cum puddles between her spread legs, matched only by the sheen of leaking lactose on her lewdly-jutting nipples. Her lord never lets her fallen form out of arm’s reach, just in case he needs a drink.";
                }
				// milkdrinks
				if (_milkDrinks == 1) str += "\n\n<b>The "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Challanger":"King")+" has been glancing appreciatively in your direction ever since he took a drink from his slave-slut’s nipples. Perhaps he’s more vulnerable to baser needs...</b>";
				else if (_milkDrinks > 1) str += "\n\n<b>The "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Challanger":"King")+"’s nostrils flare as he stares at you. It’s clear that with every drink he takes from his slave-slut’s nipples, he becomes more receptive to your advances.</b>";
				return str;
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (!(flags[kFLAGS.GAME_DIFFICULTY] == 0 && (player.statusEffectv1(StatusEffects.MinotaurKingMusk) < 4 || (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1 && player.statusEffectv1(StatusEffects.MinotaurKingMusk) < 2)))) {
				if (_orgasms == 0 && !hpVictory && !player.hasStatusEffect(StatusEffects.MinoKing)) {
					lustDump();
					doNext(SceneLib.combat.combatMenu, false);
					return;
				}
				if (hpVictory && !player.hasStatusEffect(StatusEffects.MinoKing)) {
					hpRestore();
					SceneLib.combat.disableEachHelperIfTheyCauseSoftLock();
					doNext(SceneLib.combat.combatMenu, false);
					return;
				}
			}
            player.removeStatusEffect(StatusEffects.MinoKing);
			if (player.hasStatusEffect(StatusEffects.SoulArena)) SceneLib.hexindao.intermediateleadershipfight2();
			else SceneLib.d3.minotaurKing.theKingIsDeadLongLiveTheKing();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
            player.removeStatusEffect(StatusEffects.MinoKing);
			if (player.hasStatusEffect(StatusEffects.SoulArena)) cleanupAfterCombat();
			else {
				if (player.isGargoyle()) SceneLib.d3.gargoyleBadEndD3();
				else SceneLib.d3.minotaurKing.hailToTheKingBaby(hpVictory, pcCameWorms);
			}
		}

		private var _milkDrinks:int = 0;
		private var _orgasms:int = 0;
		public function get orgasms():int { return _orgasms; }
		private var _lastRoundStun:Boolean = false;
		private var _lastSpellCastCount:int;
		
		private var atks:Array = [backhand, battleaxe, minoPheromones];
		override protected function performCombatAction():void
		{
			// Attempt dickslap if the player was stunned in the last round
			if (_lastRoundStun) {
				_lastRoundStun = false;
				// If the player is still stunned, use dickslap ohterwise fall through to regular AI.
				if (player.hasStatusEffect(StatusEffects.Stunned)) {
					dickslap();
					return;
				}
			}
            if (!player.hasStatusEffect(StatusEffects.MinoKing) && player.hasCock() && rand(2) == 0) {
                cowslutTeaseCocks();
                outputText("\n\n");
            }
			if (_lastSpellCastCount != flags[kFLAGS.SPELLS_CAST]) {
				_lastSpellCastCount = flags[kFLAGS.SPELLS_CAST];
				headbutt();
			}
			else atks[rand(atks.length)]();
		}

		private function backhand():void
		{
			outputText("Feinting with his axe, the Minotaur "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Challanger":"King")+" flings a powerful backhand in your direction.");
			var damage:Number = (str + weaponAttack) - rand(player.tou);
			if (damage <= 0 || player.getEvasionRoll())
			{
				outputText(" Luckily, you dodge aside.");
			}
			else
			{
				damage = player.takePhysDamage(damage);
				outputText(" Damn, that hurts! (" + damage +")");
			}
		}
		
		private function headbutt():void
		{
			outputText("<i>\"Settle down,\"</i> the brute growls, moments before attempting to slam his forehead into your own.");
			var damage:Number = ((str + weaponAttack) / 2) - rand(player.tou);
			if (damage <= 0 || player.getEvasionRoll())
				outputText(" Luckily, you dodge aside.");
			else {
				_lastRoundStun = true;
				damage = player.takePhysDamage(damage);
				outputText(" He impacts with stunning force, leaving you reeling! (" + damage +")");
				//{Stun for one turn, minor HP damage}
				if (!player.hasPerk(PerkLib.Resolute))
				{
					outputText(" <b>You're left stunned by the force of the blow!</b>");
					player.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
				}
			}
		}

		private function dickslap():void
		{
			//Used after stunning PC.
			outputText("Before you can completely regain your wits, the brute is on you, easily holding your hand in one hand while he none-too-gently smacks his cock into your face, dragging his musky member back and forth across your cheeks before finally breaking contact.");
			if (_orgasms > 0)
			{
				outputText(" Strands of his");
				if(player.hasPerk(PerkLib.MinotaurCumAddict)) outputText(" god-like");
				outputText(" spunk hang from your nose until your tongue lashes out to collect them.");
				if (player.hasPerk(PerkLib.MinotaurCumAddict)) outputText(" Delicious.");
				else outputText(" Why did you do that? And why did it feel so good.");
			}
			player.takeLustDamage(15 + player.lib/20, true);
		}

		private function battleaxe():void
		{
			outputText("The Minotaur "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Challanger":"King")+" carries his axe as if it weighed no more than a feather, brandishing it back and forth with such casual movements that you barely register his swing");
			var damage:Number = (str + weaponAttack) - rand(player.tou);
			if (damage <= 0 || player.getEvasionRoll())
				outputText(" in time to avoid it.");
			else {
				damage = player.takePhysDamage(damage);
				outputText(". By the time you notice, it’s too late. ("+damage+")");
			}
		}

		private function hpRestore():void
		{
			HP = maxHP();
			lustVuln += 0.15;
			_milkDrinks++;
			//Full HP restore.
			outputText("Staggering back, the "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Challanger":"King")+" wastes no time in appropriating his willing slave, lifting her up to his face as easily as one might heft a stein of fresh-brewed beer. One of her huge tits easily fits against the oversized minotaur’s lips, and you see him noisily gulping down a quick, milky pick-me-up. By the time he finishes, his wounds are closing, but his cock is twitching and leaking pre-cum like water from a sieve.");
			outputText("\n\n<b>He looks like he’d be easier to arouse. Whatever’s in her milk may restore his wounds, but leave him vulnerable to his animalistic needs.</b>");
			outputText("\n\n<i>Dealing with the "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Challanger":"King")+" would be much easier if someone distracted his slut.</i>");
			if (flags[kFLAGS.GAME_DIFFICULTY] == 0) player.addStatusValue(StatusEffects.MinotaurKingMusk, 1, 1);
		}
		
		// copypasta I dun even give a fuck ¯\_(ツ)_/¯
		private function minoPheromones():void 
		{
			outputText("The minotaur smiles at you and lifts his loincloth, flicking it at you.  Thick ropes of pre-cum fly through the air, ");
			//sometimes get hit with the pre for stronger effect!
			if(rand(3) == 0) {
				outputText("slapping into your face before you can react!  You wipe the slick snot-like stuff out of your eyes and nose, ");
				if(player.lust > 75) {
					outputText("swallowing it into your mouth without thinking.  ");
					player.takeLustDamage(15 + player.lib/10, true);
				}
				else {
					outputText("feeling your heart beat with desire as your tongue licks the residue from your lips.  ");
					player.takeLustDamage(7.5 + player.lib/20, true);
				}
			}
			else outputText("right past your head.  ");
			outputText("The animalistic scent of it seems to get inside you, the musky aroma burning a path of liquid heat to your groin.");
			player.takeLustDamage(15 + player.lib/20, true);
			if(player.hasPerk(PerkLib.MinotaurCumAddict) || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2) {
				if(rand(2) == 0) outputText("\n<b>You shiver with need, wanting nothing more than to bury your face under that loincloth and slurp out every drop of goopey goodness.</b>");
				else outputText("\n<b>You groan and lick your lips over and over, craving the taste of him in your mouth.</b>");
				player.takeLustDamage(10+rand(10), true);
			}
		}

		public function lustDump():void
		{
			_orgasms++;
			outputText("The incredibly-aroused minotaur staggers, then looks down at the log of tumescence between his legs. It’s twitching, bouncing in the air with every beat of his heart. It must ache to be that hard, to be so full of lust it looks ready to erupt. One of his hands reaches toward it, and he drops to one knee. Have you done it? Have you defeated the brute once and for all?");
			outputText("\n\nA monstrous hand closes around "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Excellia’s":"cow’s maid")+" torso, lifting her into the air. The curvy cow-slut does the only thing she can in such a situation - she moos and spreads her legs, a gleeful smile plastered across her excited visage. The Minotaur "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Challanger":"King")+" doesn’t wait a second, impaling her on the spot, sliding what looks like three feet of virile cock deep into his favorite slut. His balls slap against her bulging belly once he’s fully inside, getting a coating of pussy-juice for their trouble.");
			outputText("\n\nThe brute fucks her casually, using her like little more than a super-sized sex-toy. Every sheath-hilting clap of hips to ass sends jiggles through the nubile slave. Flecks of pussy-juice and pre-cum froth around the entrance to her gaped cunt while stray droplets slick the floor below. It’s a bestial mating, the kind that leaves no room for words on either partner’s face. The kind that has the cow-girl quivering and shaking in the throes of indescribable ecstasy, rendered incapable of something as simple as moaning.");
			outputText("\n\n"+(player.hasStatusEffect(StatusEffects.SoulArena)?"Excellia’s":"cow’s maid")+" master joins her a second later. There’s little change in the sound of his grunts. You wouldn’t even know if it wasn’t for the sudden ballooning of her belly and the cascade of cum between her legs, coating her lord’s legs in a veneer of lusty white. The amount of spunk is absolutely gobsmacking. You watch in awe as "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Excellia’s":"cow’s maid")+" formerly taut belly stretches into a gravid dome. She looks like she could give birth any moment now, yet there’s nothing in her womb but gallon upon gallon of tainted minotaur spunk.");
			if (player.hasPerk(PerkLib.MinotaurCumAddict)) outputText(" You’re jealous. All that cum must feel exquisite!");
			outputText("\n\nWhatever spell this forceful mating cast, it breaks the moment "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Lacta Bovina":"Excellia")+" slides off her lord’s still-hard phallus. You close your mouth and ready your grip on your [weapon] as the Minotaur "+(player.hasStatusEffect(StatusEffects.SoulArena)?"Challanger":"King")+" straightens, breathing heavily. He looks a little woozy for the effort, but still good to fight. Maybe if you can bring him back to the peak, he’ll fall for good?");
			lust = 0;
			if (flags[kFLAGS.GAME_DIFFICULTY] == 0) player.addStatusValue(StatusEffects.MinotaurKingMusk, 1, 1);
		}

		private function cowslutTeaseCocks():void
		{
            switch(rand(3)) {
            case 0:
                outputText(""+(player.hasStatusEffect(StatusEffects.SoulArena)?"Lacta Bovina":"Excellia")+" crawls over to you while you’re distracted with her lord and wraps her arms around your waist, crushing her milk-swollen tits against your crotch. You can feel their warmth through your [armor], promising nothing but bliss in their embrace. When you push her away, you become aware of the rivers of milk she poured down your");
                if (player.isNaga()) outputText(" [leg]");
                else outputText(" [legs]");
                outputText(", a reminder of the woman’s insane fuckability.");
                break;
            case 1:
                outputText("Turning about, the cow-slave aims her bubbly ass in your direction and lifts her tail, revealing both her dripping delta and the puckered star of her asshole. She looks back over her shoulder and sensuously slides her tongue across her gold-gilt lips, blowing you a pouty kiss once her mouth is suitably shiny. If she meant to distract you, she was at least partially successful.");
                break;
            case 2:
                outputText(""+(player.hasStatusEffect(StatusEffects.SoulArena)?"Lacta Bovina":"Excellia")+" rises up onto her knees and arches her back to display her monumental mammaries, letting their chocolatey nipples jut accusingly in your direction. Her fingers travel to them, squeezing out thin flows of milk that she gathers and smears across each orb in turn, rubbing it into her skin like high-grade massage oil. When she’s finished, her tits are shining, and you’re a little hotter under the collar.");
                break;
            }
            player.takeLustDamage(10+rand(player.lib/20), true);
		}

		override protected function handleStun():Boolean
		{
			if (hasStatusEffect(StatusEffects.MonsterAttacksDisabled))
				return super.handleStun();
			else {
				outputText("It only takes the muscled "+(player.hasStatusEffect(StatusEffects.SoulArena)?"champion":"monarch")+" a moment to recover from the stun. It looks like he’s too much of a juggernaught to be stopped by those kinds of hits. ");
				return true;
			}
		}

		override public function postPlayerBusyBtnSpecial(btnSpecial1:CoCButton, btnSpecial2:CoCButton):void{
			if (!player.hasStatusEffect(StatusEffects.MinoKing) && player.companionsInPCParty()) btnSpecial1.show("Dish Helper", SceneLib.hexindao.dishHelper);
			else btnSpecial1.showDisabled("Dish Helper", "You don't have anyone to take care of "+(player.hasStatusEffect(StatusEffects.SoulArena)?"cow maid":"Excellia")+"!");
		}
	}
}