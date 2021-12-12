/*
In order to use the $LK,"custom font",A="FONT.DD"$, you need to overwrite the existing
one in $LK,"the kernel",A="::/Kernel/FontStd.HC.Z"$ and then rebuild the kernel using $LK,"BootHDIns",A="MN:BootHDIns"$.

Make sure this file (Mods.HC) is located in your home directory and
that the file is #included in $LK,"Once.HC.Z"$. There, you can also have it
so it sets the color theme by default.

If you temporarely, for some reason, have the old font back, use the
SetOldFont() function provided in this file.
*/

////////////////////////////////////////////
//                THEMES                  //
////////////////////////////////////////////

public CBGR48 gr_palette_moony[COLORS_NUM]={
0xDDDDDDDDDDDD, 0x41414141ABAB, 0x0000AAAA5252, 0x0000AAAAAAAA,
0x7A7A85850404, 0x8f8f0404b5b5, 0x66660202BDBD, 0x96969696A8A8,
0x4A4A48485454, 0x55555555FFFF, 0x4242CFCF6A6A, 0x36369A9AB5B5,
0xADAD37373737, 0xC1C15555ffff, 0xF0F0CECE5656, 0x222222223333
};

public CBGR48 gr_palette_night[COLORS_NUM]={
0xFFFFFFFFFFFF, 0x44444444AAAA, 0x0000AAAA0000, 0x0000AAAAAAAA,
0xAAAA00000000, 0xAAAA0000AAAA, 0xAAAA55550000, 0xAAAAAAAAAAAA,
0x555555555555, 0x55555555FFFF, 0x5555FFFF5555, 0x5555FFFFFFFF,
0xFFFF55555555, 0xFFFF5555FFFF, 0xFFFFFFFF5555, 0x222222222222
};


U0 SetThemeNight()
{
  GrPaletteSet(gr_palette_night);  
}

U0 SetThemeMoony()
{
  GrPaletteSet(gr_palette_moony);  
}

U0 SetThemeGray()
{
  GrPaletteSet(gr_palette_gray);
}

U0 SetThemeStd()
{
  GrPaletteSet(gr_palette_std);
}

public U0 SetTheme(U64 *theme)
{
  if (!StrCmp(theme, "dark")||!StrCmp(theme, "night")) {
    SetThemeNight;
    fp_set_std_palette = &SetThemeNight;
  } else if (!StrCmp(theme, "moony")) {
    SetThemeMoony;
    fp_set_std_palette = &SetThemeMoony;
  } else if (!StrCmp(theme, "gray") ||!StrCmp(theme, "grey")) {
    SetThemeGray;
    fp_set_std_palette = &SetThemeGray;
  } else {
    SetThemeStd;
    fp_set_std_palette = &SetThemeStd;
  }
}

////////////////////////////////////////////
//                 FONTS                  //
////////////////////////////////////////////

public U0 SetOldFont()
{
  // TO BE IMPLEMENTED!
}

////////////////////////////////////////////
//                ALIASES                 //
////////////////////////////////////////////

public U0 Cls()
{
    DocClear;
}

