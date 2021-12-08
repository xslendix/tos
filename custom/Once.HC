#include "Mods.HC"

// I included this file as an example

U0 Main()
{
  //OnceExe;
  switch (sys_boot_src.u16[0]) {
    case BOOT_SRC_RAM:
    case BOOT_SRC_HARDDRV:
      "$$PURPLE$$$$TX+CX,\"Tip of the Day\"$$$$FG$$\n";
      TipOfDay;
      Type("::/Doc/Customize.DD");
      /*if (FileFind("::/Misc/Tour")) {
	"\nTake Tour";
	if (YorN) {
	  DocBottom;
	  Cd("::/Misc/Tour");
	  InFile("Tour");
	}
      }*/
      break;
  }

  SetTheme("dark");
}

Main;
