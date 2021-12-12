#include "Mods.HC"

// This program compiles only the kernel and then deletes itself.

U0 Coompile()
{
    if ( Cmp("/Kernel/Kernel", "Kernel", , ':') )
    {
        "Failed compiling kernel.\n";
    }
    else
    {
        "Kernel compiled. Installing.\n";
        Move("/Kernel/Kernel.BIN.Z", "/Kernel.BIN.C");
        if (!FileFind("/Kernel.BIN.C"))
        {
            "No Kernel.BIN.C. Something bad happened.\n";
        }
        else
        {
            "Kernel succesfuly installed\n\n\n";
            "$$LTRED$$$$BK,1$$PLEASE RESTART FOR CHANGES TO TAKE EFFECT!$$FG$$$$BK,0$$\n\n\n";
        }
    }

    Del("::/Home/Compile.DD");
}


U0 Main()
{
  //OnceExe;
  switch (sys_boot_src.u16[0]) {
    case BOOT_SRC_RAM:
    case BOOT_SRC_HARDDRV:
      if (FileFind("::/Home/Compile.DD")) {
        Coompile;
        break;
      }

      "$$PURPLE$$$$TX+CX,\"Tip of the Day\"$$$$FG$$\n";
      TipOfDay;
      Type("::/Doc/Customize.DD");
      break;
  }

  SetTheme("moony");
}

Main;
