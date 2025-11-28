///////////////////////////////////////////////////////////////////////
// WDL to adjust wall and region textures
//	<DEBUG.WDL> must be INCLUDEd before!!

STRING adjust_help,
"[F8] - toggle adjust mode
[W] - select & shift front wall
[S] - scale wall/thing texture (x10)
[A] - select & shift attach texture
[B] - change ambient & albedo (x10)
[R] - change region heights (x10)
[V] - change region ambient (x10)
[F] - shift floor texture
[C] - shift ceiling texture";
#[Q] - reload WMP file
#[X] - reload new actions from TEST.WDL";

// [5] / [6]	shift texture horizontally / adjust floor heigt
// [7] / [8]	shift texture vertically / adjust ceiling heigt

// Diese Zeile eventuell auskommentieren!
//FONT  standard_font,<panfont.bbm>,16,20;

STRING no_mode,
"Press [F9] to enter adjust mode";
STRING wall_mode,
"WALL  X (5/6):      OFFS_Y (7/8):";
STRING pos_mode,
"FENCE X (5/6):      POSITN (7/8):";
STRING flo_mode,
"FLOOR X (5/6):      OFFS_Y (7/8):";
STRING ceil_mode,
"CEIL  X (5/6):      OFFS_Y (7/8):";
STRING regio_mode,
"FLOOR_H (5/6):      CEIL_H (7/8):";
STRING attach_mode,
"ATTCH X (5/6):       POS_Y (7/8):";
STRING scale_mode,
"SCALE_X (5/6):      SCAL_Y (7/8):";
STRING thing_mode,
"THING H (5/6):       ANGLE (7/8):";
STRING ambient_mode,
"AMBIENT (5/6):      ALBEDO (7/8):";
STRING regamb_mode,
"AMBIENT (5/6):                   ";
STRING reload_mode,
"Reloading WMP... please wait";
STRING scan_mode,
"Reload actions from TEST.WDL... ok";

TEXT	adjust_text {
	POS_X		8;
	POS_Y		20;
	FONT		standard_font;
	STRING	no_mode;
}

SYNONYM adjust_reg	{ TYPE REGION; }
SYNONYM adjust_wall	{ TYPE WALL; }
SYNONYM adjust_tex	{ TYPE TEXTURE; }

SKILL adjust_mode { VAL -1; }
SKILL adjust_x 	{ VAL 0; }
SKILL adjust_y 	{ VAL 0; }

// synonyms to store previous keyboard actions
SYNONYM aw_old	{ TYPE ACTION; }
SYNONYM af_old	{ TYPE ACTION; }
SYNONYM ac_old	{ TYPE ACTION; }
SYNONYM ar_old	{ TYPE ACTION; }
SYNONYM aa_old	{ TYPE ACTION; }
SYNONYM as_old	{ TYPE ACTION; }
SYNONYM ab_old	{ TYPE ACTION; }
SYNONYM av_old	{ TYPE ACTION; }
SYNONYM aq_old	{ TYPE ACTION; }
SYNONYM ax_old	{ TYPE ACTION; }
SYNONYM a5_old	{ TYPE ACTION; }
SYNONYM a6_old	{ TYPE ACTION; }
SYNONYM a7_old	{ TYPE ACTION; }
SYNONYM a8_old	{ TYPE ACTION; }

PANEL adjust_panel {
	POS_X		0;
	POS_Y		190;
	DIGITS	128,0,4,standard_font,1,adjust_x;
	DIGITS	280,0,4,standard_font,1,adjust_y;
	FLAGS		REFRESH;
}

ACTION set_adjust {
	IF_ABOVE	adjust_mode,-1;	// adjust already active?
		GOTO	disable;
	SET	adjust_panel.POS_Y,SCREEN_HGT;
	ADD	adjust_panel.POS_Y,-12;
	SET	adjust_text.POS_Y,SCREEN_HGT;
	ADD	adjust_text.POS_Y,-100;	#-114;
	SET	adjust_text.STRING,adjust_help;
	SET	MESSAGES.9,adjust_text;
	SET	adjust_mode,99;
	SET	aw_old,IF_W;
	SET	IF_W,set_wmode;
	SET	af_old,IF_F;
	SET	IF_F,set_fmode;
	SET	ac_old,IF_C;
	SET	IF_C,set_cmode;
	SET	ar_old,IF_R;
	SET	IF_R,set_rmode;
	SET	aa_old,IF_A;
	SET	IF_A,set_amode;
	SET	as_old,IF_S;
	SET	IF_S,set_smode;
	SET	ab_old,IF_B;
	SET	IF_B,set_bmode;
	SET	av_old,IF_V;
	SET	IF_V,set_vmode;
	SET	aq_old,IF_Q;
#	SET	IF_Q,reload_level;
	SET	ax_old,IF_X;
#	SET	IF_X,scan_new;
	SET	a5_old,IF_5;
	SET	IF_5,adjust_xminus;
	SET	a6_old,IF_6;
	SET	IF_6,adjust_xplus;
	SET	a7_old,IF_7;
	SET	IF_7,adjust_yminus;
	SET	a8_old,IF_8;
	SET	IF_8,adjust_yplus;
	BEEP;
	END;
disable:
	SET	MESSAGES.9,NULL;
	SET	PANELS.9,NULL;
	SET	adjust_mode,-1;
	SET	IF_W,aw_old;
	SET	IF_F,af_old;
	SET	IF_C,ac_old;
	SET	IF_R,ar_old;
	SET	IF_A,aa_old;
	SET	IF_S,as_old;
	SET	IF_B,ab_old;
	SET	IF_V,av_old;
	SET	IF_Q,aq_old;
	SET	IF_X,ax_old;
	SET	IF_5,a5_old;
	SET	IF_6,a6_old;
	SET	IF_7,a7_old;
	SET	IF_8,a8_old;
	BEEP;
	END;
}

ACTION get_adjx {
	IF_EQUAL	adjust_mode,0;
		SET	adjust_x,adjust_wall.OFFSET_X;
	IF_EQUAL	adjust_mode,1;
		SET	adjust_x,adjust_reg.FLOOR_OFFS_X;
	IF_EQUAL	adjust_mode,2;
		SET	adjust_x,adjust_reg.CEIL_OFFS_X;
	IF_EQUAL	adjust_mode,3;
		RULE	adjust_x = adjust_reg.FLOOR_HGT * 10;
	IF_EQUAL	adjust_mode,4;
		SET	adjust_x,adjust_tex.POS_X;
	IF_EQUAL	adjust_mode,5;
		RULE	adjust_x = adjust_tex.SCALE_X * 10;
	IF_EQUAL	adjust_mode,6;
		SET	adjust_x,adjust_wall.OFFSET_X;
	IF_EQUAL	adjust_mode,7;
		RULE	adjust_x = adjust_tex.AMBIENT * 10;
	IF_EQUAL	adjust_mode,8;
		RULE	adjust_x = adjust_reg.AMBIENT * 10;
}
ACTION get_adjy {
	IF_EQUAL	adjust_mode,0;
		SET	adjust_y,adjust_wall.OFFSET_Y;
	IF_EQUAL	adjust_mode,1;
		SET	adjust_y,adjust_reg.FLOOR_OFFS_Y;
	IF_EQUAL	adjust_mode,2;
		SET	adjust_y,adjust_reg.CEIL_OFFS_Y;
	IF_EQUAL	adjust_mode,3;
		RULE	adjust_y = adjust_reg.CEIL_HGT * 10;
	IF_EQUAL	adjust_mode,4;
		SET	adjust_y,adjust_tex.POS_Y;
	IF_EQUAL	adjust_mode,5;
		RULE	adjust_y = adjust_tex.SCALE_Y * 10;
	IF_EQUAL	adjust_mode,6;
		RULE	adjust_y = adjust_wall.POSITION * 10;
	IF_EQUAL	adjust_mode,7;
		RULE	adjust_y = adjust_tex.ALBEDO * 10;
	IF_EQUAL	adjust_mode,8;
		SET	adjust_y,0;
}

ACTION set_adjx {
	IF_EQUAL	adjust_mode,0;
		SET	adjust_wall.OFFSET_X,adjust_x;
	IF_EQUAL	adjust_mode,1;
		SET	adjust_reg.FLOOR_OFFS_X,adjust_x;
	IF_EQUAL	adjust_mode,2;
		SET	adjust_reg.CEIL_OFFS_X,adjust_x;
	IF_EQUAL	adjust_mode,3;
		RULE	adjust_reg.FLOOR_HGT = adjust_x/10;
	IF_EQUAL	adjust_mode,4;
		SET	adjust_tex.POS_X,adjust_x;
	IF_NEQUAL	adjust_mode,5;
		SKIP	2;
		RULE	adjust_tex.SCALE_X = adjust_x/10;
		SET_ALL	adjust_wall.TEXTURE,adjust_tex;
	IF_EQUAL	adjust_mode,6;
		SET	adjust_wall.OFFSET_X,adjust_x;
	IF_NEQUAL	adjust_mode,7;
		SKIP	2;
		RULE	adjust_tex.AMBIENT = adjust_x/10;
		SET_ALL	adjust_wall.TEXTURE,adjust_tex;
	IF_EQUAL	adjust_mode,8;
		RULE	adjust_reg.AMBIENT = adjust_x/10;
	SET		RENDER_MODE,1;
}
ACTION set_adjy {
	IF_EQUAL	adjust_mode,0;
		SET	adjust_wall.OFFSET_Y,adjust_y;
	IF_EQUAL	adjust_mode,1;
		SET	adjust_reg.FLOOR_OFFS_Y,adjust_y;
	IF_EQUAL	adjust_mode,2;
		SET	adjust_reg.CEIL_OFFS_Y,adjust_y;
	IF_EQUAL	adjust_mode,3;
		RULE	adjust_reg.CEIL_HGT = adjust_y/10;
	IF_EQUAL	adjust_mode,4;
		SET	adjust_tex.POS_Y,adjust_y;
	IF_NEQUAL	adjust_mode,5;
		SKIP	2;
		RULE	adjust_tex.SCALE_Y = adjust_y/10;
		SET_ALL	adjust_wall.TEXTURE,adjust_tex;
	IF_EQUAL	adjust_mode,6;
		RULE	adjust_wall.POSITION = adjust_y/10;
	IF_NEQUAL	adjust_mode,7;
		SKIP	2;
		RULE	adjust_tex.ALBEDO = adjust_y/10;
		SET_ALL	adjust_wall.TEXTURE,adjust_tex;
	SET		RENDER_MODE,1;
}

ACTION adjust_xplus {
	CALL		get_adjx;
	ADD		adjust_x,1;
	CALL		set_adjx;
	WAITT		8;
again:			// some kind of repeat...
	IF_EQUAL	KEY_6,0;
		END;
	CALL		get_adjx;
	ADD		adjust_x,1;
	CALL		set_adjx;
	WAITT		2;
	GOTO		again;
}

ACTION adjust_xminus {
	CALL		get_adjx;
	ADD		adjust_x,-1;
	CALL		set_adjx;
	WAITT		8;
again:
	IF_EQUAL	KEY_5,0;
		END;
	CALL		get_adjx;
	ADD		adjust_x,-1;
	CALL		set_adjx;
	WAITT		2;
	GOTO		again;
}

ACTION adjust_yplus {
	CALL		get_adjy;
	ADD		adjust_y,1;
	CALL		set_adjy;
	WAITT		8;
again:
	IF_EQUAL	KEY_8,0;
		END;
	CALL		get_adjy;
	ADD		adjust_y,1;
	CALL		set_adjy;
	WAITT		2;
	GOTO		again;
}

ACTION adjust_yminus {
	CALL		get_adjy;
	ADD		adjust_y,-1;
	CALL		set_adjy;
	WAITT		8;
again:
	IF_EQUAL	KEY_7,0;
		END;
	CALL		get_adjy;
	ADD		adjust_y,-1;
	CALL		set_adjy;
	WAITT		2;
	GOTO		again;
}

ACTION set_wmode {
	SET	adjust_text.POS_Y,adjust_panel.POS_Y;
	SHOOT;
	IF_EQUAL	HIT_DIST,0;
		END;
	SET	PANELS.9,adjust_panel;
	SET	adjust_wall,HIT;
	IF_EQUAL	adjust_wall.FENCE,1;
		GOTO	set_posmode;
	SET	adjust_mode,0;
	SET	adjust_text.STRING,wall_mode;
	CALL	get_adjx;
	CALL	get_adjy;
	END;
set_posmode:
	SET	adjust_mode,6;
	SET	adjust_text.STRING,pos_mode;
	CALL	get_adjx;
	CALL	get_adjy;
}
ACTION set_fmode {
	SET	adjust_mode,1;
	SET	adjust_text.POS_Y,adjust_panel.POS_Y;
	SET	adjust_text.STRING,flo_mode;
	SET	adjust_reg,HERE;
	SET	PANELS.9,adjust_panel;
	CALL	get_adjx;
	CALL	get_adjy;
}
ACTION set_cmode {
	SET	adjust_mode,2;
	SET	adjust_text.POS_Y,adjust_panel.POS_Y;
	SET	adjust_text.STRING,ceil_mode;
	SET	adjust_reg,HERE;
	SET	PANELS.9,adjust_panel;
	CALL	get_adjx;
	CALL	get_adjy;
}
ACTION set_rmode {
	SET	adjust_mode,3;
	SET	adjust_text.POS_Y,adjust_panel.POS_Y;
	SET	adjust_text.STRING,regio_mode;
	SET	adjust_reg,HERE;
	SET	PANELS.9,adjust_panel;
	CALL	get_adjx;
	CALL	get_adjy;
}
ACTION set_vmode {
	SET	adjust_mode,8;
	SET	adjust_text.POS_Y,adjust_panel.POS_Y;
	SET	adjust_text.STRING,regamb_mode;
	SET	adjust_reg,HERE;
	SET	PANELS.9,adjust_panel;
	CALL	get_adjx;
	CALL	get_adjy;
}
ACTION set_amode {
	SET	adjust_text.POS_Y,adjust_panel.POS_Y;
	IF_EQUAL	adjust_mode,4;
		GOTO	next_tex;
	SHOOT;
	IF_EQUAL	HIT_DIST,0;
		END;
	SET	adjust_mode,4;
	SET	adjust_text.STRING,attach_mode;
	SET	PANELS.9,adjust_panel;
	SET	adjust_tex,HIT.TEXTURE;

next_tex:
	IF_NEQUAL	adjust_tex.ATTACH,NULL;
		GOTO	set_tex;

	SET	adjust_tex,HIT.TEXTURE;
	IF_EQUAL	adjust_tex.ATTACH,NULL;
		END;
set_tex:
	SET	adjust_tex,adjust_tex.ATTACH;
	CALL	get_adjx;
	CALL	get_adjy;
}
ACTION set_smode {
	SET	adjust_text.POS_Y,adjust_panel.POS_Y;
	SHOOT;
	IF_EQUAL	HIT_DIST,0;
		END;
	SET	PANELS.9,adjust_panel;
	SET	adjust_tex,HIT.TEXTURE;
	SET	adjust_wall,HIT;
	SET	adjust_mode,5;
	SET	adjust_text.STRING,scale_mode;
	CALL	get_adjx;
	CALL	get_adjy;
}
ACTION set_bmode {
	SET	adjust_text.POS_Y,adjust_panel.POS_Y;
	SHOOT;
	IF_EQUAL	HIT_DIST,0;
		END;
	SET	PANELS.9,adjust_panel;
	SET	adjust_tex,HIT.TEXTURE;
	SET	adjust_wall,HIT;
	SET	adjust_mode,7;
	SET	adjust_text.STRING,ambient_mode;
	CALL	get_adjx;
	CALL	get_adjy;
}

ACTION reload_level {
	SET	adjust_text.POS_Y,adjust_panel.POS_Y;
	SET	PANELS.9,NULL;
	SET	adjust_text.STRING,reload_mode;
	WAIT	1;
	BEEP;
	MAP;
}

ACTION scan_new {
	SET	adjust_text.POS_Y,adjust_panel.POS_Y;
	SET	PANELS.9,NULL;
	SET	adjust_text.STRING,scan_mode;
	WAIT	1;
	SCAN 	"test.wdl";
	BEEP;
}

#IF_F8 set_adjust;
