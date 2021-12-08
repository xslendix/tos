/*
In order to use the $LK,"custom font",A="FONT.DD"$, you need to overwrite the existing
one in $LK,"the kernel",A="::/Kernel/FontStd.HC.Z"$ and then rebuild the kernel using $LK,"BootHDIns",A="MN:BootHDIns"$.

You can also just use the pre-built kernel.

Make sure this file (Mods.HC) is located in your home directory and
that the file is #included in $LK,"Once.HC.Z"$. There, you can also have it
so it sets the color theme by default.

If you temporarely, for some reason, have the old font back, use the
SetOldFont() function provided in this file.

*/

public CBGR48 gr_palette_night[COLORS_NUM]={
0xFFFFFFFFFFFF, 0x44444444AAAA, 0x0000AAAA0000, 0x0000AAAAAAAA,
0xAAAA00000000, 0xAAAA0000AAAA, 0xAAAA55550000, 0xAAAAAAAAAAAA,
0x555555555555, 0x55555555FFFF, 0x5555FFFF5555, 0x5555FFFFFFFF,
0xFFFF55555555, 0xFFFF5555FFFF, 0xFFFFFFFF5555, 0x222222222222
};


public U0 SetTheme(U64 *theme)
{
  if (!StrCmp(theme, "dark")||!StrCmp(theme, "night"))
    GrPaletteSet(gr_palette_night);
  else if (!StrCmp(theme, "gray") ||!StrCmp(theme, "grey"))
    GrPaletteSet(gr_palette_night);
  else {
    GrPaletteSet(gr_palette_std);
  }
}

public U0 SetOldFont()
{
  // TO BE IMPLEMENTED!
}
