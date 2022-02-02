// Assassin Blue AutoSplitter by Zywel Zill
// AssassinBlue.asl
// Boss Rush not implemented yet

state ("AssassinBlue") {
	// Level Internal Number
	int level : "AssassinBlue.exe", 0x1AF2F8;
}

startup {
	// Practice Mode
	settings.Add("isPractice", false, "Practice Mode (AutoSplitter On/Off)");
	settings.SetToolTip("isPractice", "False by default, turn on (check) if just practicing");
}

init {
	//
	vars.levels = new List<int> {
		122, 124, 136, 140, 145, 153, 155, 161, 184, 147, 187, 188, 189
	};
}

start {
	// Entering Level 1
	if (!settings["isPractice"]) {
		if ((current.level == 117 || current.level == 189) && (old.level == 121 || old.level == 125)) {
			return true;
		}
	}
}

split {
	// Testing
	if (!settings["isPractice"]) {
		if (vars.levels.Contains(current.level)
			&& (old.level == 120 || old.level == 125 || old.level == 141)) {
			return true;
		}
	}
}
