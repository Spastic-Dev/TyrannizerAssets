OVLY  cannon0 <punch1.PCX>;
OVLY  cannon1 <punch2.PCX>;
OVLY  cannon2 <punch3.PCX>;
OVLY  cannon3 <kick1.PCX>;
OVLY  cannon4 <kick2.pcx>;
OVLY  cannon5 <kick3.pcx>;
OVLY  blank_ovly <blank.pcx>;

OVERLAY  _cannon1  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS cannon0; }
OVERLAY  _cannon2  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS cannon1; }
OVERLAY  _cannon3  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS cannon2; }
OVERLAY  _cannon4  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS cannon3; }
OVERLAY  _cannon5  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS cannon4; }
OVERLAY  _cannon6  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS cannon5; }
OVERLAY  blank { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS blank_ovly; }

BMAP     flash_2, <spark2.pcx>;
BMAP     flash_3, <spark3.pcx>;
BMAP     flash_5, <spark5.pcx>;

BMAP     wolke_1, <smoke1.pcx>;
BMAP     wolke_2, <smoke2.pcx>;
BMAP     wolke_3, <smoke3.pcx>;
BMAP     wolke_4, <smoke4.pcx>;
BMAP     wolke_5, <smoke5.pcx>;
BMAP     wolke_6, <smoke6.pcx>;

TEXTURE  flash_tex  {
        CYCLES      3;
        BMAPS       flash_2,flash_3,flash_5;
        FLAGS       ONESHOT;
        AMBIENT     1;
}
TEXTURE wolke_tex  {
        CYCLES      10;
        BMAPS       wolke_1,wolke_2,wolke_3,wolke_4,wolke_5,wolke_6,wolke_5,wolke_4,wolke_3,wolke_2;
        FLAGS       ONESHOT,GHOST;
        AMBIENT     0.5;
}

ACTOR    flash1     {
        TEXTURE     flash_tex;
        FLAGS       GROUND,INVISIBLE,PASSABLE;
}

ACTOR    flash2     {
        TEXTURE     flash_tex;
        FLAGS       GROUND,INVISIBLE,PASSABLE;
}

ACTOR    flash3     {
        TEXTURE     flash_tex;
        FLAGS       GROUND,INVISIBLE,PASSABLE;
}

ACTOR    flash4     {
        TEXTURE     flash_tex;
        FLAGS       GROUND,INVISIBLE,PASSABLE;
}

SKILL hgt { }
SKILL hdist  { }

ACTION init_flash {
   SET     MY.TEXTURE,flash_tex;
   SET     MY.PLAY,1;
   SET     MY.DIST,hdist;
   ADD     MY.DIST,-0.5;
   RULE    hgt = PLAYER_Z + -0.83*hdist*PLAYER_TILT + 0.4*RANDOM - 1.2;
   SET     MY.HEIGHT,hgt;
   DROP    MY;
   SET     MY.SPEED,0.3;
   SET     MY.TARGET,FOLLOW;
   SET     MY.EACH_TICK,NULL;
   SET     MY.EACH_CYCLE,init_wolke;
}
ACTION  init_wolke  {
   SET     MY.TEXTURE,wolke_tex;
   SET     MY.PLAY,1;
   SET     MY.EACH_TICK,wolke_auf;
   SET     MY.EACH_CYCLE,init_wolke;
}
ACTION  wolke_auf  {
   ADD     MY.HEIGHT,0.4;
}
ACTION  flash_weg  {
   SET     MY.INVISIBLE,1;
}

ACTION  hurt      {
fire_loop:
   SET        ammo,0;
   SET        IF_CTRL,NULL;
   SET        IF_LEFT,NULL;
   SET        LAYERS.6,_cannon1;
   SET        SHOOT_RANGE,8;
   SET        gun_type,0;
   SHOOT;
   WAIT       1;
   SET        LAYERS.6,_cannon2;
   WAIT       1;
   SET        LAYERS.6,_cannon3;
   WAIT       1;
   SET        LAYERS.6,_cannon2;
   WAIT       1;
   SET        LAYERS.6,_cannon1;
   SHOOT      MY;
   WAIT       1;
   SET        LAYERS.6,_cannon4;
   WAIT       1;
   SET        LAYERS.6,_cannon5;
   WAIT       1;
   SET        LAYERS.6,_cannon6;
   WAIT       1;
   SET        LAYERS.6,_cannon5;
   WAIT       1;
   SET        LAYERS.6,_cannon4;
   WAIT       1;
   SET        LAYERS.6,blank;
   IF_EQUAL   KEY_CTRL,1;
      GOTO    fire_loop;
   IF_EQUAL   MOUSE_LEFT,1;
      GOTO    fire_loop;
      SET IF_CTRL,hurt;
      SET IF_LEFT,hurt;
      END;
}
ACTION fire {
        SET ammo,0;
        SET LAYERS.6,blank;
        SET IF_CTRL,hurt;
        SET IF_LEFT,hurt;
}
IF_1 fire; 
//////////////////////////////////////////////////////////////////////////
