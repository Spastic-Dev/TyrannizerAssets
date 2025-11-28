//tmove2.wdl
//BE SURE TO ADD SET_ROCKETING FOR THE GRAV BELT!//added
//it, but nothing happens except jumping doesn't work anymore
//  10/5/97changed line 149 for faster vrot, inc skill booster to 2
//also walk accel, didn't make him any faster, but screwed up jumping
//changed keys r-set rocketing w-set walking
//changed set_walking/strength to .35 the guy blazes now!
//same as set_rocketing, no change, jumping seems to be impaired now
//changed IF_ABOVE player_speed_sqr from 0.4 to 1.4 line 234
# =====================================================================
# CONSTANTS
# =====================================================================
#SKILL PLAYER_LIGHT { VAL 0; }
#SKILL LIGHT_DIST   { VAL 0; }
SKILL Mode_Gehen        { VAL 1; }
SKILL Mode_Schwimmen    { VAL 2; }
SKILL Mode_Tauchen      { VAL 3; }      // oder fliegen, falls fly_mode == ON
SKILL Mode_Fliegen      { VAL 3; }
SKILL Mode_Rocket        {VAL 4; }
SKILL health            {};
# =====================================================================
# GLOBAL SKILLS
# =====================================================================
SKILL   val1                    {}
SKILL   val2                    {}
SKILL imp_fac  {VAL 1;}
SKILL ahead_speed               { }
SKILL tilt_speed                { MIN -1; MAX 1;        }
SKILL   time_dec                        { VAL -1;       MIN -5; }
SKILL moving    { VAL 0; }      // 1 Gehen, 2 Schwimmen, 3 Tauchen
SKILL force     {}              // Kraft
SKILL drift_x   { VAL 0; }      // Drift in X-Richtung
SKILL drift_y   { VAL 0; }      // Drift in Y-Richtung
SKILL gravity   { VAL -0.15; }  // Drift in Z_Richtung (Gravitationskraft)
SKILL strength  { VAL 0.1; }    // Kraft-Koeffizient
SKILL fric              { VAL 0.2; }    // Reibungskoeffizient
SKILL mass              { VAL 0.5; }              // Traege Masse des Players
SKILL fric_air  { VAL 0.02; }   // Luftreibungskoeffizient
SKILL duck_val  { VAL 0; }
SKILL my_size   { VAL 4; }
SKILL WALK_PERIOD       { VAL 5; }
SKILL WALK_TIME { VAL 10; }
SKILL WAVE_PERIOD       { VAL 16;       }
SKILL jump_phase        { VAL 0; }
SKILL PLAYER_ARC        { MIN 0.5; MAX 2; }
SKILL PLAYER_TILT       { MIN -1.35; MAX 1.35;  }
SKILL   wave_str                { VAL 0; }      // Strength-Faktor fuer Wellen-Vorwaertsbewegung
SKILL   float_str       { VAL 0; }              // Strength-Faktor beim Tauchen
SKILL   duck_str                { VAL 0.5; }    //
SKILL depth                     { MAX 3; }              // Eintauchtiefe des Players
SKILL PLAYER_DEPTH { MAX 3; }           // Eintauchtiefe des Players
SKILL underwater        { VAL 0; }      // 1 = Player unter, 0 = Player ueber Wasser
SKILL PLAYER_SIZE       { MIN 0; VAL 4; }
SKILL PLAYER_CLIMB { VAL 2.5; }
	// Player sinkt um 1 Step in Boden ein...
SKILL up_joy            {VAL 0; MIN 0; MAX 1;}
SKILL rocket_up         { VAL 1; MIN 0; }
SKILL   floor_depth   { MIN 0; MAX 4; } // max = playersize!

PALETTE blue_pal { PALFILE <blue.pcx>;}

PALETTE red_pal         {PALFILE <red.pcx>;}
PALETTE brown_pal       {PALFILE <brown.pcx>;}


SKILL GOD              {VAL 0; }
# =====================================================================
# SPECIAL SKILLS
# =====================================================================
# walking
SKILL booster     { VAL 1; } // aktueller Beschleunigungsfaktor, default 1
SKILL walk_accell { VAL 1; }            // Beschleunigungsfaktor

# Tilt behaviour
SKILL tilt_decrease     {VAL 0.8; }     // Verringert autom. anteilig PLAYER_TILT
SKILL max_player_tilt_p { VAL 0.35; }   // MaxWert von PLAYER_TILT zum Einrasten der Blickachse
SKILL max_player_tilt_n { VAL -0.35; }  // MinWert von PLAYER_TILT zum Einrasten der Blickachse
SKILL player_speed_sqr  { VAL 0; }      // aktuelles Quadrat der Player Geschwindigkeit

# Flying
SKILL fly_mode          { VAL 0; }      // 0 = OFF  1 = ON

# Quake
SKILL richter           { VAL 0; }      // Richter-Skala
SKILL random_1  { }
SKILL random_2  { }

# =====================================================================
# INITIALISIERUNG    M O V E
# =====================================================================
ACTION init_move {
	SET     moving, Mode_Gehen;
	CALL    set_moving;
}

# =====================================================================
# BASIS BEWEGUNGSAKTION    M O V E
# =====================================================================
ACTION move_me {
start:
//////////////////////////////// PLAYER_SIZE setzen
	IF_EQUAL        moving, Mode_Gehen;             // Gehen
		RULE    PLAYER_SIZE = my_size + 0.2*WALK;
	IF_EQUAL        moving, Mode_Schwimmen;         // Schwimmen
		RULE    PLAYER_SIZE = 1 + 0.12*WAVE;
	IF_EQUAL        moving, Mode_Tauchen;           // Tauchen
		RULE    PLAYER_SIZE = 1;
	IF_EQUAL        moving, Mode_Rocket;           // Rocket
			RULE    PLAYER_SIZE = my_size + 0.2*WALK;

//////////////////////////////// Underwater
	IF_EQUAL        moving, Mode_Gehen;              // Waten
		RULE    PLAYER_SIZE = PLAYER_SIZE-PLAYER_DEPTH; // SIZE reduzieren
no_waten:
//////////////////////////////// Umschalten Schwimmen/Waten
	IF_NEQUAL       moving, Mode_Schwimmen;
		GOTO    no_swim;
	IF_ABOVE        PLAYER_DEPTH,1.5;               // Wasser tief genug zum Schwimmen?
		GOTO    no_water;
	CALL            set_walking;
	GOTO            start;
no_swim:
	IF_NEQUAL       moving, Mode_Gehen;
		GOTO    no_water;
	IF_BELOW        PLAYER_DEPTH,2.5;               // Wasser zu tief zum Waten?
		GOTO    no_water;
	CALL            set_swimming;
	GOTO            start;
no_water:
//////////////////////////////// Grundbewegung
        IF_EQUAL        MOUSE_RIGHT,0;
		GOTO    no_mouse;

	SET             FORCE_AHEAD,KEY_SENSE;  // Mittlere Maustaste = Vorwaerts
	IF_EQUAL        KEY_SHIFT, 1;
	   RULE FORCE_AHEAD = FORCE_AHEAD * SHIFT_SENSE;

no_mouse:
	SET booster, 1;
	SET             INERTIA,mass;
	RULE            FRICTION = fric + 0.1*depth;    // Zusatzreibung durch Waten
	RULE     force = ( strength + wave_str*WAVE) * booster
	          * (FORCE_AHEAD*PLAYER_COS - 0.5*FORCE_STRAFE*PLAYER_SIN)
		  + drift_x;

	ACCEL           PLAYER_VX,force;

	RULE    force = (strength + wave_str*WAVE) * booster
		* (FORCE_AHEAD*PLAYER_SIN + 0.5*FORCE_STRAFE*PLAYER_COS)
	        + drift_y;

	ACCEL           PLAYER_VY,force;

////////////////////////////////TURN///////////////////////
	SET             FRICTION,0.5;
	IF_NEQUAL       moving, Mode_Gehen;     // Kein Gehen?
		SET     FRICTION,0.85;

	RULE            force = 0.1*FORCE_ROT;//default 0.5
	ACCEL           PLAYER_VROT,force;

//////////////////////////////// PLAYER_VZ setzen
	RULE            force = gravity + float_str*FORCE_UP;
	SET             FRICTION,fric_air;    // Luftreibung
	IF_ABOVE        PLAYER_HGT,0;         // Schwebt Player in der Luft?
		GOTO    airborne;
        SET             FRICTION,0.98;                  // Bodenreibung
        RULE            force = force - 0.2*PLAYER_HGT; // Bodenelastizitaet
airborne:
	ACCEL           PLAYER_VZ,force;

//////////////////////////////// Ducken
	RULE            duck_val = 0.8*duck_val;
	IF_EQUAL        moving, Mode_Schwimmen; // Schwimmen: auf- und abwaertsducken
		GOTO    duck;
	IF_ABOVE        FORCE_UP,0;             // Gehen: nur abwaertsducken
		GOTO    no_duck;
duck:
	RULE            duck_val = duck_val + duck_str*FORCE_UP;
no_duck:
	RULE            PLAYER_SIZE = PLAYER_SIZE + duck_val;

//////////////////////////////// Springen
	IF_NEQUAL       moving, Mode_Gehen;     // Kein Gehen?
		GOTO    no_jump;

	IF_ABOVE        jump_phase,0;           // Sprung im Gange?
		GOTO    jump_1;
	IF_BELOW        FORCE_UP, 0.1;          // KEIN Tastendruck auf Pos1?
		GOTO    no_jump;
	SET             jump_phase,1;           // Sprung beginnt
jump_1:
	IF_ABOVE        jump_phase,1;
		GOTO    jump_2;
	RULE            duck_val = duck_val - 0.5;
	IF_BELOW        duck_val,-0.7;          // Tief genug geduckt? (Oben berechnetes Minimum beachten!)
		SET     jump_phase,2;           // Dann jetzt hochspringen
	GOTO            no_jump;
jump_2:
	IF_ABOVE        jump_phase,2;
		GOTO    jump_3;
	SET             duck_val,0;                     // Ducken beenden
	RULE            PLAYER_Z = FLOOR_HGT + my_size; // Wieder zu voller Groesse aufrichten
        SET             PLAYER_VZ,0.75;  //used to be 0.5         
						 // Absprung-Geschwindigkeit
	SET             jump_phase,3;           // Als naechstes: Freier Flug
	GOTO            no_jump;
jump_3:
	IF_ABOVE        PLAYER_VZ,0;            // Bewegt Player sich noch nach oben?
		GOTO    no_jump;
	IF_ABOVE        PLAYER_HGT,0;           // Ist Player noch in der Luft?
		GOTO    no_jump;
	SET             jump_phase,0;           // Sprung beendet - bereit fuer naechsten Sprung
no_jump:

//////////////////////////////// Tilt

	RULE player_speed_sqr = PLAYER_VX*PLAYER_VX + PLAYER_VY * PLAYER_VY;

	IF_NEQUAL       tilt_decrease, 1;

         // tilt_decrease steuert, ob PLAYER_TILT wieder
	  GOTO calc_tilt;

            // zur die Normalachse konvergiert (1=const. Tilt)

	IF_ABOVE        PLAYER_TILT, max_player_tilt_p;

        // kein fixes Tilt, wenn <max_player_tilt_
	  GOTO check_speed_tilt;
	IF_ABOVE        PLAYER_TILT, max_player_tilt_n;

	  GOTO decr_tilt;

check_speed_tilt:
        IF_ABOVE player_speed_sqr, 1.4;
               // Reset PLAYER_TILT on move
	  GOTO decr_tilt;

	IF_NEQUAL       PLAYER_VZ, 0;
            // kurze Hoehenaenderung reichtet Blick aus
	  GOTO decr_tilt;
          GOTO calc_tilt;

          // ok, tilt bleibt fix !

decr_tilt:

   // aktiviere Tilt-Decrease -> Normalblick
	SET tilt_decrease, 0.8;


calc_tilt:
        RULE  PLAYER_TILT = tilt_decrease*PLAYER_TILT + 0.3*FORCE_TILT
                             - 0.3*float_str*FORCE_UP*(1-fly_mode);

	IF_ABOVE player_speed_sqr, 0;
	  SKIP 4;
	IF_ABOVE        PLAYER_TILT, max_player_tilt_p;
	  SET tilt_decrease, 1;
	IF_BELOW        PLAYER_TILT, max_player_tilt_n;
	  SET tilt_decrease, 1;

	IF_EQUAL        moving, Mode_Schwimmen;         // Schwimmen?
		RULE    PLAYER_TILT = PLAYER_TILT + 0.01*WAVE;
	IF_EQUAL        moving, Mode_Tauchen;           // Tauchen?
		GOTO    no_htilt;                       // dann kein Fall-Taumeln
	IF_ABOVE        jump_phase,0;                   // Sprung?
		GOTO    no_htilt;

	IF_BELOW tilt_decrease, 1;
	  RULE  PLAYER_TILT = PLAYER_TILT + 0.03*(PLAYER_HGT+0.3);

no_htilt:

//////////////////////////////// Erdbeben
	IF_EQUAL        richter,0;
		GOTO    no_quake;
#       RULE    PLAYER_X = PLAYER_X + richter*(RANDOM - 0.5);
#       RULE    PLAYER_Y = PLAYER_Y + richter*(random_1 - 0.5);
#       RULE    PLAYER_VX = PLAYER_VX + 0.2*richter*(RANDOM - 0.5);
#       RULE    PLAYER_VY = PLAYER_VY + 0.2*richter*(random_1 - 0.5);
	RULE    PLAYER_Z = PLAYER_Z + richter*(random_2 - 0.5);

	SET     random_2,random_1;
	SET     random_1,RANDOM;
no_quake:

////////////////////////////////
	END;
//////////////////////////////// Zoom (disabled)
	IF_ABOVE        KEY_INS,0;
		RULE    PLAYER_ARC = PLAYER_ARC - 0.1;
	IF_ABOVE        KEY_DEL,0;
		RULE    PLAYER_ARC = PLAYER_ARC + 0.1;
}
//BEGIN ACTION ROCKETING///////////////////////////////////////////

ACTION rocketing        {
	RULE            up_joy = up_joy + 0.25*KEY_JOY4;
	IF_EQUAL        KEY_JOY4,0;
		SET     up_joy,0;
	IF_EQUAL KEY_SHIFT,1;
		ADD     up_joy,up_joy;
	IF_ABOVE        KEY_JOY4,0;
		SET     FORCE_UP,up_joy;

	IF_BELOW        FORCE_UP,0;
		SET     rocket_up,0;
	IF_EQUAL        FORCE_UP,0;
		RULE    rocket_up = rocket_up - 0.05*TIME_CORR;
	IF_ABOVE        FORCE_UP,0;
		RULE    rocket_up = rocket_up + 0.1*TIME_CORR + 0.1*RANDOM;

	IF_ABOVE        rocket_up,1;
		SET     rocket_up,1;

	//IF_EQUAL        HERE.FLAG8,1;
	//      GOTO    no_uwreg;
	IF_BELOW        PLAYER_HGT,0.4;
		RULE    rocket_up=0.95*rocket_up; // triebwerk bei bodenkontakt drosseln
no_uwreg:

	IF_BELOW        FORCE_UP,0.1;
		GOTO    no_addrock;

	IF_BELOW PLAYER_VZ,-0.5;
		RULE    rocket_up = 2*rocket_up;  // triebwerk in freiem Fall wirksamer

#       IF_EQUAL        underwater,1;
#               RULE    rocket_up = 1.3*rocket_up; // triebwerk unter wasser wirksamer
no_addrock:

        CALL            move_me;
}
///END OF ACTION ROCKETING

# =====================================================================
# CONVENIENT ACTIONS
# =====================================================================
ACTION set_walking {    // Modus 'Gehen' einschalten
	SET     moving, Mode_Gehen;
	SET     fric,0.2;
        SET     strength,0.35;
	SET     wave_str,0;
	SET     float_str,0;
	SET     duck_str,0.5;
	SET     fric_air,0.04;
	SET     gravity,-0.13;
	SET     EACH_TICK.16,move_me;
}

ACTION set_swimming { // Modus 'Schwimmen' einschalten
	SET     fric,0.3;
	SET     moving, Mode_Schwimmen;
        SET     strength,0.25;  // 0.1 //was 0.15
	SET     wave_str,0.08;  // 0.03
	SET     float_str,0;
	SET     duck_str,0.2;
	SET     fric_air,0.5;
	SET     gravity,-0.05;  // reduzieren, sonst Eintauchen zu tief
	SET     EACH_TICK.16,move_me;
}

ACTION set_diving { // Modus 'Tauchen' einschalten
	SET     fric,0.3;
	SET     moving, Mode_Tauchen;
        SET     strength,0.25;
	SET     wave_str,0.03;
	SET     float_str,0.05;
	SET     duck_str,0;
	SET     fric_air,0.7;
	SET     gravity,0;
	SET     EACH_TICK.16,move_me;
}

ACTION set_rocketing {    // Modus 'Rocket' einschalten
	SET     moving, Mode_Rocket;
        SET     fric,0.02;
        SET     strength,0.55;
	SET     wave_str,0;
	SET     float_str,0;
	SET     duck_str,0.5;
	SET     fric_air,0.04;
	SET     gravity,-0.02;
        SET     EACH_TICK.16,move_me;
}


ACTION set_moving {     // aktiviert die letzte move-Aktion
	IF_EQUAL        moving,0;
		END;
	IF_EQUAL        moving, Mode_Gehen;
		BRANCH  set_walking;
	IF_EQUAL        moving, Mode_Schwimmen;
		BRANCH  set_swimming;
	IF_EQUAL        moving, Mode_Tauchen;
		
		BRANCH  set_diving;
	IF_EQUAL         moving, Mode_Rocket;
		BRANCH   set_rocketing;
}


ACTION stop_moving {    // stopt Playerbewegung
	SET             PLAYER_VX,0;
	SET             PLAYER_VY,0;
	SET             PLAYER_VZ,0;
	SET             PLAYER_VROT,0;
}


# =====================================================================
# Unterwasser-Aktionen
# =====================================================================
ACTION set_blue { FADE_PAL      blue_pal,0.7; }
ACTION reset_blue { FADE_PAL    blue_pal,0;     }



SYNONYM set_underwater  { TYPE ACTION; DEFAULT set_blue; }
SYNONYM set_overwater   { TYPE ACTION; DEFAULT reset_blue; }

ACTION regio_dive {
SET RENDER_MODE, 1;     
IF_EQUAL        underwater,1;           // Ist der Player schon unter Wasser?
		END;                      // dann Schluss (then end)
	SET             underwater,1;           // underwater from now on
	//FADE_PAL        blue_pal, 0.7; //set underwater palette
	RULE            PLAYER_ARC = PLAYER_ARC + 0.3;
						// Blickwinkel veraendern
						      //change pt.of view
	RULE            my_size = my_size-0.3;           // Hysterese
	RULE            PLAYER_SIZE = PLAYER_SIZE-0.3;
      
	RULE            PLAYER_Z=PLAYER_Z -0.3;
	CALL            set_underwater;
	CALL            set_diving;
}

// Wird bei IF_ARISE von Wasser-Region ausgeloest



ACTION regio_divered {
SET RENDER_MODE, 1;     
IF_EQUAL        underwater,1;           // Ist der Player schon unter Wasser?
		END;                      // dann Schluss (then end)
	SET             underwater,1;           // underwater from now on
	FADE_PAL        red_pal, 0.7; //set underwater palette
	RULE            PLAYER_ARC = PLAYER_ARC + 0.3;
						// Blickwinkel veraendern
						      //change pt.of view
	RULE            my_size = my_size-0.3;           // Hysterese
	RULE            PLAYER_SIZE = PLAYER_SIZE-0.3;
      
	RULE            PLAYER_Z=PLAYER_Z -0.3;
        RULE            health=health -25;
        PLAY_SOUNDFILE  <aargh2.wav>, 0.5;
	CALL            set_diving;
}


ACTION regio_divebrown {
SET RENDER_MODE, 1;     
IF_EQUAL        underwater,1;           // Ist der Player schon unter Wasser?
		END;                      // dann Schluss (then end)
	SET             underwater,1;           // underwater from now on
	FADE_PAL        brown_pal, 0.7; //set underwater palette
	RULE            PLAYER_ARC = PLAYER_ARC + 0.3;
						// Blickwinkel veraendern
						      //change pt.of view
	RULE            my_size = my_size-0.3;           // Hysterese
	RULE            PLAYER_SIZE = PLAYER_SIZE-0.3;
      
	RULE            PLAYER_Z=PLAYER_Z -0.3;
	CALL            set_diving;
}


// Wird bei IF_ARISE von Wasser-Region ausgeloest
ACTION regio_arise {
      SET        RENDER_MODE,1; 
IF_EQUAL        underwater,0;           // Player schon ueber Wasser?
		END;                          //Player already above water?
	
	SET             underwater,0;
	FADE_PAL        blue_pal,0;
	RULE            PLAYER_ARC = PLAYER_ARC - 0.3;  // Blickwinkel normalisieren
	RULE            my_size = my_size+0.3;                          // Hysterese
	RULE            PLAYER_SIZE = PLAYER_SIZE+0.3;
	RULE            PLAYER_Z = PLAYER_Z+0.3;
	CALL            set_overwater;
	CALL            set_swimming;
}

ACTION regio_arisered {
      SET        RENDER_MODE,1; 
IF_EQUAL        underwater,0;           // Player schon ueber Wasser?
		END;                          //Player already above water?
	
	SET             underwater,0;
	FADE_PAL        red_pal,0;
	RULE            PLAYER_ARC = PLAYER_ARC - 0.3;  // Blickwinkel normalisieren
	RULE            my_size = my_size+0.3;                          // Hysterese
	RULE            PLAYER_SIZE = PLAYER_SIZE+0.3;
	RULE            PLAYER_Z = PLAYER_Z+0.3;
	
	CALL            set_swimming;
}

ACTION regio_arisebrown {
      SET        RENDER_MODE,1; 
IF_EQUAL        underwater,0;           // Player schon ueber Wasser?
		END;                          //Player already above water?
	
	SET             underwater,0;
	FADE_PAL        brown_pal,0;
	RULE            PLAYER_ARC = PLAYER_ARC - 0.3;  // Blickwinkel normalisieren
	RULE            my_size = my_size+0.3;                          // Hysterese
	RULE            PLAYER_SIZE = PLAYER_SIZE+0.3;
	RULE            PLAYER_Z = PLAYER_Z+0.3;
	
	CALL            set_swimming;
}

# =====================================================================
# SPECIAL ACTION : QUAKE
# =====================================================================
ACTION start_quake {
	BRANCH quake;
}

ACTION quake {
	SET     EACH_TICK.9,quake;      // Aktion jetzt in EACH_TICK-Liste
	SET     richter,0.1;            // Erdbeben langsam beginnen...
	WAITT   16;
	SET     richter,0.3;
	WAITT   32;
	SET     richter,0.5;            // Hoehepunkt
	WAITT   48;
	SET     richter,0.2;            // Verschnaufpause...
	WAITT   80;
	SET     richter,0.6;            // Zweiter Hoehepunkt
	WAITT   32;
	SET     richter,0.1;            // Ausklingen
	WAITT   16;
	SET     richter,0;                      // wieder Ruhe
	SET     EACH_TICK.9,NULL;       // Aktion schaltet sich selbst ab

}

# =====================================================================
# TASTATURBELEGUNG COMMENTED OUT!# =====================================================================

IF_W  set_walking;
#IF_2   set_swimming;
#IF_3   set_diving;
#IF_R  set_flying;

#IF_E   start_quake;

ACTION schubs {     //used when shotgun and pistol hits you
	RULE PLAYER_VX = PLAYER_VX + imp_fac*(PLAYER_X - MY.X)/HIT_DIST;
	RULE PLAYER_VY = PLAYER_VY + imp_fac*(PLAYER_Y- MY.Y)/HIT_DIST;
}
