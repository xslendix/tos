U0 Main()
{
  //OnceExe;
  switch (sys_boot_src.u16[0]) {
    case BOOT_SRC_RAM:
    case BOOT_SRC_HARDDRV:
      if (FileFind("::/Home/Compile.DD")) {
        "You are now going to compile and install a new kernel.\n";
        "Please proceed with the default options.\n";
        "When asked for mount points, say 'C'\n";
        BootHDIns;
        Del("::/Home/Compile.DD");
        Reboot;
        break;
      }

      "$$PURPLE$$$$TX+CX,\"Tip of the Day\"$$$$FG$$\n";
      TipOfDay;
      Type("::/Doc/Customize.DD");
      break;
  }
}

Main;
