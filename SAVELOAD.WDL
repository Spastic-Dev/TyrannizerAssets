//////////////////////////////////////////////////////////
// message actions
//////////////////////////////////////////////////////////

//FONT	standard_font,<panfont.pcx>,8,10;	already defined

STRING empty," ";

TEXT screen_txt {					// TEXT to display a message
	POS_X 	30;
	POS_Y 	24;
	FONT		standard_font;		// s.o.
	STRING	empty;
}

ACTION show_message {				// Meldung anzeigen
	SET	MESSAGES.14,screen_txt;
	WAITT	80;							// 5 Sekunden warten
	SET	MESSAGES.14,NULL;
}

ACTION wait_yesno {			// Auf J/N-Tastenbetaetigung warten
	SET	MESSAGES.14,screen_txt;	// Frage anzeigen
	SET	MOVE_MODE,0;				// Player einfrieren
	SET	IF_N, clear_yesno;		// Tasten belegen
	SET	IF_ESC, clear_yesno;
}

ACTION clear_yesno {			// J/N-Abfrage beenden
	SET	MESSAGES.14,NULL;	// Text weg
	SET	MOVE_MODE,1;		// Player wieder auftauen
	SET	IF_J, NULL;			// Tasten ent-belegen
	SET	IF_Y, NULL;
	SET	IF_Z, NULL;
	SET	IF_N, NULL;
	SET	IF_ESC, NULL;
	SET	IF_F3,qload_game1;	// F3 laedt wieder den letzten Spielstand
}

///////////////////////////////////////////////////////////
// Save/Load actions
///////////////////////////////////////////////////////////
SKILL slot	{ TYPE GLOBAL; VAL 1; }	// number of last score file (1..3)
//////////////////////////////////////////////////////////
SKILL number { VAL 0; }		// number of score file to load
//////////////////////////////////////////////////////////
SAVEDIR	"";	// save into current directory

STRING ok,"OK";
STRING save_yesno,"Spielstand sichern (J/N)?";
STRING load_yesno1,"Letzten Spielstand laden (J/N/F3)?";
STRING load_yesno2,"Vorletzten Stand laden (J/N/F3)?";
STRING load_yesno3,"Drittletzten Stand laden (J/N/F3)?";
STRING wait_txt,"Bitte warten...";
STRING save_nix,"FEHLER - Nichts gesichert!\nHarddisk schon voll?";
STRING load_nix,"Sorry - kein Spielstand gefunden!\nMerke:\nErst sichern - dann laden!";

//////////////////////////////////////////////////////////
ACTION qsave_game {			// Spielstand speichern, mit Abfrage
	SET	screen_txt.STRING,save_yesno;
	SET	IF_J, save_game;
	SET	IF_Y, save_game;
	SET	IF_Z, save_game;
	CALL	wait_yesno;
}

ACTION load_slot {			// read slot skill off hard disk
	LOAD_INFO	"INFO",0;
}

ACTION save_game {			// Spielstand direkt speichern
	CALL		clear_yesno;
	CALL		load_slot;		// globalen Skill slot laden
	RULE		slot = slot + 1;		// und um 1 erhoehen
	IF_ABOVE	slot,3;			// Wenn >3, dann wieder auf 1
		RULE	slot = slot - 3;
	SAVE_INFO	"INFO",0;	// neuen slot-skill wieder speichern
	SET		RESULT,0;		// Um Fehler zu erkennen
	SET		screen_txt.STRING,ok;
	CALL		show_message;
	SAVE		"GAME",slot;	// Game abspeichern

	IF_BELOW	RESULT,0;		// Fehler beim Speichern?
		SET	screen_txt.STRING,save_nix;
	SET		IF_F3,qload_game1;
}

ACTION qload_game1 {
	SET		number,0;		// nimm letzten Spielstand
	SET		screen_txt.STRING,load_yesno1;
	SET		IF_Y,load_game;
	SET		IF_Z,load_game;
	SET		IF_J,load_game;
	SET		IF_F3,qload_game2;
	CALL		wait_yesno;
}

ACTION qload_game2 {
	SET		number,1;		// vorletzten Spielstand
	SET		screen_txt.STRING,load_yesno2;
	SET		IF_Y,load_game;
	SET		IF_Z,load_game;
	SET		IF_J,load_game;
	SET		IF_F3,qload_game3;
	CALL		wait_yesno;
}

ACTION qload_game3 {
	SET		number,2;		// drittletzten Spielstand
	SET		screen_txt.STRING,load_yesno3;
	SET		IF_Y,load_game;
	SET		IF_Z,load_game;
	SET		IF_J,load_game;
	SET		IF_F3,qload_game1;
	CALL		wait_yesno;
}

ACTION load_game {
	CALL		clear_yesno;
	SET		screen_txt.STRING,wait_txt;
	SET		MESSAGES.14,screen_txt;
	WAIT		1;				// to display wait message before loading

	CALL		load_slot;	// globalen Skill slot laden
	RULE		slot = slot - number;
	IF_BELOW	slot,1;
		RULE	slot = slot + 3;
	LOAD		"GAME",slot;
	SET		screen_txt.STRING,load_nix;	// schiefgegangen!
	BRANCH	show_message;		// Fehlermeldung
}

//////////////////////////////////////////////////////////
IF_F2	qsave_game;
IF_F3	qload_game1;
///////////////////////////////////////////////////////////////////
