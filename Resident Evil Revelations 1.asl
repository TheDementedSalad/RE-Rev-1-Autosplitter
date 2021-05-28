// Resident Evil Revelations Autosplitter Version 1.0 06/05/2021
// Supports IGT
// Supports main game and raid mode
// Supports all difficulties
// Splits can be obtained from https://www.speedrun.com/rerev/resources
// Script by TheDementedSalad
// Pointers by TheDementedSalad & xlYoshii

state("rerev")
{
	float IGT: 0xD707E4, 0x6DC;
	float flatIGT: 0xD70B60, 0x2C;
	ushort lvlUtil: 0xd8bbec;
	int raidEXP: 0xD6F398, 0xD0;
}

startup
{
	settings.Add("Full", false, "Full Game");
	settings.SetToolTip("Full", "Tick this box if you're running the full game");
	settings.Add("Raid", false, "Raid Mode (Does not split)");
	settings.SetToolTip("Raid", "Tick this box if you're running the full game, this tracks MS");
	
	vars.totalGameTime = 0;
}

start
{
	if (current.IGT != old.IGT && old.IGT == 0){ 
		return true;
	}
}

split
{
	if (settings["Full"]){
	if (current.IGT == 0 && old.IGT > 0){
		return true;
		}
	}
}

isLoading
{
	return true;
}

gameTime
{
	if (settings["Full"]){
	if(current.IGT > old.IGT){
			return TimeSpan.FromSeconds(Math.Floor(vars.totalGameTime + current.IGT));
		}
		if(current.IGT == 0 && old.IGT > 0){
			vars.totalGameTime = Math.Floor(vars.totalGameTime + old.IGT);
			return TimeSpan.FromSeconds(Math.Floor(vars.totalGameTime + current.IGT));
		}
	}
	
	if (settings["Raid"]){
	if(current.IGT > old.IGT){
			return TimeSpan.FromSeconds(current.IGT);
		}
	}
}

reset
{
	if (current.flatIGT == 0 && old.flatIGT > 0) {
		vars.totalGameTime = 0;
		return true;
	}
	else if (current.lvlUtil == 298) {
		vars.totalGameTime = 0;
		return true;
	}
	else {
		return false;
	}
}