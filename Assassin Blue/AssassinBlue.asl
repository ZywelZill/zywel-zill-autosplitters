// Assassin Blue AutoSplitter by Zywel Zill
// AssassinBlue.asl
// Boss Rush not implemented yet

state ("AssassinBlue") {
	// Level Internal Number
	int level : "AssassinBlue.exe", 0x1AF2F8;

	// Life Value
	int life : "AssassinBlue.exe",0x001B06C8, 0x10, 0x2C, 0x68, 0x44, 0x220, 0x4, 0x1A4;
}

startup {
	// Practice Mode
	settings.Add("isPractice", false, "Practice Mode (AutoSplitter On/Off)");
	settings.SetToolTip("isPractice", "Turn on (check) if just practicing. False by default.");

	// Boss Rush Reset
	settings.Add("isBossRushReset", false, "Boss Rush Reset");
	settings.SetToolTip("isBossRushReset", "Timer resets automatically when you die in Boss Rush Mode. False by default.");
}

init {
	// Level Splits
	vars.levels = new List<int> {
		122, 124, 136, 140, 145, 153, 155, 161, 184, 147, 187, 188, 189
	};

	vars.bossRush = false;

	// Boss Rush Splits
	vars.bosses = new List<int> {
		110, 138, 160, 186
	};
}

start {
	// Entering Level 1
	if (!settings["isPractice"]) {
		if ((current.level == 117 || current.level == 189) && (old.level == 121 || old.level == 125)) {
			if (current.level == 189) {
				vars.bossRush = true;
			} else {
				vars.bossRush = false;
			}
			return true;
		}
	}
}

split {
	// Testing
	if (!settings["isPractice"]) {
		if (!vars.bossRush) {
			if (vars.levels.Contains(current.level) && (old.level == 120 || old.level == 125 || old.level == 141)) {
				return true;
			}
		} else {
			if ((vars.bosses.Contains(old.level) || old.level == 120) && (current.level == 189 || current.level == 121)) {
				return true;
			}
		}
	}
}

reset {
	if (settings["isBossRushReset"]) {
		if (vars.bossRush) {
			if (current.life == 0 && old.life != 0) {
				vars.bossRush = false;
				return true;
			}
		}
	}
}