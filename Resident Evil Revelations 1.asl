// Resident Evil Revelations Autosplitter Version 1.0.6 11/11/2021
// Supports IGT
// Supports all difficulties
// Splits can be obtained from https://www.speedrun.com/rerev/resources
// Pointers by Sniffims and TheDementedSalad
// Script by TheDementedSalad

state("rerev")
{
	float IGT: 0xD707E4, 0x6DC;
	float flatIGT: 0xD70B60, 0x2C;
	byte inMenu: 0xD707E4, 0x139C;
}

startup
{
	vars.totalGameTime = 0;
}

start
{
	return current.IGT != old.IGT && old.IGT == 0;
}

split
{
	return current.IGT == 0 && old.IGT > 0;
}

isLoading
{
	return true;
}

gameTime
{
	if(current.IGT > old.IGT){
			return TimeSpan.FromSeconds(Math.Floor(vars.totalGameTime + current.IGT));
		}
		if(current.IGT == 0 && old.IGT > 0){
			vars.totalGameTime = Math.Floor(vars.totalGameTime + old.IGT);
			return TimeSpan.FromSeconds(Math.Floor(vars.totalGameTime + current.IGT));
		}
}

reset
{
	if(current.flatIGT == 0 && old.flatIGT > 0 ||
	current.inMenu == 0 && old.inMenu == 1){
		vars.totalGameTime = 0;
		return true;
	}
	else{
		return false;
	}
}
