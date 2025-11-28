//////////////////////////////Bull/////////////////////////////////////////
/////////Front Run//////////////////
BMAP ftwalk1,         <ftwalk1.pcx>;
BMAP ftwalk2,         <ftwalk2.pcx>;
BMAP ftwalk3,         <ftwalk3.pcx>;
BMAP ftwalk4,         <ftwalk4.pcx>;
BMAP ftwalk5,         <ftwalk5.pcx>;
BMAP ftwalk6,         <ftwalk6.pcx>;
BMAP ftwalk7,         <ftwalk7.pcx>;
BMAP ftwalk8,         <ftwalk8.pcx>;
/////////Quarter Run////////////////
BMAP qwalk1,          <qwalk1.pcx>;
BMAP qwalk2,          <qwalk2.pcx>;
BMAP qwalk3,          <qwalk3.pcx>;
BMAP qwalk4,          <qwalk4.pcx>;
BMAP qwalk5,          <qwalk5.pcx>;
BMAP qwalk6,          <qwalk6.pcx>;
BMAP qwalk7,          <qwalk7.pcx>;
BMAP qwalk8,          <qwalk8.pcx>;
/////////Side Run///////////////////
BMAP sdwalk1,         <sdwalk1.pcx>;     
BMAP sdwalk2,         <sdwalk2.pcx>;     
BMAP sdwalk3,         <sdwalk3.pcx>;     
BMAP sdwalk4,         <sdwalk4.pcx>;     
BMAP sdwalk5,         <sdwalk5.pcx>;     
BMAP sdwalk6,         <sdwalk6.pcx>;     
BMAP sdwalk7,         <sdwalk7.pcx>;     
BMAP sdwalk8,         <sdwalk8.pcx>;     
/////////3 Quarter Run//////////////
BMAP 3qwalk1,         <3qwalk1.pcx>; 
BMAP 3qwalk2,         <3qwalk2.pcx>; 
BMAP 3qwalk3,         <3qwalk3.pcx>; 
BMAP 3qwalk4,         <3qwalk4.pcx>; 
BMAP 3qwalk5,         <3qwalk5.pcx>; 
BMAP 3qwalk6,         <3qwalk6.pcx>; 
BMAP 3qwalk7,         <3qwalk7.pcx>; 
BMAP 3qwalk8,         <3qwalk8.pcx>; 
/////////Back Run///////////////////
BMAP bkwalk1,         <bkwalk1.pcx>;  
BMAP bkwalk2,         <bkwalk2.pcx>;  
BMAP bkwalk3,         <bkwalk3.pcx>;  
BMAP bkwalk4,         <bkwalk4.pcx>;  
BMAP bkwalk5,         <bkwalk5.pcx>;  
BMAP bkwalk6,         <bkwalk6.pcx>;  
BMAP bkwalk7,         <bkwalk7.pcx>;  
BMAP bkwalk8,         <bkwalk8.pcx>;  
/////////Stand Still////////////////
BMAP stand1,          <stand1.pcx>;
BMAP stand2,          <stand2.pcx>;
BMAP stand3,          <stand3.pcx>;
BMAP stand4,          <stand4.pcx>;
BMAP stand5,          <stand5.pcx>;
/////////Shoot Sequence/////////////
BMAP shoot1,          <shoot1.pcx>;
BMAP shoot2,          <shoot2.pcx>;
BMAP shoot3,          <shoot3.pcx>;
BMAP shoot4,          <shoot4.pcx>;
BMAP shoot5,          <shoot5.pcx>;
BMAP shoot6,          <shoot6.pcx>;
////////Die////////////////////////
BMAP killfr1,         <killfr1.pcx>;
BMAP killfr2,         <killfr2.pcx>;
/////////Dead///////////////////////
BMAP killed,          <killed.pcx>;
////////////////////////////////////
BMAP shadow1,         <shadow1.pcx>;
////////////////////////////////////
BMAP blood1,          <bld1.pcx>;
BMAP blood2,          <bld2.pcx>;
BMAP blood3,          <bld3.pcx>;
BMAP blood4,          <bld4.pcx>;
//////////////////////////////////////////////////////////////////////////
TEXTURE blood1_tex {
        SCALE_XY 35,35;
        BMAPS blood1;
}
TEXTURE blood2_tex {
        SCALE_XY 35,35;
        BMAPS blood2;
}
TEXTURE blood3_tex {
        SCALE_XY 35,35;
        BMAPS blood3;
}
TEXTURE blood4_tex {
        SCALE_XY 35,35;
        BMAPS blood4;
}
TEXTURE enemy1_hit_tex {
        SCALE_XY 45,45;
        BMAPS stand1;
      }
TEXTURE  enemy1_stand_tex {
        SCALE_XY 45,45;
        SIDES   8;
        CYCLES  1;
        BMAPS   stand1,stand2,stand3,stand4,stand5,stand4,stand3,stand2;
        MIRROR  0,1,1,1,0,0,0,0;
}
TEXTURE  enemy1_run_tex   {
        SCALE_XY 45,45;
        SIDES   8;
        CYCLES  8;
        BMAPS   ftwalk1,ftwalk2,ftwalk3,ftwalk4,ftwalk5,ftwalk6,ftwalk7,ftwalk8,
                qwalk1,qwalk2,qwalk3,qwalk4,qwalk5,qwalk6,qwalk7,qwalk8,
                sdwalk1,sdwalk2,sdwalk3,sdwalk4,sdwalk5,sdwalk6,sdwalk7,sdwalk8,
                3qwalk1,3qwalk2,3qwalk3,3qwalk4,3qwalk5,3qwalk6,3qwalk7,3qwalk8,
                bkwalk1,bkwalk2,bkwalk3,bkwalk4,bkwalk5,bkwalk6,bkwalk7,bkwalk8,
                3qwalk1,3qwalk2,3qwalk3,3qwalk4,3qwalk5,3qwalk6,3qwalk7,3qwalk8,
                sdwalk1,sdwalk2,sdwalk3,sdwalk4,sdwalk5,sdwalk6,sdwalk7,sdwalk8,
                qwalk1,qwalk2,qwalk3,qwalk4,qwalk5,qwalk6,qwalk7,qwalk8;
        MIRROR  0,1,1,1,0,0,0,0;
        DELAY   2,2,2,2,2,2,2,2;
}
TEXTURE  enemy1_shoot_tex {  
        SCALE_XY 45,45;
        CYCLES  10;
        BMAPS   shoot1,shoot2,shoot3,shoot4,shoot5,shoot6,shoot5,shoot4,shoot3,shoot2;
}
TEXTURE  enemy1_die_tex   { 
        SCALE_XY 45,45;
        CYCLES  2;
        BMAPS   killfr1,killfr2;
        FLAGS   ONESHOT;
}
TEXTURE  enemy1_dead_tex  {
        SCALE_XY 45,45;
        BMAPS   killed;
}
TEXTURE shadow1_tex { BMAPS shadow1; SCALE_XY 25,25; FLAGS DIAPHANOUS,BEHIND,SHADOW; }
WAY   enemy1_way_1;
WAY   enemy1_way_2;
WAY   enemy1_way_3;
WAY   enemy1_way_4;
WAY   enemy1_way_5;
WAY   enemy1_way_6;
ACTOR   enemy1_way1 {
        TARGET  enemy1_way_1;
        TEXTURE enemy1_run_tex;
        SPEED   .8;
        SKILL1  0;
        HEIGHT  0;
        DIST    30;
        IF_HIT  enemy1_hit;
        IF_NEAR enemy1_attack;
        ATTACH  shadow1_tex;
        FLAGS FRAGILE;
}
ACTOR   enemy1_way2 {
        TARGET  enemy1_way_2;
        TEXTURE enemy1_run_tex;
        SPEED   .8;
        SKILL1  0;
        HEIGHT  0;
        DIST    40;
        IF_HIT  enemy1_hit;
        IF_NEAR enemy1_attack;
        ATTACH  shadow1_tex;
        FLAGS FRAGILE;
}
ACTOR   enemy1_way3 {
        TARGET  enemy1_way_3;
        TEXTURE enemy1_run_tex;
        SPEED   .8;
        SKILL1  0;
        HEIGHT  0;
        DIST    40;
        IF_HIT  enemy1_hit;
        IF_NEAR enemy1_attack;
        ATTACH  shadow1_tex;
        FLAGS FRAGILE;
}
ACTOR   enemy1_way4 {
        TARGET  enemy1_way_4;
        TEXTURE enemy1_run_tex;
        SPEED   .8;
        SKILL1  0;
        HEIGHT  0;
        DIST    40;
        IF_HIT  enemy1_hit;
        IF_NEAR enemy1_attack;
        ATTACH  shadow1_tex;
        FLAGS FRAGILE;
}
ACTOR   enemy1_way5 {
        TARGET  enemy1_way_5;
        TEXTURE enemy1_run_tex;
        SPEED   .8;
        SKILL1  0;
        HEIGHT  0;
        DIST    15;
        IF_HIT  enemy1_hit;
        IF_NEAR enemy1_attack;
        ATTACH  shadow1_tex;
        FLAGS FRAGILE;
}
ACTOR   enemy1_way6 {
        TARGET  enemy1_way_6;
        TEXTURE enemy1_run_tex;
        SPEED   .8;
        SKILL1  0;
        HEIGHT  0;
        DIST    40;
        IF_HIT  enemy1_hit;
        IF_NEAR enemy1_attack;
        ATTACH  shadow1_tex;
        FLAGS FRAGILE;
}
ACTOR   enemy1 {
        TEXTURE enemy1_stand_tex;
        SKILL1  0;
        HEIGHT  0;
        EACH_TICK enemy1_wait;
        ATTACH  shadow1_tex;
        FLAGS FRAGILE;
}
ACTOR   enemy1_norm {
        TEXTURE enemy1_stand_tex;
        SKILL1  0;
        HEIGHT  0;
        EACH_TICK enemy1_wait;
        ATTACH  shadow1_tex;
        FLAGS FRAGILE;
}
ACTOR   enemy1_hard {
        TEXTURE enemy1_stand_tex;
        SKILL1  0;
        HEIGHT  0;
        EACH_TICK enemy1_wait;
        ATTACH  shadow1_tex;
        FLAGS FRAGILE;
}
///////////////NETWORK PLAY////////////////////////////////////////////
ACTOR   enemy1_node1 {
        TEXTURE enemy1_stand_tex;
        SKILL1  0;
        HEIGHT  0;
        ATTACH  shadow1_tex;
        FLAGS FRAGILE;
        NODE 0;
}
ACTOR   enemy1_node2 {
        TEXTURE enemy1_stand_tex;
        SKILL1  0;
        HEIGHT  0;
        ATTACH  shadow1_tex;
        FLAGS FRAGILE;
        NODE 1;
}
//////////////////////////////////////////////////////////////////////
ACTION  enemy1_wait {
        SET MY.TEXTURE,enemy1_stand_tex;
        SET MY.TARGET,NULL;
        SET MY.DIST,60;
        SET MY.IF_NEAR,enemy1_attack;
        SET MY.IF_HIT,enemy1_hit;
        SET MY.EACH_TICK,NULL;
        SET MY.EACH_CYCLE,NULL;
}
ACTION  enemy1_hit  {
//        SET enemy1_hit_tex.POS_X,HIT_X;
//        SET enemy1_hit_tex.POS_Y,HIT_Y;
//        SET enemy1_hit_tex.ATTACH,blood1_tex;
//        SET MY.TEXTURE,enemy1_hit_tex;
//        WAIT 1;
//        SET enemy1_hit_tex.ATTACH,blood2_tex;
//        SET enemy1_hit_tex.ATTACH,blood3_tex;
//        SET enemy1_hit_tex.ATTACH,blood4_tex;
        IF_EQUAL gun_type,0;
           ADD MY.SKILL1,1;
        IF_EQUAL gun_type,1;
           ADD MY.SKILL1,2;
        IF_EQUAL gun_type,2;
           ADD MY.SKILL1,3;
        IF_EQUAL gun_type,3;
           ADD MY.SKILL1,4;
        IF_EQUAL gun_type,20;
           ADD MY.SKILL1,20;
        IF_EQUAL MY.SKILL1,6;
           BRANCH enemy1_die;
        IF_ABOVE MY.SKILL1,6;
           BRANCH enemy1_die;
        SET MY.EACH_CYCLE,enemy1_attack;
}
SOUND  hey4,    <hey4.wav>;
ACTION enemy1_attack {
        PLAY_SOUND hey4,.5;
        SET MY.TEXTURE,enemy1_run_tex;
        SET MY.SPEED,.8;
        SET MY.VSPEED,0;
        SET MY.CAREFULLY,1;
        SET MY.TARGET,FOLLOW;
        SET MY.IF_NEAR,NULL;
        SET MY.IF_HIT,enemy1_hit;
        SET MY.EACH_TICK,NULL;
        SET MY.EACH_CYCLE,enemy1_shoot;
}
SOUND blade,      <blade.wav>;
SOUND slash,      <slash.wav>;
ACTION enemy1_shoot   {
        SET MY.TEXTURE,enemy1_shoot_tex;
        SET SHOOT_RANGE,8;
        SHOOT MY;
        IF_ABOVE HIT_DIST,0;
           GOTO hit;
#        PLAY_SOUND slash,1;
        END;
    hit:
        CALL schubs;
        ADD health,-6;
        PLAY_SOUND blade,.5;
}
SOUND   die1,     <die1.wav>;
ACTION enemy1_die     {
        PLAY_SOUND  die1,.5;
        SET MY.TEXTURE,enemy1_die_tex;
        SET MY.PLAY,1;
        SET MY.CAREFULLY,0;
        SET MY.PASSABLE,1;
        SET MY.IF_NEAR,NULL;
        SET MY.IF_FAR,NULL;
        SET MY.IF_HIT,NULL;
        SET MY.TARGET,NULL;
        SET MY.SPEED,0;
        SET MY.EACH_TICK,NULL;
        SET MY.EACH_CYCLE,enemy1_dead;
}
ACTION enemy1_dead    {
        SET MY.TEXTURE,enemy1_dead_tex;
        SET MY.HEIGHT,0;
        SET MY.PASSABLE,1;
        SET MY.EACH_CYCLE,NULL;
        SET MY.EACH_TICK,NULL;
}
////////////////////////////Spiked Sphere///////////////////////////////////
BMAP shadow2, <shadow2.pcx>;
//////////////////////////
BMAP  spk_rot_1, <spkbll1.pcx>;
BMAP  spk_rot_2, <spkbll1.pcx>;
BMAP  spk_rot_3, <spkbll3.pcx>;
/////////Attack////////////////
BMAP  spike_1, <spkbll4.pcx>;
BMAP  spike_2, <spkbll5.pcx>;
BMAP  spike_3, <spkbll6.pcx>;
BMAP  spike_4, <spkbll7.pcx>;
BMAP  spike_5, <spkbll8.pcx>;
BMAP  spike_6, <spkbll9.pcx>;
BMAP  spike_7, <spkbll10.pcx>;
BMAP  spike_8, <spkbll11.pcx>;
BMAP  spike_9, <spkbll12.pcx>;
/////////////Die///////////////
BMAP  spike_die_1, <expvr1.pcx>;
BMAP  spike_die_2, <expvr2.pcx>;
BMAP  spike_die_3, <expvr3.pcx>;
BMAP  spike_die_4, <expvr4.pcx>;
BMAP  spike_die_5, <expvr5.pcx>;
BMAP  spike_die_6, <expvr6.pcx>;
BMAP  spike_die_7, <expvr7.pcx>;
TEXTURE enemy2_normal_tex {
        SCALE_XY 45,45;
        CYCLES  3;
        BMAPS   spk_rot_1,spk_rot_2,spk_rot_3;
}
TEXTURE enemy2_attack_tex {
        
        SCALE_XY 45,45;
        CYCLES  9;
        BMAPS   spike_1,spike_2,spike_3,spike_4,spike_5,spike_6,spike_7,spike_8,spike_9;
        
}
TEXTURE enemy2_die_tex {
        SCALE_XY 45,45;
        CYCLES   7;
        BMAPS    spike_die_1,spike_die_2,spike_die_3,spike_die_4,spike_die_5,spike_die_6,spike_die_7;
        FLAGS    ONESHOT;
}
TEXTURE enemy2_dead_tex {
        BMAPS NULL;
}
TEXTURE shadow2_tex { BMAPS shadow2; SCALE_XY 15,15; FLAGS DIAPHANOUS,BEHIND,SHADOW; }
SOUND  exp1,    <exp1.wav>;
SOUND  ball,    <ball.wav>;
ACTOR   enemy2 {
        TEXTURE enemy2_normal_tex;
        SKILL1  0;
        HEIGHT  0;
        EACH_TICK enemy2_wait;
        ATTACH  shadow2_tex;
        FLAGS FRAGILE;
}
ACTOR   enemy2_norm {
        TEXTURE enemy2_normal_tex;
        SKILL1  0;
        HEIGHT  0;
        EACH_TICK enemy2_wait;
        ATTACH  shadow2_tex;
        FLAGS FRAGILE;
}
ACTOR   enemy2_hard {
        TEXTURE enemy2_normal_tex;
        SKILL1  0;
        HEIGHT  0;
        EACH_TICK enemy2_wait;
        ATTACH  shadow2_tex;
        FLAGS   FRAGILE;
}
ACTION  enemy2_wait {
        SET MY.TEXTURE,enemy2_normal_tex;
        SET MY.TARGET,NULL;
        SET MY.DIST,60;
        SET MY.IF_NEAR,enemy2_attack;
        SET MY.IF_HIT,enemy2_hit;
        SET MY.EACH_TICK,NULL;
        SET MY.EACH_CYCLE,NULL;
}
ACTION  enemy2_hit  {
        IF_EQUAL gun_type,0;
           ADD MY.SKILL1,1;
        IF_EQUAL gun_type,1;
           ADD MY.SKILL1,2;
        IF_EQUAL gun_type,2;
           ADD MY.SKILL1,3;
        IF_EQUAL gun_type,3;
           ADD MY.SKILL1,4;
        IF_EQUAL gun_type,20;
           ADD MY.SKILL1,20;
        IF_EQUAL MY.SKILL1,3;
           BRANCH enemy2_die;
        IF_ABOVE MY.SKILL1,3;
           BRANCH enemy2_die;
        BRANCH enemy2_attack;

}

ACTION enemy2_attack {
        PLAY_SOUND ball,.5;
        SET MY.TEXTURE,enemy2_attack_tex;
        SET MY.SPEED,.8;
        SET MY.VSPEED,.3;
        SET MY.CAREFULLY,1;
        SET MY.TARGET,FOLLOW;
        SET MY.IF_NEAR,NULL;
        SET MY.IF_HIT,enemy2_hit;
        SET MY.EACH_TICK,NULL; 
        SET MY.EACH_CYCLE,enemy2_shoot;
}
ACTION enemy2_shoot   {
        SET MY.TEXTURE,enemy2_attack_tex;
        SET SHOOT_RANGE,8;
        SHOOT MY;
        IF_ABOVE HIT_DIST,0;
           GOTO hit;
        END;
    hit:
        CALL schubs;
        ADD health,-3;
}
ACTION enemy2_die     {
        PLAY_SOUND  exp1,.5;
        SET MY.TEXTURE,enemy2_die_tex;
        SET MY.ATTACH,black_tex;
        SET MY.PLAY,1;
        SET MY.CAREFULLY,0;
        SET MY.PASSABLE,1;
        SET MY.IF_NEAR,NULL;
        SET MY.IF_FAR,NULL;
        SET MY.IF_HIT,NULL;
        SET MY.TARGET,NULL;
        SET MY.SPEED,0;
        SET SHOOT_RANGE,15;
        SET SHOOT_FAC,1;
        SET gun_type,20;
        EXPLODE MY;
        ADD THERE.AMBIENT,.5;
        SET MY.EACH_TICK,NULL;
        SET MY.EACH_CYCLE,enemy2_dead;
        IF_ABOVE RESULT,0;
           RULE health = health -100*RESULT;
        IF_ABOVE RESULT,0;
           CALL schubs;
}
ACTION enemy2_dead    {
        SET MY.TEXTURE,black_tex;
        ADD THERE.AMBIENT,-.5;
        SET MY.HEIGHT,0;
        SET MY.EACH_CYCLE,NULL;
        SET MY.EACH_TICK,NULL;
}
