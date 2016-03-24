package classes.Scenes.Dungeons.D3
{
	import classes.Scenes.Areas.Swamp.AbstractSpiderMorph;
	import classes.StatusEffects;
	import classes.PerkLib;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.CockTypesEnum;
	
	public class DriderIncubus extends AbstractSpiderMorph
	{
		 
		private var _goblinFree:Boolean = false;
		
		private var _combatRound:int = 0;
		
		private var _hpGains:int = 0;
		
		private var _seenResolute:Boolean = false;
		
		private var _goblinWebChain:Boolean = false;
		
		private var _goblinOiled:Boolean = false;
		
		public function DriderIncubus()
		{
			super();
			this.a = "the ";
			this.short = "drider incubus";
			this.long = "The drider incubus is a marvel of demonic perversions applied to inhuman flesh. His glittering dark skin is like a solid sheet of coal. Twisted obsidian horns spiral from his forehead like a pair of misshapen spears. Even his eyes are an eerie marvel, no longer windows to the soul, only pits of endless hunger. His evil visage pales in comparison to the monstrous form below his waist - that of a gigantic spider. Eight clattering legs skitter across the floor with his every move. A bulbous abdomen hangs behind them, covered with twitching spinnerets so full of silk that half-formed blobs of it dangle behind him.\n\nHanging from an impeccably made harness is a goblin, the only splash of color on the soulless abomination before you. She’s positioned against the larger male’s abdomen so that her bare crotch is impaled upon his turgid, writhing demon-dick, and by the looks of her frantic squirming, is doing her best to escape. Perhaps you could free her?";
			this.tallness = 12 * 9;
			this.createCock(24,5,CockTypesEnum.DEMON);
			this.createBreastRow(0);
			this.balls = 2;
			this.ballSize = 4;
			this.hoursSinceCum = 9999;
			this.hipRating = HIP_RATING_SLENDER;
			this.buttRating = BUTT_RATING_TIGHT;
			initStrTouSpeInte(65,80,90,70);
			initLibSensCor(66,40,100);
			this.weaponName = "spear";
			this.weaponAttack = 19;
			this.weaponVerb = "lunge";
			this.armorName = "chitin";
			this.armorDef = 40;
			this.bonusHP = 500;
			this.gems = 75 + rand(50);
			this.level = 22;
			this.additionalXP = 200;
			this.lustVuln = 0.45;
			this.drop = NO_DROP;
			this.checkMonster();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.d3.driderIncubus.beatTheSpooderbutt(hpVictory);
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.d3.driderIncubus.spooderbuttGetsANewCockSleeve(hpVictory,pcCameWorms);
		}
		
		public function get goblinFree():Boolean
		{
			return this._goblinFree;
		}
		
		public function set goblinFree(v:Boolean):void
		{
			if (v != this._goblinFree)
			{
				this.long = "The drider incubus is a marvel of demonic perversions applied to inhuman flesh. His glittering dark skin is like a solid sheet of coal. Twisted obsidian horns spiral from his forehead like a pair of misshapen spears. Even his eyes are an eerie marvel, no longer windows to the soul, only pits of endless hunger. His evil visage pales in comparison to the monstrous form below his waist - that of a gigantic spider. Eight clattering legs skitter across the floor with his every move. A bulbous abdomen hangs behind them, covered with twitching spinnerets so full of silk that half-formed blobs of it dangle behind him.";
				if (!v)
				{
					this.long = this.long + "Hanging from an impeccably made harness is a goblin, the only splash of color on the soulless abomination before you. She’s positioned against the larger male’s abdomen so that her bare crotch is impaled upon his turgid, writhing demon-dick, and by the looks of her frantic squirming, is doing her best to escape. Perhaps you could free her?";
				}
				else
				{
					this.long = this.long + "The goblin you freed heedlessly chases her demonic master around the room, doing everything she can to bring his rod off. She seems barely conscious of the ongoing conflict; it’s a wonder the drider hasn’t stepped on her yet.";
				}
			}
		}
		
		override protected function performCombatAction():void
		{
			this._combatRound++;
			if (this.lust < 65 && this.HP < 33)
			{
				this.gainHpAndLust();
			}
			else if (this.lust >= 65 && this.HP >= 33)
			{
				this.dropHpAndLust();
			}
			if (rand(100) > lust + 10)
			{
				this.spearStrike();
				outputText("\n\n");
				this.performPhysicalAttack();
			}
			else
			{
				this.performLustAttack();
			}
			if (this._goblinFree)
			{
				outputText("\n\n");
				this.goblinAI();
			}
			combatRoundOver();
		}
		
		private function performPhysicalAttack():void
		{
			var opts:Array = null;
			if (this._combatRound >= 3 && (this._combatRound % 6 == 0 || this._combatRound == 3))
			{
				this.stunningSpear();
			}
			else
			{
				opts = [this.bite,spiderMorphWebAttack,this.kick,this.kick,this.doubleStrike,this.doubleStrike];
				opts[rand(opts.length)]();
			}
		}
		
		private function performLustAttack():void
		{
			var opts:Array = null;
			if (this._combatRound >= 3 && (this._combatRound % 6 == 0 || this._combatRound == 3))
			{
				this.constrictingThoughts();
			}
			else
			{
				opts = [this.arouseSpell,this.arouseSpell];
				if (player.findStatusEffect(StatusEffects.TaintedMind) < 0 && !this._seenResolute)
				{
					opts.push(this.taintedMind);
				}
				if (!this._seenResolute)
				{
					opts.push(this.purpleHaze);
				}
				opts[rand(opts.length)]();
			}
		}
		
		private function goblinAI():void
		{
			var opts:Array = [this.goblinHandjob,this.goblinTongueGrapple,this.bootyTwerking,this.webNipplechain];
			if (!this._goblinOiled)
			{
				opts.push(this.babyOilMeUp);
			}
			opts[rand(opts.length)]();
		}
		
		private function gainHpAndLust():void
		{
			this.addHP(this.eMaxHP() * 0.1);
			this.lust += 8;
			if (this._hpGains == 0)
			{
				outputText("<i>“You won’t defeat me so easily!”</i>");
			}
			else if (this._hpGains == 1)
			{
				outputText("<i>“I can keep this up longer than you, mortal!”</i>");
			}
			else if (this._hpGains == 2)
			{
				outputText("<i>“So stubborn! Lethice take you!”</i>");
			}
			else
			{
				outputText("<i>“Why won’t you give in?!”</i>");
			}
			this._hpGains++;
			outputText(" The demon gestures wildly, drawing a rune across his own chest. It flares, blood red and pulsing. Your foe’s wounds slowly edge close, fueled by magic. When the luminous symbol fades, the drider pants, his black skin flushing purple in places.");
			if (this.lust > 65)
			{
				if (this._goblinFree)
				{
					outputText(" His dick is rigid and bouncing, so hard it looks like it could go off at any moment.");
				}
				else
				{
					outputText(" His balls are tensing underneath the goblin, and he keeps moaning under his breath.");
				}
				outputText(" You doubt he can keep drawing on his lust to heal himself without pushing himself over the edge!");
			}
			outputText("\n\n");
		}
		
		private function dropHpAndLust():void
		{
			this.HP = this.HP - this.eMaxHP() * 0.08;
			this.lust = this.lust - 10;
			outputText("The demon snarls and draws his spear back, placing it blade down against his arm. Grinning malevolently, he slides the razor-sharp edge along his skin, leaving a trail of glittering ruby on his wounded flesh. <i>“Pain brings clarity of mind - something you couldn’t understand.”</i> He grins wider, mastering his baser emotions. <i>“Let me teach you.”</i>\n\n");
		}
		
		private function spearStrike():void
		{
			outputText("The drider rears back, lancing out with his spear.");
			var damage:Number = ((str + weaponAttack) * 0.4) * (1 + (player.newGamePlusMod() * 0.3));
			var evade:String = player.getEvasionReason();
			if (damage <= 0 || evade == EVASION_SPEED || evade == EVASION_FLEXIBILITY || evade == EVASION_UNHINDERED)
			{
				outputText(" You barely slide out of the way.");
			}
			else if (evade == EVASION_EVADE)
			{
				outputText(" You evade the strike.");
			}
			else if (evade == EVASION_MISDIRECTION)
			{
				outputText(" Using your skills at misdirection, you avoid the strike.");
			}
			else
			{
				outputText(" The weapon bites deep. ");
				player.takeDamage(damage, true);
			}
		}
		
		private function bite():void
		{
			var amount:Number = 0;
			var evade:String = player.getEvasionReason();
			if (player.findStatusEffect(StatusEffects.Stunned) >= 0 || player.spe <= 1 && player.findStatusEffect(StatusEffects.Web) >= 2)
			{
				if (player.findStatusEffect(StatusEffects.DriderIncubusVenom) >= 0)
				{
					player.changeStatusValue(StatusEffects.DriderIncubusVenom,1,5);
				}
				else
				{
					player.createStatusEffect(StatusEffects.DriderIncubusVenom,5,0,0,0);
				}
				amount = 30;
				if (player.str - amount < 1)
				{
					amount = player.str - 1;
				}
				player.str = player.str - amount;
				showStatDown("str");
				player.addStatusValue(StatusEffects.DriderIncubusVenom,2,amount);
				outputText("Taking his time, the arachnid demon bares his fangs, easily biting deeply into you. His tongue slides sensually around the wounds as he pumps you full of venom, tasting your fear and desperation. You wince while the venom robs you of your strength.");
				if (player.str <= 25)
				{
					outputText(" It’s getting harder just to remain upright.");
				}
				else if (player.str <= 1)
				{
					outputText(" You don’t think you can stand any longer, let alone resist.");
				}
				outputText("\n\nWhen he pulls out, he’s smiling and a little flushed. <i>“");
				if (player.str > 25)
				{
					outputText("That should do.");
				}
				else
				{
					outputText("Soon you won’t have the strength to resist.");
				}
				outputText("”</i>");
			}
			else
			{
				outputText("Twisting over, the arachnid demon bares his fangs, attempting to bite you!");
				if (evade == EVASION_MISDIRECTION)
					outputText(" You misdirect his venomous strike!");
				else if (evade == EVASION_EVADE)
					outputText(" You evade his venomous strike!");
				else if (evade == EVASION_SPEED || evade == EVASION_FLEXIBILITY || evade == EVASION_UNHINDERED)
					outputText(" You avoid his venomous strike!");
				else {
					outputText(" Those needle-like canines punch into you, delivering their venomous payload! You already feel weaker, your muscles not responding as effectively.");
					outputText("<i>“I do love watching you struggle.”</i> He flashes a crooked smile.");
					if (player.findStatusEffect(StatusEffects.DriderIncubusVenom) >= 0)
						player.changeStatusValue(StatusEffects.DriderIncubusVenom,1,5);
					else
						player.createStatusEffect(StatusEffects.DriderIncubusVenom,5,0,0,0);
					amount = 30;
					if (player.str - amount < 1)
						amount = player.str - 1;
					player.str = player.str - amount;
					showStatDown("str");
					player.addStatusValue(StatusEffects.DriderIncubusVenom,2,amount);
				}
			}
		}
		
		private function kick():void
		{
			outputText("While you’re busy with his spear, he nonchalantly snaps a kick in your direction!");
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_MISDIRECTION)
			{
				outputText(" You twist out of the way at the last moment thanks to your misdirection.");
			}
			else if (evade != null)
			{
				outputText(" You twist out of the way at the last moment, evading with ease.");
			}
			else
			{
				var damage:Number = (str + weaponAttack + 25 - rand(player.tou)) * (1 + (player.newGamePlusMod() * 0.3));
				if (damage > 0)
				{
					outputText(" You go flying back into a pair of oiled-up slavegirls. They gasp in surprise as you tear your way back to the fight. Too late, they attempt to caress you, barely touching your [leg] before you’re back in the fight. ");
					damage = player.takeDamage(damage, true);
				}
				else
				{
					outputText(" You successfully manage to block the kick!");
				}
			}
		}
		
		private function stunningSpear():void
		{
			outputText("Twirling his weapon until it appears a blurred disc, the drider pivots, bringing the haft around at your head!");
			var damage:Number = 0;
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_SPEED || evade == EVASION_FLEXIBILITY || evade == EVASION_UNHINDERED)
			{
				outputText(" You duck in the nick of time.");
			}
			else if (evade == EVASION_MISDIRECTION)
			{
				outputText(" You were already changing direction. You silently thank Raphael for his training.");
			}
			else if (evade == EVASION_EVADE)
			{
				outputText(" You lean in the direction of the swing, letting gravity pull you down and away from the stunning blow.");
			}
			else
			{
				damage = (str + weaponAttack - 25 - rand(player.tou)) * (1 + (player.newGamePlusMod() * 0.3));
				if (damage > 0)
				{
					
					outputText(" You don’t feel the impact, but you do hear the crack of wood striking");
					outputText(" bone");
					outputText(".");
					if (player.findPerk(PerkLib.Resolute) < 0)
					{
						outputText(" <b>You’re left stunned by the blow!</b> It’ll be a moment before you can regain your wits. ");
						player.createStatusEffect(StatusEffects.Stunned,0,0,0,0);
					}
					damage = player.takeDamage(damage, true);
				}
				outputText(" You hear the crack of wood striking");
				outputText(" bone");
				outputText(", but you manage to deflect most of the force!");
			}
		}
		
		private function doubleStrike():void
		{
			outputText("He skitters forward and presses his attack, stabbing out with his spear once more.");
			var damage:Number = str + weaponAttack + 10 - rand(player.tou);
			var evade:String = player.getEvasionReason();
			if (damage <= 0 || evade == EVASION_SPEED || evade == EVASION_FLEXIBILITY || evade == EVASION_UNHINDERED)
			{
				outputText(" You barely slide out of the way.");
			}
			else if (evade == EVASION_EVADE)
			{
				outputText(" You evade the strike.");
			}
			else if (evade == EVASION_MISDIRECTION)
			{
				outputText(" Using your skills at misdirection, you avoid the strike.");
			}
			else
			{
				outputText(" The weapon bites deep. ");
				player.takeDamage(damage, true);
			}
		}
		
		private function arouseSpell():void
		{
			outputText("The demonic drider mutters incomprehensible words that tickle at the back of your mind. Profane syllable mounts profane syllable until his mouth seems buried under the weight of the cacophony of corruption. His filth builds to a crescendo, and with a confident, arrogant gaze, he directs it at you.");
			outputText("\n\nAn invisible force falls upon you, infusing the most sensitive places of your body with desire, bringing your [nipples] to life with need");
			if (player.cocks.length > 0 || player.vaginas.length > 0)
			{
				outputText(", making your");
				if (player.cocks.length > 0)
					outputText(" [cocks]");
				else
					outputText(" [vagina]");
				outputText(" ache to be touched");
			}
			game.dynStats("lus",player.lib / 10 + player.cor / 10 + 15);
			outputText(". Your body rebels against you under the unholy influence");
			if (player.lust < 100)
				outputText(", but the effect is fleeting, thankfully. You try to ignore the residual tingles. You can’t afford to lose this close to your goal!");
			else
				outputText(".");
		}
		
		private function taintedMind():void
		{
			outputText("<i>“You fight well, for a mortal... but can you fight like a demon?”</i> He claps his hands together, bathing the immediate area in a wave of energy. Some of the nearby slaves cry out in alarm, then settle into giggling, cooing messes. You don’t seem any worse for the wear in its wake, though something feels wrong about holding your [weapon].");
			if (player.cor <= 33)
				outputText(" What did he mean about fighting like a demon?");
			player.createStatusEffect(StatusEffects.TaintedMind,4,0,0,0);
		}
		
		public function taintedMindAttackAttempt():void
		{
			outputText("You ready an attack, but find your hands groping your own body instead. Somehow the demon’s magic has made it impossible to strike at him, crossing wires that weren’t meant to be crossed. Frowning, you look down at your more aroused form, determined not to fall for this a second time.");
			game.dynStats("lus",15);
		}
		
		private function constrictingThoughts():void
		{
			outputText("<i>“Try this on for size!”</i> the corrupted arachnid shouts, waving his hand in your direction.");
			outputText("\n\nDisjointed, erotic thoughts claw at your mind’s defenses, worming their way in through what cracks they find, plunging sensuous fantasies of every shape and size in place of your own imaginings.");
			if (player.findPerk(PerkLib.Resolute) >= 0)
			{
				this._seenResolute = true;
				outputText(" You marshal your mental discipline and discard the errant thoughts.");
			}
			else
			{
				outputText(" The intensity overwhelms your ability to act, arousing and stunning you.");
				game.dynStats("lus",player.lib / 15 + player.cor / 15 + 15);
				player.createStatusEffect(StatusEffects.Stunned,0,0,0,0);
			}
		}
		
		private function purpleHaze():void
		{
			outputText("<i>“Try this on for size!”</i> The drider gestures in your direction, gathering his will into a palpable force. It presses on your mind like a coiled snake, crushing down on you from all sides.");
			if (player.findPerk(PerkLib.Resolute) >= 0 || rand(3) >= 0)
			{
				if (player.findPerk(PerkLib.Resolute) >= 0)
				{
					this._seenResolute = true;
				}
				outputText(" You flex your considerable will and feel the concentrated mental filth slough off. Whatever his attack was, it failed!");
			}
			else
			{
				outputText(" You concentrate to try and throw it off, but he overwhelms your mental defenses. Clouds of swirling pink filled with unsubtle erotic silhouettes fill your vision, effectively blinding you!");
				game.dynStats("lus",25);
				player.createStatusEffect(StatusEffects.PurpleHaze,2 + rand(2),0,0,0);
				player.createStatusEffect(StatusEffects.Blind,player.statusEffectv1(StatusEffects.PurpleHaze),0,0,0);
			}
		}
		
		private function goblinHandjob():void
		{
			outputText("Somehow, the goblin manages to get both her mitts on the drider’s ever erect member. A gleeful expression occupies her face as she begins pumping, worshipfully tugging on her master’s rod again and again, her mouth open excitedly as if he could bust a nut at any moment.");
			outputText("\n\nUnfortunately for her, the demonic arachnid’s motions carry him away from her greedy fingers. He slips out of her grip with a wet pop, and she can do naught but pout and chase after him once more.");
		}
		
		private function goblinTongueGrapple():void
		{
			outputText("The determined goblin love-slave opens wide, launching a tongue that must be at least three feet long toward her master’s member with pinpoint accuracy. It makes contact with a wet ‘snap’ and wraps round the oozing, demonic length before either you or the drider can react. His motions slow from the attention, and he nearly stumbles, giving the goblin time to close to the distance, mummifying his member under layers of hot pink pleasure.");
			lust += 5;
			if (lust <= 100)
			{
				outputText("\n\nThe drider skitters back, the motion dropping the goblin to her knees. Her tongue stretches taut a long moment, then slips from his shaft, snapping back into her mouth hard enough to make her recoil. Both parties look disappointed with the outcome, none moreso than the goblin. Fortunately for her, she’ll get another chance - the drider is focusing on you once more.");
			}
			else
			{
				outputText("\n\nThe drider attempts to skitter back, but his legs are shaking to hard for proper movement. He looks longingly at his love slave, forgetting you for the moment.");
			}
		}
		
		private function bootyTwerking():void
		{
			outputText("The goblin gives up on her futile chase for the moment. Instead of trying to lay her hands on her treasured scepter, she spins around, raising her cushy-looking ass into the air. She twists and gyrates, making her voluminous asscheeks bounce independantly. Sometimes they audibly clap together. A few assembled demonic slaves applaud her performance, and the drider can’t help but spare her a few hungry glances.");
			lust += 5;
		}
		
		private function webNipplechain():void
		{
			outputText("Every time she makes a grab for the demonic drider’s tool, he skitters aside, the ebb and flow of your fight keeping her from her objective. In a huff, she grabs hold of a hanging strand of web and affixes the sticky end to one of her nipples. Then, she gives the source spinnaret a squeeze, but not before pressing her other jiggling tit against it.");
			if (this._goblinWebChain == false)
			{
				outputText("\n\nShe comes away with an organic nipple chain, one that has her moaning with need as she shakes her diminutive body for her master’s pleasure. He tries his best to ignore her, even a demon can’t ignore a pair of white-plastered tits shaking a few feet away.");
				this._goblinWebChain = true;
			}
			else
			{
				outputText("\n\nThe goblin slave-girl shimmies and shakes once more, her arms pressing in on her tits from both sides to make the jiggling, web-painted mounds dance. Her eyes smoulder with desire, and her wanton smile promises nothing but hours of unending lewdness to her master. He does a double-take at the sight of it.");
			}
			lust += 5;
		}
		
		public function get goblinOiled():Boolean
		{
			return this._goblinOiled;
		}
		
		private function babyOilMeUp():void
		{
			outputText("Darting into the crowd, the goblin comes back with a bottle of unusual shape and design. She pops the cork and upends it across her petite but all-too-stacked form, smearing it across her more-than-ample tits with one hand, making them shine in the flickering candlelight. Her eyes are bright and mischievous while she spreads it over the rest of her form, leaving the whole of her body slick and ready for love.");
			outputText("\n\nShe dances and spins to the side, cooing, <i>“Don’t you want me anymore, baby? Look how ready I am”</i> Her nipples are taut and stiff, and the junction between her thighs absolutely drenched. Neither you nor your foe can keep from sparing lusty glances her way.");
			lust += 7;
			game.dynStats("lus", 7);
		}
		
		public function freeGoblin():void
		{
			clearOutput();
			this._goblinFree = true;
			outputText("You lunge in low, hooking your hands beneath the writhing greenskin’s armpits and pulling. Webs snap like gauze between her weight and the mighty tug you strain them with. Her eyes bulge open in horror. She screams as you pull her free, revealing an inhumanly soaked rod and one seriously puffy set of labia. The poor thing won’t be able to walk without squishing them against each other.");
			outputText("\n\nYou’re forced to drop her as the enraged drider prepares his counterattack. She lands on her feet, surprisingly enough.");
			outputText("\n\n<i>“Oh, forgive me master! I’ll still get you off - I promise!”</i> The green slut wiggles away from you, trying to get at her master’s loins.");
			outputText("\n\nWell... maybe she didn’t want free after all. At least she’ll make for a good distraction.");
			doAI();
		}
	}
}
