/****************************************************
 * xtylizer.webs.com - Author: Ujjwal			
 *
 *    #    # ######## ######
 *     #  #     #	  #    #
 *      ##      #     ######
 *     #  #     #     # #
 *    #    #    #     #  #
 ****************************************************/
main(phase, register)								
{
	codam\utils::debug(0, "======== xtr/main:: |", phase, "|", register, "|");
	level._effect["smoke1"] = loadfx ("fx/smoke/neuville_smoke1.efx");
	level._effect["smoke"] = loadfx("fx/smoke/smoke_fill2lite.efx");


	switch(phase)
	{
	  case "init":
      _init(register);
    break;
	  case "load":
      _load();
    break;
	  case "start":
      _start();
    break;
	}
	return;
}

_init(register)
{
	codam\utils::debug(0, "======== xtr/_init:: |", register, "|");

	if(isDefined(level.modbysil))
    return;
    
  level.modbysil = true;

  // Instant kill, Headshot only, No-Damage on FF
  [[ register ]]("finishPlayerDamage", ::_finishPlayerDamage, "takeover"); // from Cato
  
  //Shows amount of damage done.
  //[[ register ]]("finishPlayerDamage", ::showD, "thread");

  //New anti-ff
  //[[ register ]]("spawnPlayer", ::antiFF, "thread"); //from Cato
  //[[ register ]]("spawnPlayer", ::nade, "thread"); //SMOKE NADES DONE, NEED TO ADD 2 types of nades 1smoke 1grenade
  
  
  //Autoswap with new theme(tbh. cod4 ditto :V)
  [[ register ]]("gt_endRound", ::endRound, "takeover" );
  

   //You can kill with c4 which you plant at either A or B. :D
  [[ register ]]("finishPlayerDamage", ::c4killer, "thread" );
  
  
  //Deciding Mvp of round. 
  [[ register ]]("PlayerConnect",	::reset, "thread");
  [[ register ]]("spawnPlayer", ::reset, "thread");
  [[ register ]]("finishPlayerDamage", ::P_RoundScore, "thread"); 
  [[ register ]]("roundcam", ::roundcam, "takeover"); 
  
  
  //Freezetime at round start
  //Forced roundlength to roundtime+freezetime, so that it won't affect playing roundlength 
  // Modification: codam/misc.gsc  -> level.roundlength = codam\utils::getVar( "scr", "roundlength", "float", 1|2, 4, 1 ) + codam\utils::getVar( "scr", "freezetime", "float", 1|2, 4, 1 )/60; 
  [[ register ]]("gt_startRound", ::s_time, "thread");
  [[ register ]]("spawnPlayer", ::s_wait, "thread");


	return;
}

_load()
{
	codam\utils::debug(0, "======== xtr/_load");
	if(isDefined(level.modbysil1))
    return;
    
  level.modbysil1 = true;

  precacheShader("gfx/hud/objective_ring.dds");
  precacheString(&"+");
  precacheString(&"^2GO!");
  precacheShader("gfx/hud/headicon@axis.dds");
  precacheShader("gfx/hud/headicon@allies.dds");
  precachemodel("xmodel/crate_misc_green5");

  
	
	return;
}

_start()
{
	codam\utils::debug(0, "======== xtr/_start");	
	if(isDefined(level.modbysil3))
    return;
    
  level.modbysil3= true;
  
  // O.o this is it, nothing more to do here!

	return;
}
/*nade()
{
	self endon( "death" );
	self endon( "disconnect" );
	self.pers["nadechoice"]=1;
	
	while ( 1 )
	{
		weap = self getCurrentWeapon();
		if ( weap == "stielhandgranate_mp" || weap == "fraggrenade_mp" || 
		     weap == "rgd-33russianfrag_mp" || weap == "mk1britishfrag_mp" )
		{
			if(self useButtonPressed()) {
				if(self.nadechoice==1) {
					self setWeaponSlotWeapon( "grenade", "mk1britishfrag_mp" ); 
					self setWeaponSlotAmmo( "grenade", 1 );
					self switchToWeapon("mk1britishfrag_mp");
					self.nadechoice=2;
				}
				else if(self.nadechoice==2) {
					self setWeaponSlotWeapon( "grenade", "fraggrenade_mp" ); 
					self setWeaponSlotAmmo( "grenade", 1 );
					self switchToWeapon("fraggrenade_mp");
					self.nadechoice=1;
				}

			wait 0.1;
			}
			
			mynade = undefined;
			ents = getEntArray( "grenade", "classname" );
			for ( i = 0; i < ents.size; i++ )
			{
				if ( distance( ents[ i ].origin, self.origin ) < 72 && !isDefined( ents[ i ].user ) )
					mynade = ents[ i ];
			}
			if(self useButtonPressed())
				self setWeaponSlotWeapon( "grenade", "mk1britishfrag_mp" );
			
			if ( isDefined( mynade ) )
			{
				self.isfollowingnade = true;
				self.nadenotice.alpha = 1;
				

				mynade.user = self;

					
				self setWeaponSlotAmmo( "grende", 0 );

				for(;;) {
					wait 0.05;
					if(!isDefined(mynade))
						break;
					nadefall = mynade.origin;

				}
				
				
				
				wait 1;
				for(i=0;i<=40;i++) {
				playfx(level._effect["smoke"], nadefall);
				playfx(level._effect["smoke"], nadefall);
				playfx(level._effect["smoke"], nadefall);
				playfx(level._effect["smoke"], nadefall);
				playfx(level._effect["smoke"], nadefall);
				playfx(level._effect["smoke"], nadefall);
				playfx(level._effect["smoke"], nadefall);
				playfx(level._effect["smoke"], nadefall);
				playfx(level._effect["smoke"], nadefall);
				playfx(level._effect["smoke"], nadefall);
				
				playfx(level._effect["smoke1"], nadefall);
				playfx(level._effect["smoke1"], nadefall);
				playfx(level._effect["smoke1"], nadefall);
				playfx(level._effect["smoke1"], nadefall);
				playfx(level._effect["smoke1"], nadefall);
				playfx(level._effect["smoke1"], nadefall);
				playfx(level._effect["smoke1"], nadefall);
				playfx(level._effect["smoke1"], nadefall);
				playfx(level._effect["smoke1"], nadefall);
				playfx(level._effect["smoke1"], nadefall);
				wait 0.5;
				}


				self.isfollowingnade = undefined;
			}
			
			//self setWeaponSlotWeapon( "grenade", weap );
			
		}
		
		//self setWeaponSlotAmmo( "grenade", 1 );

		
		wait 0.02;
	}
}*/

// MVP
mvp() //thread in POWERSAVER/ ENDROUND
{
	topPlayer = undefined;
	score = 0;
	topPlayer1 = undefined;
	score1 = 0;
	topPlayer2 = undefined;
	score2 = 0;
	topPlayer3 = undefined;
	score3 = 0;
	
	
	players = getEntArray("player", "classname");
	for(i = 0; i < players.size; i++) {
		if(players[i].score > score) {
			score = players[i].score;
			topPlayer = players[i];
		}
	}
	
	iprintlnbold("BEST PLAYER^3:^7 " + topPlayer.name + " ^7is having ^3" + score + " ^7kills.");
	
	for(i = 0; i < players.size; i++) {
		if(players[i].score == score && players[i]!=topPlayer) {
			score1 = players[i].score;
			topPlayer1 = players[i];
		}
	}
	iprintlnbold("BEST PLAYER^3:^7 " + topPlayer1.name + " ^7is having ^3" + score1 + " ^7kills.");
	
	for(i = 0; i < players.size; i++) {
		if(players[i].score == score && players[i]!=topPlayer && players[i]!=topPlayer1) {
			score2 = players[i].score;
			topPlayer2 = players[i];
		}
	}
	iprintlnbold("BEST PLAYER^3:^7 " + topPlayer2.name + " ^7is having ^3" + score2 + " ^7kills.");
	
	
	for(i = 0; i < players.size; i++) {
		if(players[i].score == score && players[i]!=topPlayer && players[i]!=topPlayer1 && players[i]!=topPlayer2) {
			score3 = players[i].score;
			topPlayer3 = players[i];
		}
	}
	iprintlnbold("BEST PLAYER^3:^7 " + topPlayer3.name + " ^7is having ^3" + score3 + " ^7kills.");

}
c4killer(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, a9, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9) {
	if(level.bombplanted == false) 
	return;

	
	if(sMeansOfDeath == "MOD_EXPLOSIVE" && self.pers["team"]!=allies ) {
		level.planter.pers["score"]++;
		level.planter.score++;
		iprintln(level.planter.name + " ^7killed " + self.name +" ^7with ^2c4");

	}

}
//ROUND MVP
reset() {
	
		self.pers["Rscore"]=0;
}
P_RoundScore(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, a9, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9) {
	

		
		//if(codam\utils::getVar("scr", "roundmvp", "int", 1, 0)) 
			if(isPlayer(eAttacker) && eAttacker != self) {
				
				 wait(0.001);

                  if(self.health == 0)
					eAttacker.pers["Rscore"]++;
				 

			}
				
	
}
roundcam( goal, delay, msg, a3, a4, a5, a6, a7, a8, a9,
			b0, b1, b2, b3, b4, b5, b6, b7, b8, b9 )
{
	codam\utils::debug( 90, "killcam/roundcam:: |", self.name, "|",
						goal, "|", delay, "|",
						msg, "|", spawnSpec, "|" );

	if ( !isdefined( msg ) )
		msg = &"MPSCRIPT_ROUNDCAM";

	self.sessionstate = "spectator";

	if ( isPlayer( goal ) )
		self.spectatorclient = goal getEntityNumber();
	else
	{
		self.spectatorclient = -1;
		self spawn( goal.origin , goal.angles );
	}

	self.archivetime = delay + 7;

	// wait till the next frame to give the player the killcam hud elements
	wait( 0.05 );
	
	
	thread showRMVP();
	

	if ( !isdefined( self.kc_topbar ) )
	{
		self.kc_topbar = newClientHudElem( self );
		self.kc_topbar.archived = false;
		self.kc_topbar.x = 0;
		self.kc_topbar.y = 0;
		self.kc_topbar.alpha = 0.5;
		self.kc_topbar setShader( "black", 640, 112 );
	}
	

	if ( !isdefined( self.kc_bottombar ) )
	{
		self.kc_bottombar = newClientHudElem( self );
		self.kc_bottombar.archived = false;
		self.kc_bottombar.x = 0;
		self.kc_bottombar.y = 368;
		self.kc_bottombar.alpha = 0.5;
		self.kc_bottombar setShader( "black", 640, 112 );
	}
	

	if ( !isdefined( self.kc_title ) )
	{
		self.kc_title = newClientHudElem( self );
		self.kc_title.archived = false;
		self.kc_title.x = 320;
		self.kc_title.y = 40;
		self.kc_title.alignX = "center";
		self.kc_title.alignY = "middle";
		self.kc_title.sort = 1; // force to draw after the bars
		self.kc_title.fontScale = 3.5;
	}
	self.kc_title setText( msg );

	if ( !isdefined( self.kc_skiptext ) )
	{
		self.kc_skiptext = newClientHudElem( self );
		self.kc_skiptext.archived = false;
		self.kc_skiptext.x = 320;
		self.kc_skiptext.y = 72;
		self.kc_skiptext.alignX = "center";
		self.kc_skiptext.alignY = "middle";
		self.kc_skiptext.sort = 1.2; // force to draw after the bars

	}
	self.kc_skiptext setText( &"MPSCRIPT_STARTING_NEW_ROUND" );

	if ( !isdefined( self.kc_timer ) )
	{
		self.kc_timer = newClientHudElem( self );
		self.kc_timer.archived = false;
		self.kc_timer.x = 320;
		self.kc_timer.y = 428;
		self.kc_timer.alignX = "center";
		self.kc_timer.alignY = "middle";
		self.kc_timer.fontScale = 3.5;
		self.kc_timer.sort = 1;
	}

	if ( self.archivetime > delay )
	{
		self.kc_timer setTimer( self.archivetime - delay );

		wait( self.archivetime - 0.05 );
	}

	self removeKillcamElements();

	self.spectatorclient = -1;
	self.archivetime = 0;

	level notify( "roundcam_ended" );
	return;
}
removeKillcamElements()
{
	if ( isdefined( self.kc_topbar ) )
		self.kc_topbar destroy();
	if ( isdefined( self.kc_bottombar ) )
		self.kc_bottombar destroy();
	if ( isdefined( self.kc_title ) )
		self.kc_title destroy();
	if ( isdefined( self.kc_skiptext ) )
		self.kc_skiptext destroy();
	if ( isdefined( self.kc_timer ) )
		self.kc_timer destroy();
	return;
}


showRMVP( cam, roundwinner, a2, a3, a4, a5, a6, a7, a8, a9,	b0, b1, b2, b3, b4, b5, b6, b7, b8, b9 ) {

	

	
	thread getPlayerByID();
	
	if(level.bombdefused==true) {
		self iprintln("^7MVP^1:^7 " + level.defuser.name + " ^7for defusing the explosives.");
		return;
	}
	
	if(level.bombplanted==true) {
		self iprintln("^7MVP^1:^7 " + level.planter.name + " ^7for planting the explosives.");
		return;
	}
	
	topKILLER = undefined;
	topSCORE = 0;
	
	players = getEntArray("player", "classname");
	
	for(i = 0; i < players.size; i++) {
		if(players[i].pers["Rscore"] > topSCORE) {

			topSCORE = players[i].pers["Rscore"];
			topKILLER = players[i];
			
		
		}
	}
	

	self iprintln("^7MVP^1:^7 " + topKILLER.name + " ^7for most eliminations.");
}


//Insantkill,HeadshotOnly,NoDamage on FF
_finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, a9, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9)
{
	/*if(isDefined(eAttacker)) { 
		if(isDefined(eAttacker) && sMeansOfDeath == "MOD_MELEE")
			return (self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc));
			
		if(isBoltWeapon(sWeapon) && isDefined(eAttacker.fastfire))
			return;
		
		if(codam\utils::getVar("scr", "headshot_only", "bool", 1|2, false) && sHitLoc != "head")
			return;
	}*/

	// Don't do knockback if the damage direction was not specified
	if(!isDefined(vDir))
		iDFlags |= level.iDFLAGS_NO_KNOCKBACK;

	// Make sure at least one point of damage is done
	if(iDamage < 1)
		iDamage = 1;

 
	if(codam\utils::getVar("scr", "instantkill", "bool", 1|2, false)) {
		if(isDefined(eAttacker) && sMeansOfDeath != "MOD_FALL" && isBoltWeapon(sWeapon)) 
				iDamage = iDamage * 999;
	}
				
	
		return (self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc));
}

/*showD(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, a9, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9)
{
		if(isDefined(eAttacker)) { 
		if(isBoltWeapon(sWeapon) && isDefined(eAttacker.fastfire))
			return;
		}
		
		if(codam\utils::getVar("scr", "showdamage", "int", 1, 0)) {
			if(isPlayer(eAttacker) && eAttacker != self) {
				
				if(getcvar("scr_instantkill") == 1 && isBoltWeapon(sWeapon)) {
					eAttacker.damageS=100;
					eAttacker thread showDamage();
				}
				else {
								
					eAttacker.damageS=iDamage;
					eAttacker thread showDamage();
				}
			}
						
		}
}
showDamage() 
{
  self endon("spawned");
	self endon("disconnect");
	


	self.hitBlip = newClientHudElem(self);
	self.hitBlip.alignX = "center";
	self.hitBlip.alignY = "middle";
	self.hitBlip.x = 320;
	self.hitBlip.y = 240;
	self.hitBlip.alpha = 1;
	self.hitBlip.label =&"+";
	self.hitBlip.fontscale = 1;
	self.hitBlip setValue( self.damageS );
	self.hitBlip.archive = true;
	self.hitBlip.color = (0.85882, 0.70588, 0.04706);
	
	self.hitBlip fadeOverTime( 0.5 );
	self.hitBlip.alpha = 0;
	self.hitBlip moveOverTime( 0.5 );
	self.hitBlip.y = 230;
	


}*/


isBoltWeapon(sWeapon)
{
  switch(sWeapon) {
    case "enfield_mp":
    case "fg42_mp":
    case "fg42_semi_mp":
    case "kar98k_mp":
    case "kar98k_sniper_mp":
    case "mosin_nagant_mp":
    case "mosin_nagant_sniper_mp":
    case "springfield_mp":
    return true;
  }
  
  return false;
}
/*antiFF(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9)
{
	wait 1; // tmp to fix the spawn problem
	
	self endon("spawned"); // tmp to fix the spawn problem
	self endon("disconnect"); // tmp to fix the spawn problem



	fastfire = codam\utils::getVar("scr", "fastfire", "int", 1|2, 0);
	if(fastfire == 0)
		return;

	if(!isDefined(level.fastfireaction)) {
		level.fastfireaction = "suicide";
		if(getCvar("scr_mm_fastfireaction") != "" && getCvar("scr_mm_fastfireaction") != "suicide")
			level.fastfireaction = getCvar("scr_mm_fastfireaction");
	}
	
	wait 1;

	weaponTimes = []; // self getCurrentWeapon();
	weaponTimes["kar98k_sniper_mp"] = 1350;
	weaponTimes["kar98k_mp"] = 1350;
	weaponTimes["mosin_nagant_sniper_mp"] = 1500;
	weaponTimes["mosin_nagant_mp"] = 1350;
	weaponTimes["springfield_mp"] = 1300; // possibly 1250 or 1300(old)
	weaponTimes["enfield_mp"] = 1450;
	weaponTimes["default"] = 1300;
	
	if(!isDefined(self.pers["fastfire"]))
		self.pers["fastfire"] = 0;
	
	while(self.sessionstate == "playing") {
		wait 0.05;
		
		currentWeapon = self getCurrentWeapon();
		if(!isBoltWeapon(currentWeapon))
			continue;
		
		if(currentWeapon == self getWeaponSlotWeapon("primary"))
			weaponSlot = "primary";
		else if(currentWeapon == self getWeaponSlotWeapon("primaryb"))
			weaponSlot = "primaryb";
		else
			continue;
		
		weaponAmmo = self getWeaponSlotClipAmmo(weaponSlot);
		if(!isDefined(weaponAmmo)) continue;

		while(self getWeaponSlotClipAmmo(weaponSlot) == weaponAmmo && currentWeapon == self getCurrentWeapon())
			wait 0.05;
		
		if(self getWeaponSlotClipAmmo(weaponSlot) > weaponAmmo)
			continue;

		weaponAmmo = self getWeaponSlotClipAmmo(weaponSlot);
		if(!isDefined(weaponAmmo)) continue;
		
		if(currentWeapon == self getCurrentWeapon()) {
			weaponTime = weaponTimes["default"];
			if(isDefined(weaponTimes[currentWeapon]))
				weaponTime = weaponTimes[currentWeapon];
			
			startTime = getTime() + (weaponTime - 50);

			self.fastfire = true;
			while(startTime > getTime()) {
				if(currentWeapon != self getCurrentWeapon()) {
					currentWeapon = self getCurrentWeapon();
					if(!isBoltWeapon(currentWeapon))
						break;

					if(currentWeapon == self getWeaponSlotWeapon("primary"))
						weaponSlot = "primary";
					else if(currentWeapon == self getWeaponSlotWeapon("primaryb"))
						weaponSlot = "primaryb";
					else
						break;

					weaponAmmo = self getWeaponSlotClipAmmo(weaponSlot);
					if(!isDefined(weaponAmmo)) break;
				}
				
				if(self getWeaponSlotClipAmmo(weaponSlot) < weaponAmmo) { // TODO: code became messy here, recode sometime
					weaponTime = weaponTimes["default"];
					if(isDefined(weaponTimes[currentWeapon]))
						weaponTime = weaponTimes[currentWeapon];
					
					startTime = getTime() + (weaponTime - 50);
					
					if(fastfire != -1) {
						self.pers["fastfire"]++;
						if(self.pers["fastfire"] < fastfire)
							self iPrintLn("^3Warning! ^7Fast fire detected.");

						if(self.pers["fastfire"] >= fastfire) {
							iPrintLn(self.name + " ^7Was punished for fast fire.");
							self.pers["fastfire"] = 0;

							switch(level.fastfireaction) {
								case "suicide":
									self thread [[ level.gtd_call ]]("suicide");
								break;
								default:
									self thread [[ level.gtd_call ]]("goSpectate");
								break;
							}
							
							break;
						}
					} else 
						if(self.sessionstate == "playing")
							self iPrintLn("^3Warning! ^7Fast fire detected.");

					weaponAmmo = self getWeaponSlotClipAmmo(weaponSlot);
					if(!isDefined(weaponAmmo)) break;
				}
				
				wait 0.05;
			}

			self.fastfire = undefined;
		}
	}
}*/
endRound( announce, roundwinner, a2, a3, a4, a5, a6, a7, a8, a9,
			b0, b1, b2, b3, b4, b5, b6, b7, b8, b9 )
{
	if ( !isdefined( announce ) &&
	     !isdefined( roundwinner ) )
		level waittill( "end_round", announce, roundwinner, cam,
								timeexpired );

	codam\utils::debug( 0, "endRound:: |", announce, "|", roundwinner, "|",
						cam, "|", timeexpired, "|" );

	level thread [[ level.gtd_call ]]( "hud_announce", announce );

	if ( level.roundended )
		return;

	if ( roundwinner == "reset" )
	{
		// Starting a new match ...

		wait( 2 );	// Allow time to view "start" message

		if ( game[ "mapstarted" ] ||
		     ( level.exist[ "allies" ] && level.exist[ "axis" ] ) )
			game[ "matchstarted" ] = true;
		[[ level.gtd_call ]]( "resetScores" );
		game[ "roundsplayed" ] = 0;

		level.roundended = true;
	}
	else
	{
		_announce = "MP_announcer_round_draw";

		if ( roundwinner == "allies" )
		{
			roundloser = "axis";
			game[ "alliedscore" ]++;
			score = game[ "alliedscore" ];
			_announce = "MP_announcer_allies_win";
		}
		else if ( roundwinner == "axis" )
		{
			roundloser = "allies";
			game[ "axisscore" ]++;
			score = game[ "axisscore" ];
			_announce = "MP_announcer_axis_win";
		}

		winners = [];
		losers = [];

		players = getentarray( "player", "classname" );
		for ( i = 0; i < players.size; i++ )
		{
			player = players[ i ];

			if ( roundwinner != "draw" )
			{
				_team = player.pers[ "team" ];
				if ( isdefined( _team ) )
				{
					if ( _team == roundwinner )
						winners[ winners.size ] = player;
					else if ( _team == roundloser )
						losers[ losers.size ] = player;
				}
			}

			player playLocalSound( _announce );
		}

		[[ level.gtd_call ]]( "gt_saveWeapons" );

		if ( roundwinner != "draw" )
		{
			[[ level.gtd_call ]]( "setTeamScore", roundwinner,
									score );

			if ( game[ "matchstarted" ] )
			{
				[[ level.gtd_call ]]( "logPrint", "winner",
							roundwinner, winners );
				[[ level.gtd_call ]]( "logPrint", "loser",
							roundloser, losers );
			}

			if ( !isdefined( timeexpired ) )
				[[ level.gtd_call ]]( "gt_roundCam",
							cam, roundwinner );
			else
				wait( 3 );	// Allow time to view winner

			[[ level.gtd_call ]]( "checkScoreLimit",
			  			"gt_scoreLimitReached" );
		}
		else
			wait( 3 );	// Allow time to view draw message

		game[ "roundsplayed" ]++;
		
		
		

		if(codam\utils::getVar("scr", "autoswap", "int", 1, 0))
			{
				if(game[ "alliedscore" ]==10 || game[ "axisscore" ]==10)
					return;
				
				swap_round = getcvarint("scr_sd_swap_round");
				if ( game[ "roundsplayed" ] == swap_round )
			{
		thread winlose();
		wait ( 8 );
		thread swp();
		wait ( 5 );
			}
			}
		self thread clear();
		[[ level.gtd_call ]]( "checkRoundLimit",
						"gt_roundLimitReached" );
		level.roundended = true;
		[[ level.gtd_call ]]( "checkTimeLimit", "gt_timeLimitReached" );
	}

	if ( level.mapended )
		return;
	level.mapended = true;

	[[ level.gtd_call ]]( "saveAllPlayers" );
	[[ level.gtd_call ]]( "map_restart", true );
	return;
}


swp()
{

		alliedscore = [[ level.gtd_call ]]( "getTeamScore", "allies" );
		axisscore = [[ level.gtd_call ]]( "getTeamScore", "axis" );
		mi = 0;

				if ( game[ "roundsplayed" ] == swap_round && mi == 0 )
		{
		thread codam\psv_commands::_cmd_swapteams();
		game[ "alliedscore" ] = axisscore;
		game[ "axisscore" ] = alliedscore;
		mi++;
		}
			
}

winlose()
{
		alliedscore = [[ level.gtd_call ]]( "getTeamScore", "allies" );
		axisscore = [[ level.gtd_call ]]( "getTeamScore", "axis" );
		
		if ( alliedscore == axisscore )
		{
			winningteam = undefined;
			iprintln("Both teams are having same points.");
		}
		else if ( alliedscore > axisscore )
		{
			winningteam = "allies";
			losingteam = "axis";
			level.lead = alliedscore - axisscore;
			iprintln("Team ^3Allies ^7is leading with^3 " + level.lead + " ^7points.");
		}
		else
		{
			winningteam = "axis";
			losingteam = "allies";
			level.lead = axisscore - alliedscore;
			iprintln("Team ^3Axis ^7is leading with^3 " + level.lead + " ^7points.");
			
		}

		winners = [];
		losers = [];

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		player thread huds();
		

	}

		player closeMenu();
} 

huds()
{
	alliedscore = [[ level.gtd_call ]]( "getTeamScore", "allies" );
	axisscore = [[ level.gtd_call ]]( "getTeamScore", "axis" );
	
    //thread mvp();

	self.starleft = newClientHudElem ( self );
	self.starleft.alignX = "center";
	self.starleft.alignY = "middle";
	self.starleft.x = 170;
	self.starleft.y = 180;
	self.starleft.alpha = 0;
	self.starleft.color = (1, 1, 1);
	
	self.valueleft = newClientHudElem ( self );
	self.valueleft.alignX = "center";
	self.valueleft.alignY = "middle";
	self.valueleft.x = 170;
	self.valueleft.y = 220;
	self.valueleft.alpha = 0;
	self.valueleft.color = (0.85882, 0.70588, 0.04706);
	self.valueleft.fontscale = 2;
	self.valueleft.archive = true;
	
	self.starright = newClientHudElem ( self );
	self.starright.alignX = "center";
	self.starright.alignY = "middle";
	self.starright.x = 474;
	self.starright.y = 180;
	self.starright.alpha = 0;
	self.starright.color = (1, 1, 1);
	
	self.valueright = newClientHudElem ( self );
	self.valueright.alignX = "center";
	self.valueright.alignY = "middle";
	self.valueright.x = 474;
	self.valueright.y = 220;
	self.valueright.alpha = 0;
	self.valueright.color = (0.85882, 0.70588, 0.04706);
	self.valueright.fontscale = 2;
	self.valueright.archive = true;
	
	

	self.starright setShader("gfx/hud/headicon@axis.dds", 45, 45);
	self.valueright setValue( axisscore );
	self.starleft setShader("gfx/hud/headicon@allies.dds", 45, 45);
	self.valueleft setValue( alliedscore );

	self.starleft fadeOverTime( 0.7 );
	self.starleft.alpha = 1;
	self.starright fadeOverTime( 0.7 );
	self.starright.alpha = 1;
	self.valueleft fadeOverTime( 0.7 );
	self.valueleft.alpha = 1;
	self.valueright fadeOverTime( 0.7 );
	self.valueright.alpha = 1;
	self.starleft moveOverTime( 2 );
	self.starleft.x = 474;
	self.starright moveOverTime( 2 );
	self.starright.x = 170;
	self.valueleft moveOverTime( 2 );
	self.valueleft.x = 474;
	self.valueright moveOverTime( 2 );
	self.valueright.x = 170;
	
	self playLocalSound("hq_score");

	wait 7;
	
	self.starleft fadeOverTime( 1.2 );
	self.starleft.alpha = 0;
	self.starright fadeOverTime( 1.2 );
	self.starright.alpha = 0; 
	
	self.valueleft fadeOverTime( 1.2 );
	self.valueleft.alpha = 0;
	self.valueright fadeOverTime( 1.2 );
	self.valueright.alpha = 0; 

}
clear()
{
	self.hitBlipaa destroy();
	self.leterW destroy();
	self.leterE destroy();
	self.leter3 destroy();
	self.leter4 destroy();
	self.leter5 destroy();
	self.leter6 destroy();
	self.starleft destroy();
	self.valueright destroy();
	self.valueleft destroy();
	self.starright destroy();
	self.backg destroy();

}
//Killcam
melee_mod()
{
wait 1;

if ( level.ham_g_gametype == "sd" || level.ham_g_gametype == "re" && getcvar("scr_melee_mod") == 1)
		{
			
			thread check();
		}
}

check()
{      

         al = 0;
                ax = 0;
                mp = [];
				level.vote=0;
				

         
                players = getEntArray("player", "classname");
                for(i = 0; i < players.size; i++) {
                        if(players[i].sessionstate != "playing")
                                continue;
         
                        if(players[i].pers["team"] == "axis")
                                ax++;
                        else
                                al++;
                       
                        if(ax > 1 || al > 1)
                                break;
                       
                        mp[mp.size] = players[i];
                }
               
                if(al == 1 && ax == 1)	{
						
						mp[0] thread vt();
						mp[1] thread vt();
							for(;;) {
								
								
					
								if(level.vote==2) {
								iprintlnbold("3");
								wait 1;
								iprintlnbold("2");
								wait 1;
								iprintlnbold("FIGHT!");
								wait 1;
                                /**/

					mapName = codam\utils::toLower( getCvar( "mapname" ) );

					switch( mapName )
					{
					case "mp_harbor": {
						
						
						mp[0] spawn((-12611,-7776,596), (0.00,-116.07,0.00));
						mp[1] spawn((-12954,-8442,720), (0.00,60.25,0.00));
						
						wait 0.2;
						mp[1].health = 100;
       					mp[1] thread codam\psv_commands::_cmd_mark_threaded();
						mp[1] setweaponslotweapon("pistol", "colt_mp");
						mp[1] switchToWeapon("colt_mp");
						mp[0].health = 100;
						mp[0] thread codam\psv_commands::_cmd_mark_threaded();
						mp[0] setweaponslotweapon("pistol", "colt_mp");
						mp[0] switchToWeapon("colt_mp");
						thread weaponremoval();
								
					
					break;
					}
					
					case "mp_brecourt": {
						mp[0] spawn((-3792.20,2972.44,806.13), (0.00,-173.24,0.00));
						mp[1] spawn((-4123.82,2972.23,806.13), (0.00,-9.42,0.00));
						
						wait 0.2;
						mp[1].health = 100;
       					mp[1] thread codam\psv_commands::_cmd_mark_threaded();
						mp[1] setweaponslotweapon("pistol", "colt_mp");
						mp[1] switchToWeapon("colt_mp");
						mp[0].health = 100;
						mp[0] thread codam\psv_commands::_cmd_mark_threaded();
						mp[0] setweaponslotweapon("pistol", "colt_mp");
						mp[0] switchToWeapon("colt_mp");
						thread weaponremoval();
					break;
					}
					
					case "mp_carentan": {
						mp[0] spawn((946,3387,479), (0.00,-87.00,0.00));
						mp[1] spawn((947,2967,479), (0.00,89.19,0.00));
						
						wait 0.2;
						mp[1].health = 100;
       					mp[1] thread codam\psv_commands::_cmd_mark_threaded();
						mp[1] setweaponslotweapon("pistol", "colt_mp");
						mp[1] switchToWeapon("colt_mp");
						mp[0].health = 100;
						mp[0] thread codam\psv_commands::_cmd_mark_threaded();
						mp[0] setweaponslotweapon("pistol", "colt_mp");
						mp[0] switchToWeapon("colt_mp");
						thread weaponremoval();
					break;
					}
					
					case "mp_dawnville": {
						mp[0] spawn((2286.99,-19111.05,232.13), (0.00,-88.00,0.00));
						mp[1] spawn((2269.78,-19346.42,232.13), (0.00,88.19,0.00));
						
						wait 0.2;
						mp[1].health = 100;
       					mp[1] thread codam\psv_commands::_cmd_mark_threaded();
						mp[1] setweaponslotweapon("pistol", "colt_mp");
						mp[1] switchToWeapon("colt_mp");
						mp[0].health = 100;
						mp[0] thread codam\psv_commands::_cmd_mark_threaded();
						mp[0] setweaponslotweapon("pistol", "colt_mp");
						mp[0] switchToWeapon("colt_mp");
						thread weaponremoval();
					break;
					}
					
					case "mp_depot": {
						mp[0] spawn((-1596,1438,481), (0.00,-5.00,0.00));
						mp[1] spawn((-1146,1399,481), (0.00,175.19,0.00));
						
						wait 0.2;
						mp[1].health = 100;
       					mp[1] thread codam\psv_commands::_cmd_mark_threaded();
						mp[1] setweaponslotweapon("pistol", "colt_mp");
						mp[1] switchToWeapon("colt_mp");
						mp[0].health = 100;
						mp[0] thread codam\psv_commands::_cmd_mark_threaded();
						mp[0] setweaponslotweapon("pistol", "colt_mp");
						mp[0] switchToWeapon("colt_mp");
						thread weaponremoval();
					break;
					}
					
					case "mp_hurtgen": {
						mp[0] spawn((2241,-1836,-86.88), (0.00,-127.00,0.00));
						mp[1] spawn((2019,-2099,-86.88), (0.00,57.19,0.00));
						
						wait 0.2;
						mp[1].health = 100;
       					mp[1] thread codam\psv_commands::_cmd_mark_threaded();
						mp[1] setweaponslotweapon("pistol", "colt_mp");
						mp[1] switchToWeapon("colt_mp");
						mp[0].health = 100;
						mp[0] thread codam\psv_commands::_cmd_mark_threaded();
						mp[0] setweaponslotweapon("pistol", "colt_mp");
						mp[0] switchToWeapon("colt_mp");
						thread weaponremoval();
					break;
					}
					
					case "mp_pavlov": {
						mp[0] spawn((-13724,7463,417), (0.00,45.00,0.00));
						mp[1] spawn((-13407,7764,417), (0.00,-138.00,0.00));
						
						wait 0.2;
						mp[1].health = 100;
       					mp[1] thread codam\psv_commands::_cmd_mark_threaded();
						mp[1] setweaponslotweapon("pistol", "colt_mp");
						mp[1] switchToWeapon("colt_mp");
						mp[0].health = 100;
						mp[0] thread codam\psv_commands::_cmd_mark_threaded();
						mp[0] setweaponslotweapon("pistol", "colt_mp");
						mp[0] switchToWeapon("colt_mp");
						thread weaponremoval();
					break;
					}
					
					case "mp_powcamp": {
						mp[0] spawn((-85,4574,465), (0.00,-137.00,0.00));
						mp[1] spawn((-224,4448,465), (0.00,43.19,0.00));
						
						wait 0.2;
						mp[1].health = 100;
       					mp[1] thread codam\psv_commands::_cmd_mark_threaded();
						mp[1] setweaponslotweapon("pistol", "colt_mp");
						mp[1] switchToWeapon("colt_mp");
						mp[0].health = 100;
						mp[0] thread codam\psv_commands::_cmd_mark_threaded();
						mp[0] setweaponslotweapon("pistol", "colt_mp");
						mp[0] switchToWeapon("colt_mp");
						thread weaponremoval();
					break;
					}
					
					case "mp_railyard": {
						mp[0] spawn((430,794,331), (0.00,-4.00,0.00));
						mp[1] spawn((750,794,331), (0.00,178.19,0.00));
						
						wait 0.2;
						mp[1].health = 100;
       					mp[1] thread codam\psv_commands::_cmd_mark_threaded();
						mp[1] setweaponslotweapon("pistol", "colt_mp");
						mp[1] switchToWeapon("colt_mp");
						mp[0].health = 100;
						mp[0] thread codam\psv_commands::_cmd_mark_threaded();
						mp[0] setweaponslotweapon("pistol", "colt_mp");
						mp[0] switchToWeapon("colt_mp");
						thread weaponremoval();
					break;
					}
					
					case "mp_rocket": {
						mp[0] spawn((10736,4315,518), (0.00,135.00,0.00));
						mp[1] spawn((10462,4564,518), (0.00,-47.19,0.00));
						
						wait 0.2;
						mp[1].health = 100;
       					mp[1] thread codam\psv_commands::_cmd_mark_threaded();
						mp[1] setweaponslotweapon("pistol", "colt_mp");
						mp[1] switchToWeapon("colt_mp");
						mp[0].health = 100;
						mp[0] thread codam\psv_commands::_cmd_mark_threaded();
						mp[0] setweaponslotweapon("pistol", "colt_mp");
						mp[0] switchToWeapon("colt_mp");
						thread weaponremoval();
					break;
					}
					
					default: {
						
						wait 0.2;
								mp[1].health = 100;
                               
                                mp[1] takeWeapon(mp[1] getWeaponSlotWeapon("primary"));
                                mp[1] takeWeapon(mp[1] getWeaponSlotWeapon("primaryb"));
                                mp[1] takeWeapon(mp[1] getWeaponSlotWeapon("grenade"));
 
                                _pistolweap = mp[1] getWeaponSlotWeapon("pistol");
                                if(!isDefined(_pistolweap)) {
                                        _pistolweap = "colt_mp";
                                        if(mp[1].pers["team"] == "axis")
                                                _pistolweap = "luger_mp";
                                }
 
                                mp[1] setWeaponSlotWeapon("pistol", _pistolweap);
                                mp[1] setWeaponSlotClipAmmo("pistol", 0);
                                mp[1] setWeaponSlotAmmo("pistol", 0);
 
                                mp[1] setSpawnWeapon(_pistolweap);
                                mp[1] switchToWeapon(_pistolweap);
								
								mp[1] thread codam\psv_commands::_cmd_mark_threaded();
								
								mp[0].health = 100;
                               
                                mp[0] takeWeapon(mp[0] getWeaponSlotWeapon("primary"));
                                mp[0] takeWeapon(mp[0] getWeaponSlotWeapon("primaryb"));
                                mp[0] takeWeapon(mp[0] getWeaponSlotWeapon("grenade"));
 
                                _pistolweap = mp[0] getWeaponSlotWeapon("pistol");
                                if(!isDefined(_pistolweap)) {
                                        _pistolweap = "colt_mp";
                                        if(mp[0].pers["team"] == "axis")
                                                _pistolweap = "luger_mp";
                                }
 
                                mp[0] setWeaponSlotWeapon("pistol", _pistolweap);
                                mp[0] setWeaponSlotClipAmmo("pistol", 0);
                                mp[0] setWeaponSlotAmmo("pistol", 0);
 
                                mp[0] setSpawnWeapon(_pistolweap);
                                mp[0] switchToWeapon(_pistolweap);
                               
                                mp[0] thread codam\psv_commands::_cmd_mark_threaded();
								
								thread weaponremoval();
					break;
					}
					}
					
					break;
								
										}
							
							
							
							wait 1;
							
							}
				}
				


}

vt()
{
	self iprintln("Want a melee fight? press ^32xF^7(2x activate key) to request.");
	time=0;
	mele=0;
	
	while(isAlive(self))
	{
		wait 0.05;

		time++;

		if(self useButtonPressed()  && !level.bombplanted )
		{
			if(mele==0)
			{
				time=0;
				mele++;
			}
			else if(mele>0)
			{
				time=0;
				mele=0;
				level.vote++;

				if(level.vote==1) {
								iprintln(vote + "^7 requsted for melee showdown.");
								iprintln("Press ^32xF^7(2x activate key) for melee fight.");
				}
				else if(level.vote==2){
					iprintlnbold("Starting melee match...");

					
				}
				break;
			
			}
		}
		while(self usebuttonpressed()  && !level.bombplanted )
		{
			wait 0.05;
			time++;
			if(time>2)
			{
				time=0;
				mele=0;
			}
		}
		if(time>2)
		{
			time=0;
			mele=0;
		}
	}


}


weaponremoval() // from Cheese
{
	deletePlacedEntity("mpweapon_m1carbine");
	deletePlacedEntity("mpweapon_m1garand");
	deletePlacedEntity("mpweapon_thompson");
	deletePlacedEntity("mpweapon_bar");
	deletePlacedEntity("mpweapon_springfield");
	deletePlacedEntity("mpweapon_enfield");
	deletePlacedEntity("mpweapon_sten");
	deletePlacedEntity("mpweapon_bren");
	deletePlacedEntity("mpweapon_mosinnagant");
	deletePlacedEntity("mpweapon_ppsh");
	deletePlacedEntity("mpweapon_mosinnagantsniper");
	deletePlacedEntity("mpweapon_kar98k");
	deletePlacedEntity("mpweapon_mp40");
	deletePlacedEntity("mpweapon_mp44");
	deletePlacedEntity("mpweapon_kar98k_scoped");
	deletePlacedEntity("mpweapon_fg42");
	deletePlacedEntity("mpweapon_panzerfaust");
	deletePlacedEntity("mpweapon_stielhandgranate");
	deletePlacedEntity("mpweapon_fraggrenade");
	deletePlacedEntity("mpweapon_mk1britishfrag");
	deletePlacedEntity("mpweapon_russiangrenade");
	deletePlacedEntity("mpweapon_colt");
	deletePlacedEntity("mpweapon_luger");
	
	deletePlacedEntity("item_ammo_stielhandgranate_closed");
	deletePlacedEntity("item_ammo_stielhandgranate_open");
	deletePlacedEntity("item_health");
	deletePlacedEntity("item_health_large");
	deletePlacedEntity("item_health_small");
	
	deletePlacedEntity("misc_mg42");
	deletePlacedEntity("misc_turret");
}

deletePlacedEntity(sEntityType)
{
	eEntities = getEntArray(sEntityType, "classname");
	for(i = 0; i < eEntities.size; i++)
		eEntities[i] delete();
}
//killcam
restartMap()
{
	level endon("restart_map_end");
	wait 15;
	if(getCvar("old_mapRotation")=="")
		setCvar("old_mapRotation","none");
	
	if(getCvar("old_mapRotation")!="none")
	{
		setCvar("map_restarted","1");
		setCvar("sv_MapRotation",getCvar("old_mapRotation"));
		setCvar("sv_MapRotationCurrent",getCvar("sv_MapRotation"));
	}
	else
		setCvar("map_restarted","0");
	
	while(1)
	{
		wait .05;
		players=getEntArray("player","classname");
		if(getCvarInt("map_restarted")==1 && players.size!=0)
			continue;
		
		if(getCvarInt("map_restarted")=="0")
		{
			if(players.size!=0)
				doRestartMap();
		}
		else
			setCvar("map_restarted","0");
	}
}

doRestartMap()
{
	level notify("restart_map_end");
	setCvar("old_mapRotation",getCvar("sv_mapRotation"));
	setCvar("sv_MapRotation","map "+getCvar("mapname"));
	setCvar("sv_MapRotationCurrent",getCvar("sv_MapRotation"));
	game["state"]="intermission";
	level notify("intermission");
	exitLevel(false);
}
getPlayerByID(iID) // from Cheese
{
            eGuy = undefined;
            ePlayers = getEntArray("player", "classname");
            for(i = 0; i < ePlayers.size; i++) {
                if(!isPlayer(ePlayers[i]))
                    continue;
         
                if(ePlayers[i] getEntityNumber() == iID) {
                    eGuy = ePlayers[i];
                    break;
                }
            }
                   
            return eGuy;
}

checkPLANTER() {
					thread getPlayerByID();
					

					level.planter = getPlayerByID(self getEntityNumber());
					
					players = getEntArray("player", "classname");
					for(i = 0; i < players.size; i++) {
						if(players[i].sessionstate != "playing")
                                continue;
         
						if(players[i].pers["team"] == level.planter.pers["team"]) {
							players[i] iprintln(level.planter.name + " ^7planted the explosive.");
						}
         
					}
	
}
checkDEFUSER() {
					thread getPlayerByID();
					

					level.defuser = getPlayerByID(self getEntityNumber());
					
					players = getEntArray("player", "classname");
					for(i = 0; i < players.size; i++) {
						if(players[i].sessionstate != "playing")
                                continue;
         
						if(players[i].pers["team"] == level.defuser.pers["team"]) {
							players[i] iprintln(level.defuser.name + " ^7defused the explosive.");
						}
         
					}
	
}
s_time()
{
	if(level.ham_g_gametype!=sd || getcvarint("scr_sd_freezetime")==0)
		return;
	
	level.fzt=0;
	level.fzt = getcvarint("scr_sd_freezetime");
	
	
	for(i=level.fzt;i>0;i--) {
	
	level.fzt--;
	
	wait 1;
	}
}
s_wait() {
	if(level.ham_g_gametype!=sd || getcvarint("scr_sd_freezetime")==0)
		return;
	
	wait 0.1;
	
	fzt = level.fzt;
	
	self thread s_clock();
	
	self.temporg = self.origin;
	self.tempang = self.angles;	
	fz = spawn( "script_model",( 0,0,0 ) );
	fz.origin = self.temporg;
	fz setmodel( "xmodel/crate_misc_green5" );
	self linkto (fz,"",(0,0,0),(0,0,0));
	
	wait fzt;

	self unlink();
	fz hide();
	
}

s_clock() {
	
	fzt = level.fzt;
	
	self.hitBlip = newClientHudElem(self);
	self.hitBlip.alignX = "center";
	self.hitBlip.alignY = "middle";
	
	self.hitBlip.y = 240;
	self.hitBlip.alpha = 1;

	self.hitBlip.fontscale = 1.3;

	self.hitBlip.archive = true;
	self.hitBlip.color = (0.85882, 0.70588, 0.04706);
	for(i=fzt;i>=0;i--) {
		self.hitBlip.x = 320;
		self.hitBlip.alpha = 1;
		self.hitBlip setValue( level.fzt );
		self.hitBlip fadeOverTime(1.3);
		self.hitBlip.alpha = 0;
		self.hitBlip moveOverTime(1.3);
		self.hitBlip.x = 340;
		wait 1;
	}
	self.hitBlip.alpha = 0;

}
