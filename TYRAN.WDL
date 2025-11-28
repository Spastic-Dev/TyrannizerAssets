/////////////////////////
// 11-29-96 * 12-20-97 //
// Viper Byte          //
// Tyrannizer          //
/////////////////////////
VIDEO           S640x480;
MAPFILE         <lev4.WMP>;
BIND            <tyran.WDL>;
NEXUS           23;
PATH            "C:\\tyran\\enemy";
PATH            "C:\\tyran\\pcx";
PATH            "C:\\tyran\\mid";
PATH            "C:\\tyran\\pal";
PATH            "C:\\tyran\\wav";
INCLUDE         <move.WDL>;
///////////////////////////////////
SKILL key  { VAL 0; }
SKILL ammo { VAL 0; MIN 0; MAX 9999; }
SKILL health { VAL 100; MIN 0; MAX 200; }
SKILL ammo_1  { MIN 0; DEFAULT 25; MAX 200; }
SKILL ammo_2  { MIN 0; DEFAULT 25; MAX 100; }
SKILL gun_type { MIN 0; VAL 0; MAX 20; }
//////////////////////////////////////
BMAP black, <black.pcx>;
TEXTURE black_tex { BMAPS black; }
INCLUDE         <menu.wdl>;
INCLUDE         <debug.wdl>;
INCLUDE         <adjust.wdl>;
INCLUDE         <gun.wdl>;
INCLUDE         <gun1.wdl>;
INCLUDE         <gun2.wdl>;
INCLUDE         <gun3.wdl>;
INCLUDE         <enemy.wdl>;

SOUND  mushroom,     <mushroom.wav>;
STRING mushroom_string, "You got the mushroom health";
TEXT mushroom_txt { POS_X 10; POS_Y 10; FONT standard_font; STRING mushroom_string; }
BMAP mush,  <life.pcx>;
TEXTURE mush_tex { SCALE_XY 65,65; BMAPS mush; }
ACTION take_mushroom {
        PLAY_SOUND mushroom,0.5;
        SET          MESSAGES.10,mushroom_txt;
        SET          MY.INVISIBLE,1;
        SET          MY.PASSABLE,1;
        ADD          health,10;
        WAIT         10;
        SET          MESSAGES.10,NULL;
}
ACTOR  mushroom_10 { TEXTURE mush_tex; DIST 5; IF_NEAR take_mushroom; }
ACTION die        {
       SET        my_size,7;
       WAIT       1;
       SET        my_size,6;
       WAIT       1;
       SET        my_size,5;
       WAIT       1;
       SET        my_size,4;
       WAIT       1;
       SET        my_size,3;
       WAIT       1;
       SET        my_size,2;
       WAIT       1;
       SET        my_size,1;
       WAIT       1;
       SET        my_size,0;
       WAIT       1;
       SET        LAYERS.6,NULL;
       SET        MOVE_MODE,0;
       FADE_PAL  red_pal,0.2;
}
ACTION check_dead {
        IF_BELOW  health,1;
           BRANCH die;
}
/////////////////////////////////////

LIGHT_ANGLE     3.14;

PALETTE vrpal            {
        PALFILE          <vrpal.bbm>;
        RANGE 16,16; RANGE 32,16; RANGE 48,16; RANGE 64,16;
        RANGE 80,16; RANGE 96,16; RANGE 112,16; RANGE 128,8;
        RANGE 136,8; RANGE 144,8; RANGE 152,8;  RANGE 160,16;
        RANGE 176,16; RANGE 192,16; RANGE 208,16; RANGE 226,16;
        RANGE 240,16;
        FLAGS BLUR;
}
#OVLY  logo,    <logo.pcx>;
OVLY  title,   <titl640.pcx>;
#OVERLAY logoscreen  { POS_X 0; POS_Y 0; OVLYS logo;  }
OVERLAY titlescreen { POS_X 0; POS_Y 0; OVLYS title; }

ACTION end {
        SET  LAYERS.16,NULL;
        END;
}
PANEL  health_pan        {
       POS_X             0;
       POS_Y             0;
       FLAGS             REFRESH;
       DIGITS            5,440,4,num_font,1,health;
       DIGITS            60,440,4,num_font,1,ammo;
}
ACTION set_title_screen   {
        SET              LAYERS.16,titlescreen;
        WAIT             1;
        SET              IF_ANYKEY,end;
        WAIT             25;
        SET              LAYERS.16,NULL;
}
ACTION pyramid_start     {
       CALL              set_title_screen;
       SET               EACH_TICK.1,check_dead;
       SET               PANELS.1,health_pan;
       CALL              init_fire;
       SET               MOTION_BLUR,0;
       CALL              set_walking;
}
IF_START                 pyramid_start;
///////////////////////////////////////////////////////////////////////////
BMAP rock,               <w14.pcx>;
BMAP skeldead,           <skldead.pcx>;
BMAP lava0,              <lava0.pcx>;
BMAP lava1,              <lava1.pcx>;
BMAP lava2,              <lava2.pcx>;
BMAP lava3,              <lava3.pcx>;
BMAP lava4,              <lava4.pcx>;
BMAP lava5,              <lava5.pcx>;
BMAP lava6,              <lava6.pcx>;
BMAP lava7,              <lava7.pcx>;
BMAP lava8,              <lava8.pcx>;
BMAP lava9,              <lava9.pcx>;
BMAP hotcoals,           <tile18.pcx>;
BMAP wood_flr2,          <woodfl2.pcx>;
BMAP wood_flr,           <woodfl.pcx>,0,0,128,128;
BMAP sand_floor,         <dirtfl1.pcx>;
BMAP water1,             <wtr1.pcx>,0,0,128,128;
BMAP water2,             <wtr2.pcx>,0,0,128,128;
BMAP water3,             <wtr3.pcx>,0,0,128,128;
BMAP water4,             <wtr4.pcx>,0,0,128,128;
////////////////////////////////////////////////////////////////////////////
SOUND   step6,           <step6.wav>;
SOUND step2,             <step1.wav>;
#SOUND 2_door1,           <sldoor.wav>;
SOUND keygrab,           <keygrab.wav>;
SOUND newdoor1,          <newdoor1.wav>;
SOUND vateer,            <vateer.wav>;
SOUND topwat,            <topwat.wav>;

////////////////////////////////////////////////////////////////////////////
TEXTURE rock_tex          {
        SCALE_XY          35,35;
        BMAPS             rock;
        SOUND             step6;
}
TEXTURE skeldead_tex      {
        SCALE_XY          35,35;
        BMAPS             skeldead;
        FLAGS CLIP;
}
TEXTURE lava_tex         {
        CYCLES           10;
        BMAPS            lava0,lava1,lava2,lava3,lava4,lava5,lava6,lava7,lava8,lava9;
        AMBIENT          1;
}
TEXTURE hotcoals_tex     {
        BMAPS            hotcoals;
        SCALE_XY         65,65;
}
TEXTURE woodfloor2_tex   {
        BMAPS            wood_flr2;
        SOUND            step2;
}
TEXTURE woodfloor_tex    {
        BMAPS            wood_flr;
        SOUND            step2;
}
TEXTURE sand_tex         {
        BMAPS            sand_floor;
        SOUND            step6;
        SVOL             0.5;
}
SOUND   crunchstep, <step6.wav>;
SOUND   unwater,      <unwater.wav>;
TEXTURE water_tex        {
        CYCLES           6;
        BMAPS            water1,water2,water3,water4,water3,water2;
        SOUND   unwater;
        FLAGS SLOOP;
        SVOL             0.5;
}
TEXTURE water2_tex        {
        CYCLES           6;
        BMAPS            water1,water2,water3,water4,water3,water2;
        SOUND            topwat;
        
        SVOL             0.5;
}

/////////////////////////////////
REGION  border            {
        FLOOR_TEX         sand_tex;
        CEIL_TEX          sand_tex;
        FLOOR_HGT         0;
        CEIL_HGT          0;
        CLIP_DIST         0;
}

BMAP  sand0,  <san000.pcx>;
BMAP  sand1,  <san001.pcx>;
BMAP  sand2,  <san002.pcx>;
BMAP  sand3,  <san003.pcx>;
BMAP  sand4,  <san004.pcx>;
BMAP  sand5,  <san005.pcx>;

TEXTURE 3_sand {
CYCLES  10;
BMAPS   sand0,sand1,sand2,sand3,sand4,sand5,sand4,sand3,sand2,sand1;
DELAY 3,3,3,3,3,3,3,3,3,3;
SCALE_XY 65,65;
}
THING  deadskel {
        TEXTURE  skeldead_tex;
        HEIGHT  -10;
        FLAGS GROUND;
}
INCLUDE <lev4.WDL>;
INCLUDE <lev2.wdl>;
