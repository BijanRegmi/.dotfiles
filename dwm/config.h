/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */

static const unsigned int gappih    = 3;       	/* horiz inner gap between windows */
static const unsigned int gappiv    = 3;       	/* vert inner gap between windows */
static const unsigned int gappoh    = 2;        /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 2;        /* vert outer gap between windows and screen edge */
static       int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */

static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int usealtbar          = 1;        /* 1 means use non-dwm status bar */
static const char *altbarclass      = "Polybar"; /* Alternate bar class name */
static const char *altbarcmd        = "$HOME/.config/polybar/launch.sh"; /* Alternate bar launch command */
static const char *alttrayname      = "tray";    /* Polybar tray instance name */

static const char *fonts[]          = { "monospace:size=10", "Noto Sans CJK JP:size=10" };
static const char dmenufont[]       = "monospace:size=10";

static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char col_bord[]		= "#badee3";
static const char col_blck[]		= "#000000";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_blck },
	[SchemeSel]  = { col_gray4, col_cyan,  col_bord  },
};

static const unsigned int baralpha = 0xd0;
static const unsigned int borderalpha = OPAQUE;
static const unsigned int alphas[][3]      = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};

/* tagging */
static const char *tags[] = { "一", "二", "三", "四", "五", "六", "七", "八", "九" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",	tile },			/* Default: Master on left, slaves on right */
	{ "TTT",	bstack },		/* Master on top, slaves on bottom */

	{ "[@]",	spiral },		/* Fibonacci spiral */
	{ "[\\]",	dwindle },		/* Decreasing in size right and leftward */

	{ "[D]",	deck },			/* Master on left, slaves in monocle-like mode on right */
	{ "[M]",	monocle },		/* All windows on top of eachother */

	{ "|M|",	centeredmaster },		/* Master in middle, slaves on sides */
	{ ">M>",	centeredfloatingmaster },	/* Same but master floats */
	
	{ "===",      bstackhoriz },
	
	{ "HHH",      grid },
	{ "###",      nrowgrid },
	{ "---",      horizgrid },
	{ ":::",      gaplessgrid },

	{ "><>",	NULL },			/* no layout function means floating behavior */
	{ NULL,		NULL },

};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { NULL };
static const char *termcmd[]  = { "st", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	
	
	/* TOP ROW */
	{ MODKEY|ShiftMask,             XK_q,      	quit,           {0} },

	{ MODKEY,             			XK_w,      	killclient,     {0} },
	{ MODKEY|ShiftMask,				XK_w,		spawn,			SHCMD("~/.dotfiles/scripts/toggle_bg.sh") },

	{ MODKEY,						XK_e,		spawn,			SHCMD("rofi -show emoji -modi emoji -font 'JetBrains Mono 10'") },

	{ MODKEY,						XK_r,		spawn,			SHCMD("st ranger") },
	{ MODKEY|ShiftMask,             XK_r,      	togglesticky,   {0} },

	{ MODKEY,						XK_t,		setlayout,		{.v = &layouts[0]} }, /* tile */
	{ MODKEY|ShiftMask,				XK_t,		setlayout,		{.v = &layouts[1]} }, /* bstack */
	{ MODKEY,						XK_y,		setlayout,		{.v = &layouts[2]} }, /* spiral */
	{ MODKEY|ShiftMask,				XK_y,		setlayout,		{.v = &layouts[3]} }, /* dwindle */
	{ MODKEY,						XK_u,		setlayout,		{.v = &layouts[4]} }, /* deck */
	{ MODKEY|ShiftMask,				XK_u,		setlayout,		{.v = &layouts[5]} }, /* monocle */
	{ MODKEY,						XK_i,		setlayout,		{.v = &layouts[6]} }, /* centeredmaster */
	{ MODKEY|ShiftMask,				XK_i,		setlayout,		{.v = &layouts[7]} }, /* centeredfloatingmaster */
	{ MODKEY,						XK_o,		setlayout,		{.v = &layouts[8]} }, /* bstackhoriz */
	{ MODKEY|ShiftMask,				XK_o,		setlayout,		{.v = &layouts[9]} }, /* grid */
	{ MODKEY,						XK_p,		setlayout, 		{.v = &layouts[10]}}, /* nrowgrid */
	{ MODKEY|ShiftMask,				XK_p,		setlayout,		{.v = &layouts[11]}}, /* horizgrid */
	
	/* HOME ROW */
	{ MODKEY,		                XK_a,      	togglegaps,     {0} },
	{ MODKEY|ShiftMask,    			XK_a,      	defaultgaps,    {0} },

	{ MODKEY,						XK_s,		spawn,			SHCMD("spotify") },
	{ MODKEY|ShiftMask,             XK_s,      	spawn,   		SHCMD("st speedtest") },

	{ MODKEY,                       XK_d,      	spawn,          SHCMD("rofi -modi drun -show drun") },
	{ MODKEY|ShiftMask,             XK_d,      	spawn,          SHCMD("rofi -show run") },
	
	{ MODKEY,						XK_f,		setlayout,		{.v = &layouts[13]}}, /* no layout */
	{ MODKEY|ShiftMask,				XK_f,		togglefullscr,	{0} },

	{ MODKEY,                       XK_h,      	setmfact,       {.f = -0.05} },

	{ MODKEY,                       XK_j,      	focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      	focusstack,     {.i = -1 } },

	{ MODKEY,                       XK_l,      	setmfact,       {.f = +0.05} },

	
	/* BOTTOM ROW */
	{ MODKEY,              			XK_z,      	incrgaps,       {.i = +1 } },
	{ MODKEY,  					    XK_x,      	incrgaps,       {.i = -1 } },

	{MODKEY,						XK_v,		spawn,			SHCMD("code")},
	{MODKEY|ShiftMask,				XK_v,		spawn,			SHCMD("code ~/.dotfiles")},

	{ MODKEY,						XK_b,		spawn,			SHCMD("brave")},
	{ MODKEY|ShiftMask,             XK_b,      	togglebar,      {0} },
	
	/* SPECIAL KEYS*/
	{ MODKEY,             			XK_Return, 	spawn,          {.v = termcmd } },

	{ MODKEY,                       XK_0,      	view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      	tag,            {.ui = ~0 } },

	{ MODKEY,                       XK_comma,  	focusmon,       {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_comma,  	tagmon,         {.i = -1 } },

	{ MODKEY,                       XK_period, 	focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_period, 	tagmon,         {.i = +1 } },

	{ MODKEY,                       XK_space,  	zoom,           {0} },

	{ MODKEY,						XK_Escape,	spawn,			SHCMD("/home/immo/.config/rofi/scripts/powermenu.sh")},
	
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

static const char *ipcsockpath = "/tmp/dwm.sock";
static IPCCommand ipccommands[] = {
  IPCCOMMAND(  view,                1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  toggleview,          1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  tag,                 1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  toggletag,           1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  tagmon,              1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  focusmon,            1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  focusstack,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  zoom,                1,      {ARG_TYPE_NONE}   ),
  IPCCOMMAND(  incnmaster,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  killclient,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  togglefloating,      1,      {ARG_TYPE_NONE}   ),
  IPCCOMMAND(  setmfact,            1,      {ARG_TYPE_FLOAT}  ),
  IPCCOMMAND(  setlayoutsafe,       1,      {ARG_TYPE_PTR}    ),
  IPCCOMMAND(  quit,                1,      {ARG_TYPE_NONE}   )
};
