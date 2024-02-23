// Resident Evil Revelations Autosplitter Version 1.1.0 10/5/2022
// Supports IGT
// Supports all difficulties
// Splits can be obtained from https://www.speedrun.com/rerev/resources
// Pointers by Sniffims and TheDementedSalad
// Script by TheDementedSalad

state("rerev", "preDMR")
{
	float IGT: 0xD707E4, 0x6DC;
	float flatIGT: 0xD70B60, 0x2C;
	byte inMenu: 0xD707E4, 0x139C;
}

state("rerev", "7/Feb/24")
{
	float IGT: 0xD6A7E4, 0x6DC;
	float flatIGT: 0xD6AB60, 0x2C;
	byte inMenu: 0xD6A7E4, 0x139C;
}

init
{
	switch (modules.First().ModuleMemorySize)
	{
		case (14786560):
			version = "7/Feb/24";
			break;
		default:
			version = "preDMR";
			break;
	}
}

startup
{
	vars.totalGameTime = 0;
}

update{
    if (timer.CurrentPhase == TimerPhase.NotRunning)
    {
        vars.totalGameTime = 0;
    }
	
	//print(modules.First().ModuleMemorySize.ToString());
}

start
{
	return current.IGT != old.IGT;
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
			vars.totalGameTime = System.Math.Floor(vars.totalGameTime + old.IGT);
			return TimeSpan.FromSeconds(System.Math.Floor(vars.totalGameTime + current.IGT));
		}
}

reset
{
	return current.flatIGT == 0 && old.flatIGT > 0 ||
	current.inMenu == 0 && old.inMenu == 1;
}
