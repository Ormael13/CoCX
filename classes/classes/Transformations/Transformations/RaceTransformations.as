package classes.Transformations.Transformations {
import classes.Races;
import classes.Transformations.*;
import classes.Items.MutationsHelper;
import classes.Races.*;
import classes.Scenes.Metamorph;

/**
 * Base class for transformation events.
 */
public class RaceTransformations extends MutationsHelper {

	public const FullAlicorn: Transformation = new SimpleTransformation("Alicorn Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now an Alicorn </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(AlicornRace.RaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.ALICORN);

			}
	);

	public const FullAlraune: Transformation = new SimpleTransformation("Alraune Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now an Alraune </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(AlrauneRace.RaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.ALRAUNE);
			}
	);

	public const FullAnt: Transformation = new SimpleTransformation("Ant Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now an Ant </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(AntRace.RaceBody);// AntRace.AntRaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.ANT);
			}
	);

    public const FullAtlahNacha: Transformation = new SimpleTransformation("Atlach Nacha Full Transform",
            // apply effect
            function (doOutput: Boolean): void {
                var desc: String = "[pg]";
                desc += "<b>You are now an Atlach Nacha </b>";
                if (doOutput) outputText(desc);
                Metamorph.runMetamorph(AtlachNachaRace.RaceBody);
            },
            // is present
            function (): Boolean {
                return player.isRace(Races.ATLACH_NACHA);
            }
    );

	public const FullCouatl: Transformation = new SimpleTransformation("Couatl Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now a Couatl </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(CouatlRace.RaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.COUATL);
			}
	);

	public const FullElf: Transformation = new SimpleTransformation("Elf Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now a Elf </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(ElfRace.RaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.ELF);
			}
	);

	public const FullGoblin: Transformation = new SimpleTransformation("Goblin Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now a Goblin </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(GoblinRace.RaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.GOBLIN);
			}
	);

	public const FullGorgon: Transformation = new SimpleTransformation("Gorgon Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now a Gorgon </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(GorgonRace.RaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.GORGON);
			}
	);

	public const FullHuman: Transformation = new SimpleTransformation("Human Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now Human </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(HumanRace.RaceBody);// HumanRace.HumanRaceBody);
			},
			// is present
			function (): Boolean {
				return false;
			}
	);

	public const FullHydra: Transformation = new SimpleTransformation("Hydra Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now Hydra </b>";
				if (doOutput) outputText(desc);

				Metamorph.runMetamorph(HydraRace.RaceBody);// HumanRace.HumanRaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.HYDRA);
			}
	);

    public const FullJiangshi: Transformation = new SimpleTransformation("Jiangshi Full Transform",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "[pg]";
			desc += "<b>You are now Jiangshi </b>";
			if (doOutput) outputText(desc);
			Metamorph.runMetamorph(JiangshiRace.RaceBody);
		},
		// is present
		function (): Boolean {
			return player.isRace(Races.JIANGSHI);
		}
    );

    public const FullKitsune: Transformation = new SimpleTransformation("Kitsune Full Transform",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "[pg]";
			desc += "<b>You are now a 9 Tailed Kitsune </b>";
			if (doOutput) outputText(desc);
			Metamorph.runMetamorph(KitsuneRace.RaceBody);
		},
		// is present
		function (): Boolean {
			return player.isRace(Races.KITSUNE);
		}
    );

	public const FullNaga: Transformation = new SimpleTransformation("Naga Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now a Naga </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(NagaRace.RaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.NAGA);
			}
	);

	public const FullRaccoon: Transformation = new SimpleTransformation("Raccoon Full Transform",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "[pg]";
				desc += "<b>You are now Raccoon </b>";

				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(RaccoonRace.RaceBody);// RaccoonRace.RaccoonRaceBody);
			},
			// is present
			function ():Boolean { return player.isRace(Races.RACCOON);}
	);

	public const FullRaiju: Transformation = new SimpleTransformation("Raiju Full Transform",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "[pg]";
				desc += "<b>You are now a Raiju </b>";

				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(RaijuRace.RaceBody);
			},
			// is present
			function ():Boolean { return player.isRace(Races.RAIJU); }
	);

	public const FullVouivre: Transformation = new SimpleTransformation("Vouivre Full Transform",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "[pg]";
				desc += "<b>You are now a Vouivre </b>";

				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(VouivreRace.RaceBody);
			},
			// is present
			function ():Boolean {return player.isRace(Races.VOUIVRE);}
	);

    public const FullWolf: Transformation = new SimpleTransformation("Wolf Full Transform",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "[pg]";
                desc += "<b>You are now a Wolf </b>";

                if (doOutput) outputText(desc);
                Metamorph.runMetamorph(WolfRace.RaceBody);
            },
            // is present
            function ():Boolean {return player.isRace(Races.WOLF);}
    );

    public const FullWerewolf: Transformation = new SimpleTransformation("Werewolf Full Transform",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "[pg]";
                desc += "<b>You are now a Werewolf </b>";

                if (doOutput) outputText(desc);
                Metamorph.runMetamorph(WerewolfRace.RaceBody);
            },
            // is present
            function ():Boolean {return player.isRace(Races.WEREWOLF);}
    );

    public const FullDragon: Transformation = new SimpleTransformation("Dragon Full Transform",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "[pg]";
                desc += "<b>You are now a Dragon </b>";

                if (doOutput) outputText(desc);
                Metamorph.runMetamorph(DragonRace.RaceBody);
            },
            // is present
            function ():Boolean {return player.isRace(Races.DRAGON);}
    );

    public const FullKitshoo: Transformation = new SimpleTransformation("Kitshoo Full Transform",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "[pg]";
                desc += "<b>You are now a Kitshoo </b>";

                if (doOutput) outputText(desc);
                Metamorph.runMetamorph(KitshooRace.RaceBody);
            },
            // is present
            function ():Boolean {return player.isRace(Races.KITSHOO);}
    );

    public const FullPoltergeist: Transformation = new SimpleTransformation("Poltergeist Full Transform",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "[pg]";
                desc += "<b>You are now a Poltergeist </b>";

                if (doOutput) outputText(desc);
                Metamorph.runMetamorph(PoltergeistRace.RaceBody);
            },
            // is present
            function ():Boolean {return player.isRace(Races.POLTERGEIST);}
    );

    public const FullScylla: Transformation = new SimpleTransformation("Scylla Full Transform",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "[pg]";
                desc += "<b>You are now a Scylla </b>";

                if (doOutput) outputText(desc);
                Metamorph.runMetamorph(ScyllaRace.RaceBody);
            },
            // is present
            function ():Boolean {return player.isRace(Races.SCYLLA);}
    );

    public const FullShark: Transformation = new SimpleTransformation("Shark Full Transform",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "[pg]";
                desc += "<b>You are now a Shark </b>";

                if (doOutput) outputText(desc);
                Metamorph.runMetamorph(SharkRace.RaceBody);
            },
            // is present
            function ():Boolean {return player.isRace(Races.SHARK);}
    );

    public const FullPhoenix: Transformation = new SimpleTransformation("Phoenix Full Transform",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "[pg]";
                desc += "<b>You are now a Phoenix </b>";

                if (doOutput) outputText(desc);
                Metamorph.runMetamorph(PhoenixRace.RaceBody);
            },
            // is present
            function ():Boolean {return player.isRace(Races.PHOENIX);}
    );

}

}
