SOUND pistol_empty, <p2.wav>;
SOUND pistol, <p1.wav>;

OVLY  cannon1_0 <p1.PCX>;
OVLY  cannon1_1 <p2.PCX>;
OVLY  cannon1_2 <p3.PCX>;
OVLY  cannon1_3 <p4.PCX>;

OVERLAY  g_cannon0  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS cannon1_0; }
OVERLAY  g_cannon1  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS cannon1_1; }
OVERLAY  g_cannon2  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS cannon1_2; }
OVERLAY  g_cannon3  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS cannon1_3; }

ACTION  shoot      {
fire_loop:
   IF_EQUAL   ammo_1,0;
      GOTO    fire_empty;
   SET IF_CTRL,NULL;
   SET IF_LEFT,NULL;
   PLAY_SOUND  pistol,.5;
   SET        LAYERS.6,g_cannon1;
   ADD        PLAYER_LIGHT,0.5;
   SET        SHOOT_RANGE,500;
   SET        gun_type,2;
   SHOOT;
   ADD        ammo_1,-1;
   SET        ammo,ammo_1;
   IF_EQUAL   HIT_DIST,0;
      GOTO    fire_weiter;
   SET        hdist,HIT_DIST;
   IF_EQUAL   flash1.INVISIBLE,0;
      GOTO    set_flash2;
   SET        flash1.INVISIBLE,0;
   SET        flash1.EACH_TICK,init_flash;
   GOTO       fire_weiter;
set_flash2:
   IF_EQUAL   flash2.INVISIBLE,0;
      GOTO    set_flash3;
   SET        flash2.INVISIBLE,0;
   SET        flash2.EACH_TICK,init_flash;
   GOTO       fire_weiter;
set_flash3:
   IF_EQUAL   flash3.INVISIBLE,0;
      GOTO    set_flash4;
   SET        flash3.INVISIBLE,0;
   SET        flash3.EACH_TICK,init_flash;
   GOTO       fire_weiter;
set_flash4:
   SET        flash4.INVISIBLE,0;
   SET        flash4.EACH_TICK,init_flash;

fire_weiter:
   WAIT       1;
   SET        LAYERS.6,g_cannon2;
   ADD        PLAYER_LIGHT,-0.5;
   WAIT       1;
   SET        LAYERS.6,g_cannon3;
   WAIT       1;
   SET        LAYERS.6,g_cannon0;
   IF_EQUAL   KEY_CTRL,1;
      GOTO    fire_loop;
   IF_EQUAL   MOUSE_LEFT,1;
      GOTO    fire_loop;
   SET IF_CTRL,shoot;
   SET IF_LEFT,shoot;
      END;
fire_empty:
   PLAY_SOUND pistol_empty,.5;
}
ACTION check_ammo1 {
        SET ammo,ammo_1;
}
ACTION init_fire {
        SET EACH_TICK.6,check_ammo1;
        SET LAYERS.6,g_cannon0;
        SET IF_CTRL,shoot;
        SET IF_LEFT,shoot;
}
IF_3 init_fire; 
//////////////////////////////////////////////////////////////////////////
BMAP pistolammo, <p1ammo.pcx>;
TEXTURE pistolammo_tex {
        SCALE_XY  65,65;
        BMAPS pistolammo;
}
BMAP pistolammo2, <p2ammo.pcx>;
TEXTURE pistolammo2_tex {
        SCALE_XY  65,65;
        BMAPS pistolammo2;
}
STRING ammo1_str, "You got 10 bullets of Pistol Ammo";
STRING ammo2_str, "You got 10 shells of 50 Caliber Ammo";
TEXT ammo1_txt { POS_X 10; POS_Y 10; FONT standard_font; STRING ammo1_str; }
TEXT ammo2_txt { POS_X 10; POS_Y 10; FONT standard_font; STRING ammo2_str; }
ACTOR   pistol_ammo {
        TEXTURE     pistolammo_tex;
        FLAGS       FRAGILE;
        DIST        5;
        IF_NEAR     add_ammo1;
}
ACTION  add_ammo1   {
        PLAY_SOUND  pistol_empty,.5;
        SET         MESSAGES.10,ammo1_txt;
        ADD         PLAYER_LIGHT,.5;
        ADD         ammo_1,10;
        SET         MY.INVISIBLE,1;
        SET         MY.PASSABLE,1;
        WAIT        10;
        SET         MESSAGES.10,NULL;
        ADD         PLAYER_LIGHT,-.5;
}
ACTOR   pistol_ammo_2 {
        TEXTURE     pistolammo2_tex;
        FLAGS       FRAGILE;
        DIST        5;
        IF_NEAR     add_ammo2;
}
ACTION  add_ammo2   {
        PLAY_SOUND  pistol_empty,.5;
        SET         MESSAGES.10,ammo2_txt;
        ADD         PLAYER_LIGHT,.5;
        ADD         ammo_2,10;
        SET         MY.INVISIBLE,1;
        SET         MY.PASSABLE,1;
        WAIT        10;
        SET         MESSAGES.10,NULL;
        ADD         PLAYER_LIGHT,-.5;
}

