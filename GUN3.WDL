OVLY  swd0 <swd1.PCX>;
OVLY  swd1 <swd2.PCX>;
OVLY  swd2 <swd3.PCX>;
OVLY  swd3 <swd4.PCX>;
OVLY  swd4 <swd5.pcx>;
OVLY  swd5 <swd6.pcx>;

OVERLAY  sword1  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS swd0; }
OVERLAY  sword2  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS swd1; }
OVERLAY  sword3  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS swd2; }
OVERLAY  sword4  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS swd3; }
OVERLAY  sword5  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS swd4; }
OVERLAY  sword6  { POS_X 0; POS_Y 0; FLAGS ABSPOS; OVLYS swd5; }

ACTION  hurt_2     {
fire_loop:
   SET        ammo,0;
   SET        IF_CTRL,NULL;
   SET        IF_LEFT,NULL;
   SET        LAYERS.6,sword1;
   SET        SHOOT_RANGE,10;
   SET        gun_type,1;
   SHOOT;
   WAIT       1;
   SET        LAYERS.6,sword2;
   WAIT       1;
   SET        LAYERS.6,sword3;
   WAIT       1;
   SET        LAYERS.6,sword4;
   WAIT       1;
   SET        LAYERS.6,sword5;
   WAIT       1;
   SET        LAYERS.6,sword6;
   IF_EQUAL   KEY_CTRL,1;
      GOTO    fire_loop;
   IF_EQUAL   MOUSE_LEFT,1;
      GOTO    fire_loop;
   SET IF_CTRL,hurt_2;
   SET IF_LEFT,hurt_2;
   END;
}
ACTION fire_2 {
        SET ammo,0;
        SET LAYERS.6,sword6;
        SET IF_CTRL,hurt_2;
        SET IF_LEFT,hurt_2;
}
IF_2 fire_2; 
//////////////////////////////////////////////////////////////////////////
