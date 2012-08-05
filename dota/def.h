//
//  def.h
//  dota
//
//  Created by Scott Atkins on 7/31/12.
//  Copyright (c) 2012 Scott Atkins. All rights reserved.
//

#ifndef dota_def_h
#define dota_def_h

#define DOTA_APP_MAIN_TITLE @"Dota2 Stats"

#define DOTA_MATCH_REQUEST_STRING @"https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=%@"
#define DOTA_MATCH_PLAYER_SEARCH_REQUEST_STRING @"https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=%@&player_name=%@"
#define DOTA_MATCH_PLAYER_ACCOUNT_ID_REQUEST_STRING @"https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=%@&account_id=%@"

#define STEAM_PLAYER_SUMMARY_REQUEST_STRING @"http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=%@&steamids=%lld"

#define STEAM_DEV_KEY @"B3A7049A360B80408EEC3A9D97153AAF"

#define STEAM_ACCOUNT_HIGH_PART 76561197960265728L

#endif
