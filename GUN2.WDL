SOUND 50cal, <50cal.wav>;
OVLY  2cannon1_0 <wep001.PCX>;
OVLY  2cannon1_1 <wep002.PCX>;
OVLY  2cannon1_2 <wep003.PCX>;

OVERLAY  2g_cannon0  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS 2cannon1_0; }
OVERLAY  2g_cannon1  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS 2cannon1_1; }
OVERLAY  2g_cannon2  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS 2cannon1_2; }

ACTION  2shoot      {
fire_loop:
   IF_EQUAL   ammo_2,0;
      GOTO    no_ammo;
   SET  IF_CTRL,NULL;
   SET  IF_LEFT,NULL;
   PLAY_SOUND 50cal,.5;
   SET        LAYERS.6,2g_cannon2;
   ADD        PLAYER_LIGHT,0.5;
   SET        SHOOT_RANGE,500;
   SET        gun_type,3;
   SHOOT;
   ADD        ammo_2,-1;
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
   SET        LAYERS.6,2g_cannon1;
   ADD        PLAYER_LIGHT,-0.5;
   WAIT       1;
   SET        LAYERS.6,2g_cannon0;
WAIT 2;
   IF_EQUAL   KEY_CTRL,1;
      GOTO    fire_loop;
   IF_EQUAL   MOUSE_LEFT,1;
      GOTO    fire_loop;
SET IF_CTRL,2shoot;
SET IF_LEFT,2shoot;
END;
no_ammo:
   PLAY_SOUND pistol_empty,.5;
}

ACTION check_ammo2 {
        SET ammo,ammo_2;
}
ACTION  2init_fire  {
        SET     EACH_TICK.6,check_ammo2;
        SET     LAYERS.6,2g_cannon0;
        SET     IF_CTRL,2shoot;
        SET     IF_LEFT,2shoot;
}
BMAP 50calpic, <50cal.pcx>;
TEXTURE 50cal_tex { BMAPS 50calpic; SCALE_XY 45,45; }
ACTION take_50cal { SET IF_4,2init_fire; SET MY.PASSABLE,1; SET MY.INVISIBLE,1;BRANCH 2init_fire; }
THING 50cal_gun { TEXTURE 50cal_tex; DIST 5; IF_NEAR take_50cal; }


