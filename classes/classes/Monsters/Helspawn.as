package classes.Monsters
{
	import classes.Monster;
	import classes.GlobalFlags.kFLAGS;

	/**
	 * Holli (combat id 69)
	 * @author ...
	 */
	public class Helspawn extends Monster
	{

		public function Helspawn(mainClassPtr:*)
		{
			super(mainClassPtr);
			init1Names("", mainClassPtr.flags[kFLAGS.HELSPAWN_NAME], "hollispawn",
					mainClassPtr.flags[kFLAGS.HELSPAWN_NAME] + " is a young salamander, appearing in her later teens.  Clad in " +
							(mainClassPtr.flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50 ?
									"a slutty scale bikini like her mother's, barely concealing anything" :
									"a short skirt, thigh-high boots, and a sky-blue blouse, in stark contrast to her mother’s sluttier attire") +
							", she stands about six feet in height, with a lengthy, fiery tail swishing menacingly behind her. She's packing a " +
							{
								'bow': "recurve bow, using blunted, soft-tipped arrows",
								'scimitar': "scimitar, just like her mom's, and holds it in the same berzerk stance Helia is wont to use",
								'scimitar and shield': "scimitar and shield, giving her a balanced fighting style"
							}[mainClassPtr.flags[kFLAGS.HELSPAWN_WEAPON]] +
							".  Pacing around you, the well-built young warrior intently studies her mentor's defenses, readying for your next attack.");
			init2Female(VAGINA_WETNESS_NORMAL, VAGINA_LOOSENESS_NORMAL, 85);
			init3BreastRows("E+");
			init4Ass(ANAL_LOOSENESS_VIRGIN,ANAL_WETNESS_DRY,85);
			init5Body(90,HIP_RATING_CURVY+2,BUTT_RATING_LARGE+1);
			init6Skin("helspawn");
			init7Hair("red",13);

			this.temperment = 2;
			//Lusty teases
			this.special1 = 5133;
			this.special2 = 5134;
			this.special3 = 5135;

			this.armorDef = 12;

			this.weaponName = mainClassPtr.flags[kFLAGS.HELSPAWN_WEAPON];
			this.weaponVerb = {'bow': "blunted arrow", 'scimitar': "slash", 'scimitar and shield': "slash"}[this.weaponName];
			this.weaponAttack = 20;
			this.createStatusAffect("keen", 0, 0, 0, 0);

			this.armorValue = 50;
			//Primary stats
			this.str = 50;
			this.tou = 50;
			this.spe = 65;
			this.inte = 40;
			this.lib = 35;
			this.sens = 55;
			this.cor = 20;

			this.lustVuln = .55;

			//Combat Stats
			this.bonusHP = 175;
			this.HP = eMaxHP();

			this.lust = 30;

			//Level Stats
			this.level = 12;
			this.XP = totalXP();
			this.gems = 10 + rand(5);


			this.tailType = TAIL_TYPE_COW;

			this.tailRecharge = 0;

			//Create goblin sex attributes
		}

	}

}