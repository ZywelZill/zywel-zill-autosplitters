// Hyper Princess Pitch AutoSplitter by Zywel Zill
// HyperPrincessPitch.asl

state ("pitch gm7") {
	// Level Internal Number
	int level : "pitch gm7.exe", 0x1AF2F8;

	// Scene Number (Menus/Levels)
	int sceneMode : "jbfmod.dll", 0xEA64;

	int gameState : "CoreMessaging.dll", 0x82014;

	// First Split Checker (Only used in "start")
	int firstSplit : "jbfmod.dll", 0x0000E884, 0x4, 0x4, 0x4, 0x4B4;

	// Last Split Checker (Only used after defeating Mecha-Santa)
	int lastSplit : "jbfmod.dll", 0x0000E87C, 0x4, 0x0, 0x0, 0x0, 0x0, 0x4, 0x4B4;

	// Split Checker (Used in every level split except last one)
	int levelSplit : "pitch gm7.exe", 0x001878B0, 0x244, 0x90, 0x0, 0xF4, 0x88, 0x7C;
	// int levelSplit2 : "pitch gm7.exe", 0x001878B0, 0x248, 0x90, 0x0, 0xF4, 0x88, 0x7C;
	// int levelSplit3 : "pitch gm7.exe", 0x001878B0, 0x244, 0x90, 0x0, 0xF8, 0x0, 0x88, 0x7C;
	// int levelSplit4 : "pitch gm7.exe", 0x001878B0, 0x248, 0x90, 0x0, 0xF8, 0x0, 0x88, 0x7C;
}

startup {
	// Practice Mode
	settings.Add("isPractice", false, "Practice Mode. (AutoSplitter On/Off)");
	settings.SetToolTip("isPractice", "Turn on (check) if just practicing. False by default.");
}

start {
	// Starts immediately after pressing button in difficulty selection screen
	if (!settings["isPractice"]) {
		if (current.firstSplit != 102 && old.firstSplit == 102 && current.firstSplit != 0) {
			print("sceneMode: " + current.sceneMode);
			print("level: " + current.level);
			print("firstSplit: " + current.firstSplit);
			print("lastSplit: " + current.lastSplit);
			print("levelSplit: " + current.levelSplit);
			print("gameState: " + current.gameState);
			print("---------------------------------");
			return true;
		}
	}
}

split {
	// Splits happen when boss "starts exploding" or "disappear"
	// Last Split happens when screen goes white
	if (!settings["isPractice"]) {
		if (current.level != 6 && current.levelSplit == 3 && old.levelSplit == 2) {
			return true;
		} else if (current.level == 6 && current.lastSplit != 102 && old.lastSplit == 102) {
			return true;
		}
	}
}
