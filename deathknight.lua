local printTalentsMode = false

-- Slash command for printing talent tree with talent names and ID numbers
SLASH_CONROCPRINTTALENTS1 = "/ConROCPT"
SlashCmdList["CONROCPRINTTALENTS"] = function()
    printTalentsMode = not printTalentsMode
    ConROC:PopulateTalentIDs()
end

ConROC.DeathKnight = {};

local ConROC_DeathKnight, ids = ...;
local optionMaxIds = ...;
local currentSpecName
local useOpening = false;
local openingNo	= 0;
function ConROC:EnableDefenseModule()
	self.NextDef = ConROC.DeathKnight.Defense;
end

function ConROC:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConROC:PopulateTalentIDs()
    local numTabs = GetNumTalentTabs()
    
    for tabIndex = 1, numTabs do
        local tabName = GetTalentTabInfo(tabIndex) .. "_Talent"
        if printTalentsMode then
        	print(tabName..": ")
        else
        	ids[tabName] = {}
    	end
        
        local numTalents = GetNumTalents(tabIndex)

        for talentIndex = 1, numTalents do
            local name, _, _, _, _ = GetTalentInfo(tabIndex, talentIndex)

            if name then
                local talentID = string.gsub(name, "%s", "") -- Remove spaces from talent name
                if printTalentsMode then
                	print(talentID .." = ID no: ", talentIndex)
                else
                	ids[tabName][talentID] = talentIndex
                end
            end
        end
    end
    if printTalentsMode then printTalentsMode = false end
end
ConROC:PopulateTalentIDs()
local Racial, Spec, Blood_Ability, Blood_Talent, Frost_Ability, Frost_Talent, Unholy_Ability, Unholy_Talent, Player_Buff, Player_Debuff, Target_Debuff = ids.Racial, ids.Spec, ids.Blood_Ability, ids.Blood_Talent, ids.Frost_Ability, ids.Frost_Talent, ids.Unholy_Ability, ids.Unholy_Talent, ids.Player_Buff, ids.Player_Debuff, ids.Target_Debuff;	
--[[
	Talents is populated into a table with the names without spaces.
	so to target them in the table use Tablename.TalentName, an example:
	Blood_Talent.VeteranoftheThirdWar. This can then for example be used with the function
	ConROC:TalentChoosen(Spec.Blood, Blood_Talent.VeteranoftheThirdWar) that
	returns "true/false, currentRank, maxRank, name, tier" of the supplied talent
	To for example check how many points you have in a talent, that could have different buff ID
	for different ranks of the talent.
--]]
function ConROC:SpecUpdate() 
	currentSpecName = ConROC:currentSpec()

	if currentSpecName then
	   ConROC:Print(self.Colors.Info .. "Current spec:", self.Colors.Success ..  currentSpecName)
	else
	   ConROC:Print(self.Colors.Error .. "You do not currently have a spec.")
	end
end
ConROC:SpecUpdate();

--Presence
local _BloodPresence = Blood_Ability.BloodPresence;
local _FrostPresence = Frost_Ability.FrostPresence;
local _UnholyPresence = Unholy_Ability.UnholyPresence;

--Blood
local _BloodBoil = Blood_Ability.BloodBoilRank1;
local _BloodStrike = Blood_Ability.BloodStrikeRank1;
local _BloodTap = Blood_Ability.BloodTapRank1;
local _DancingRuneWeapon = Blood_Ability.DancingRuneWeaponRank1;
local _DarkCommand = Blood_Ability.DarkCommandRank1;
local _BloodDeathCoil = Blood_Ability.DeathCoilRank1;
local _DeathPact = Blood_Ability.DeathPactRank1;
local _HeartStrike = Blood_Ability.HeartStrikeRank1;
local _MarkofBlood = Blood_Ability.MarkofBloodRank1;
local _Pestilence = Blood_Ability.PestilenceRank1;
local _RuneTap = Blood_Ability.RuneTapRank1;
local _Strangulate = Blood_Ability.StrangulateRank1;
local _UnholyFrenzy = Blood_Ability.UnholyFrenzy;
local _VampiricBlood = Blood_Ability.VampiricBlood;

--Frost
local _ChainsofIce = Frost_Ability.ChainsofIceRank1;
local _EmpowerRuneWeapon = Frost_Ability.EmpowerRuneWeaponRank1;
local _FrozenRuneWeapon = Frost_Ability.FrozenRuneWeaponRank1;
local _FrostStrike = Frost_Ability.FrostStrikeRank1;
local _HornofWinter = Frost_Ability.HornofWinterRank1;
local _HowlingBlast = Frost_Ability.HowlingBlastRank1;
local _HungeringCold = Frost_Ability.HungeringColdRank1;
local _IceboundFortitude = Frost_Ability.IceboundFortitude;
local _IcyTouch = Frost_Ability.IcyTouchRank1;
local _Lichborne = Frost_Ability.LichborneRank1;
local _MindFreeze = Frost_Ability.MindFreezeRank1;
local _Obliterate = Frost_Ability.ObliterateRank1;
local _RuneStrike = Frost_Ability.RuneStrikeRank1;
local _UnbreakableArmor = Frost_Ability.UnbreakableArmorRank1;

--Unholy
local _AntiMagicShell = Unholy_Ability.AntiMagicShellRank1;
local _AntiMagicZone = Unholy_Ability.AntiMagicZoneRank1;
local _ArmyoftheDead = Unholy_Ability.ArmyoftheDeadRank1;
local _BoneShield = Unholy_Ability.BoneShieldRank1;
local _CorpseExplosion = Unholy_Ability.CorpseExplosionRank1;
local _DeathandDecay = Unholy_Ability.DeathandDecayRank1;
local _UnholyDeathCoil = Unholy_Ability.DeathCoilRank1;
local _DeathGrip = Unholy_Ability.DeathGripRank1;
local _DeathStrike = Unholy_Ability.DeathStrikeRank1;
local _GhoulFrenzy = Unholy_Ability.GhoulFrenzyRank1;
local _PlagueStrike = Unholy_Ability.PlagueStrikeRank1;
local _RaiseDead = Unholy_Ability.RaiseDeadRank1;
local _ScourgeStrike = Unholy_Ability.ScourgeStrikeRank1;
local _SummonGargoyle = Unholy_Ability.SummonGargoyle;

local _bloodrunes = 2;
local _unholyrunes = 2;
local _frostrunes = 2;
local _rundeCD = select(2, GetRuneCooldown(1));

function ConROC:UpdateSpellID()
--Ranks
	--Blood
	if IsSpellKnown(Blood_Ability.BloodBoilRank4) then _BloodBoil = Blood_Ability.BloodBoilRank4;
	elseif IsSpellKnown(Blood_Ability.BloodBoilRank3) then _BloodBoil = Blood_Ability.BloodBoilRank3; 
	elseif IsSpellKnown(Blood_Ability.BloodBoilRank2) then _BloodBoil = Blood_Ability.BloodBoilRank2; end
	
	if IsSpellKnown(Blood_Ability.BloodStrikeRank6) then _BloodStrike = Blood_Ability.BloodStrikeRank6;
	elseif IsSpellKnown(Blood_Ability.BloodStrikeRank5) then _BloodStrike = Blood_Ability.BloodStrikeRank5;
	elseif IsSpellKnown(Blood_Ability.BloodStrikeRank4) then _BloodStrike = Blood_Ability.BloodStrikeRank4;
	elseif IsSpellKnown(Blood_Ability.BloodStrikeRank3) then _BloodStrike = Blood_Ability.BloodStrikeRank3;
	elseif IsSpellKnown(Blood_Ability.BloodStrikeRank2) then _BloodStrike = Blood_Ability.BloodStrikeRank2; end	
	
	if IsSpellKnown(Blood_Ability.DeathCoilRank5) then _BloodDeathCoil = Blood_Ability.DeathCoilRank5;
	elseif IsSpellKnown(Blood_Ability.DeathCoilRank4) then _BloodDeathCoil = Blood_Ability.DeathCoilRank4;
	elseif IsSpellKnown(Blood_Ability.DeathCoilRank3) then _BloodDeathCoil = Blood_Ability.DeathCoilRank3;
	elseif IsSpellKnown(Blood_Ability.DeathCoilRank2) then _BloodDeathCoil = Blood_Ability.DeathCoilRank2; end
	
	if IsSpellKnown(Blood_Ability.HeartStrikeRank6) then _HeartStrike = Blood_Ability.HeartStrikeRank6;
	elseif IsSpellKnown(Blood_Ability.HeartStrikeRank5) then _HeartStrike = Blood_Ability.HeartStrikeRank5;
	elseif IsSpellKnown(Blood_Ability.HeartStrikeRank4) then _HeartStrike = Blood_Ability.HeartStrikeRank4;
	elseif IsSpellKnown(Blood_Ability.HeartStrikeRank3) then _HeartStrike = Blood_Ability.HeartStrikeRank3;
	elseif IsSpellKnown(Blood_Ability.HeartStrikeRank2) then _HeartStrike = Blood_Ability.HeartStrikeRank2; end	

	if IsSpellKnown(Blood_Ability.PestilenceRank5) then _Pestilence = Blood_Ability.PestilenceRank5;
	elseif IsSpellKnown(Blood_Ability.PestilenceRank4) then _Pestilence = Blood_Ability.PestilenceRank4;
	elseif IsSpellKnown(Blood_Ability.PestilenceRank3) then _Pestilence = Blood_Ability.PestilenceRank3;
	elseif IsSpellKnown(Blood_Ability.PestilenceRank2) then _Pestilence = Blood_Ability.PestilenceRank2; end
	
	--Frost
	if IsSpellKnown(Frost_Ability.FrostStrikeRank6) then _FrostStrike = Frost_Ability.FrostStrikeRank6;
	elseif IsSpellKnown(Frost_Ability.FrostStrikeRank5) then _FrostStrike = Frost_Ability.FrostStrikeRank5;
	elseif IsSpellKnown(Frost_Ability.FrostStrikeRank4) then _FrostStrike = Frost_Ability.FrostStrikeRank4;
	elseif IsSpellKnown(Frost_Ability.FrostStrikeRank3) then _FrostStrike = Frost_Ability.FrostStrikeRank3;
	elseif IsSpellKnown(Frost_Ability.FrostStrikeRank2) then _FrostStrike = Frost_Ability.FrostStrikeRank2; end

	if IsSpellKnown(Frost_Ability.HornofWinterRank2) then _HornofWinter = Frost_Ability.HornofWinterRank2; end	
	
	if IsSpellKnown(Frost_Ability.HowlingBlastRank4) then _HowlingBlast = Frost_Ability.HowlingBlastRank4;
	elseif IsSpellKnown(Frost_Ability.HowlingBlastRank3) then _HowlingBlast = Frost_Ability.HowlingBlastRank3;
	elseif IsSpellKnown(Frost_Ability.HowlingBlastRank2) then _HowlingBlast = Frost_Ability.HowlingBlastRank2; end	
	
	if IsSpellKnown(Frost_Ability.IcyTouchRank5) then _IcyTouch = Frost_Ability.IcyTouchRank5;
	elseif IsSpellKnown(Frost_Ability.IcyTouchRank4) then _IcyTouch = Frost_Ability.IcyTouchRank4;
	elseif IsSpellKnown(Frost_Ability.IcyTouchRank3) then _IcyTouch = Frost_Ability.IcyTouchRank3;
	elseif IsSpellKnown(Frost_Ability.IcyTouchRank2) then _IcyTouch = Frost_Ability.IcyTouchRank2; end
	
	if IsSpellKnown(Frost_Ability.ObliterateRank4) then _Obliterate = Frost_Ability.ObliterateRank4;
	elseif IsSpellKnown(Frost_Ability.ObliterateRank3) then _Obliterate = Frost_Ability.ObliterateRank3;
	elseif IsSpellKnown(Frost_Ability.ObliterateRank2) then _Obliterate = Frost_Ability.ObliterateRank2; end
	
	--Unholy
	if IsSpellKnown(Unholy_Ability.CorpseExplosionRank5) then _CorpseExplosion = Unholy_Ability.CorpseExplosionRank5;
	elseif IsSpellKnown(Unholy_Ability.CorpseExplosionRank4) then _CorpseExplosion = Unholy_Ability.CorpseExplosionRank4;
	elseif IsSpellKnown(Unholy_Ability.CorpseExplosionRank3) then _CorpseExplosion = Unholy_Ability.CorpseExplosionRank3;
	elseif IsSpellKnown(Unholy_Ability.CorpseExplosionRank2) then _CorpseExplosion = Unholy_Ability.CorpseExplosionRank2; end

	if IsSpellKnown(Unholy_Ability.DeathandDecayRank4) then _DeathandDecay = Unholy_Ability.DeathandDecayRank4;
	elseif IsSpellKnown(Unholy_Ability.DeathandDecayRank3) then _DeathandDecay = Unholy_Ability.DeathandDecayRank3;
	elseif IsSpellKnown(Unholy_Ability.DeathandDecayRank2) then _DeathandDecay = Unholy_Ability.DeathandDecayRank2; end
	
	if IsSpellKnown(Unholy_Ability.DeathCoilRank5) then _UnholyDeathCoil = Unholy_Ability.DeathCoilRank5;
	elseif IsSpellKnown(Unholy_Ability.DeathCoilRank4) then _UnholyDeathCoil = Unholy_Ability.DeathCoilRank4;
	elseif IsSpellKnown(Unholy_Ability.DeathCoilRank3) then _UnholyDeathCoil = Unholy_Ability.DeathCoilRank3;
	elseif IsSpellKnown(Unholy_Ability.DeathCoilRank2) then _UnholyDeathCoil = Unholy_Ability.DeathCoilRank2; end
	
	if IsSpellKnown(Unholy_Ability.DeathStrikeRank5) then _DeathStrike = Unholy_Ability.DeathStrikeRank5;
	elseif IsSpellKnown(Unholy_Ability.DeathStrikeRank4) then _DeathStrike = Unholy_Ability.DeathStrikeRank4;
	elseif IsSpellKnown(Unholy_Ability.DeathStrikeRank3) then _DeathStrike = Unholy_Ability.DeathStrikeRank3;
	elseif IsSpellKnown(Unholy_Ability.DeathStrikeRank2) then _DeathStrike = Unholy_Ability.DeathStrikeRank2; end
	
	if IsSpellKnown(Unholy_Ability.PlagueStrikeRank6) then _PlagueStrike = Unholy_Ability.PlagueStrikeRank6;
	elseif IsSpellKnown(Unholy_Ability.PlagueStrikeRank5) then _PlagueStrike = Unholy_Ability.PlagueStrikeRank5;
	elseif IsSpellKnown(Unholy_Ability.PlagueStrikeRank4) then _PlagueStrike = Unholy_Ability.PlagueStrikeRank4;
	elseif IsSpellKnown(Unholy_Ability.PlagueStrikeRank3) then _PlagueStrike = Unholy_Ability.PlagueStrikeRank3;
	elseif IsSpellKnown(Unholy_Ability.PlagueStrikeRank2) then _PlagueStrike = Unholy_Ability.PlagueStrikeRank2; end
	
	if IsSpellKnown(Unholy_Ability.ScourgeStrikeRank4) then _ScourgeStrike = Unholy_Ability.ScourgeStrikeRank4;
	elseif IsSpellKnown(Unholy_Ability.ScourgeStrikeRank3) then _ScourgeStrike = Unholy_Ability.ScourgeStrikeRank3;
	elseif IsSpellKnown(Unholy_Ability.ScourgeStrikeRank2) then _ScourgeStrike = Unholy_Ability.ScourgeStrikeRank2; end
	
ids.optionMaxIds = {
	--Blood
	BloodBoil = _BloodBoil,
	BloodStrike = _BloodStrike,
	BloodTap = _BloodTap,
	DancingRuneWeapon = _DancingRuneWeapon,
	DarkCommand = _DarkCommand,
	BloodDeathCoil = _BloodDeathCoil,
	DeathPact = _DeathPact,
	HeartStrike = _HeartStrike,
	MarkofBlood = _MarkofBlood,
	Pestilence = _Pestilence,
	RuneTap = _RuneTap,
	Strangulate = _Strangulate,
	UnholyFrenzy = _UnholyFrenzy,
	VampiricBlood = _VampiricBlood,
	--Frost
	ChainsofIce = _ChainsofIce,
	EmpowerRuneWeapon = _EmpowerRuneWeapon,
	FrozenRuneWeapon = _FrozenRuneWeapon,
	FrostStrike = _FrostStrike,
	HornofWinter = _HornofWinter,
	HowlingBlast = _HowlingBlast,
	HungeringCold = _HungeringCold,
	IceboundFortitude = _IceboundFortitude,
	IcyTouch = _IcyTouch,
	Lichborne = _Lichborne,
	MindFreeze = _MindFreeze,
	Obliterate = _Obliterate,
	RuneStrike = _RuneStrike,
	UnbreakableArmor = _UnbreakableArmor,
	--Unholy
	AntiMagicShell = _AntiMagicShell,
	AntiMagicZone = _AntiMagicZone,
	ArmyoftheDead = _ArmyoftheDead,
	BoneShield = _BoneShield,
	CorpseExplosion = _CorpseExplosion,
	DeathandDecay = _DeathandDecay,
	UnholyDeathCoil = _UnholyDeathCoil,
	DeathGrip = _DeathGrip,
	DeathStrike = _DeathStrike,
	GhoulFrenzy = _GhoulFrenzy,
	PlagueStrike = _PlagueStrike,
	RaiseDead = _RaiseDead,
	ScourgeStrike = _ScourgeStrike,
	SummonGargoyle = _SummonGargoyle
}
end
ConROC:UpdateSpellID()

function ConROC:EnableRotationModule()
	self.Description = 'DeathKnight';
	self.NextSpell = ConROC.DeathKnight.Damage;

	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self.lastSpellId = 0;
	
	ConROC:SpellmenuClass();
	--ConROCSpellmenuFrame:Hide();
	--ConROCToggleMover:Show()
	ConROCButtonFrame:Show()
end

function ConROC:PLAYER_TALENT_UPDATE()
	ConROC:SpecUpdate();
    ConROC:closeSpellmenu();
end
function ConROC.DeathKnight.Damage(_, timeShift, currentSpell, gcd)
ConROC:UpdateSpellID()
--Character
	local plvl 									= UnitLevel('player');
	
--Racials

--Resources
	local _Runes, br1, br2, ur1, ur2, fr1, fr2 	= dkrunes();
	--local _RunicPower, _RunicPower_Max = ConROC:PlayerPower('RunicPower');
	--local _Runes 								= UnitPower('player', Enum.PowerType.Runes);
	local _RunicPower 							= UnitPower('player', Enum.PowerType.RunicPower);
	local _RunicPower_Max 						= UnitPowerMax('player', Enum.PowerType.RunicPower);

--Presence
	local BloodPresence										= ConROC:BuffName(_BloodPresence, timeShift)
	local FrostPresence										= ConROC:BuffName(_FrostPresence, timeShift)
	local UnholyPresence									= ConROC:BuffName(_UnholyPresence, timeShift)
--Abilities
	local BloodBoilRDY		 								= ConROC:AbilityReady(_BloodBoil, timeShift);
		local inBBRange 										= ConROC:IsSpellInRange(_BloodBoil, 'target');
	local bStrikeRDY		 								= ConROC:AbilityReady(_BloodStrike, timeShift);
		local bStrikeDEBUFF		 								= ConROC:TargetDebuff(_BloodStrike, timeShift);	
	local bTapRDY		 									= ConROC:AbilityReady(_BloodTap, timeShift);
	local dRWRDY		 									= ConROC:AbilityReady(_DancingRuneWeapon, timeShift);
	local dCommandRDY										= ConROC:AbilityReady(_DarkCommand, timeShift);	
		local indCommandRange 									= ConROC:IsSpellInRange(_DarkCommand, 'target');
	local bDCoilRDY											= ConROC:AbilityReady(_BloodDeathCoil, timeShift);	
	local dPactRDY											= ConROC:AbilityReady(_DeathPact, timeShift);
	local hStrikeRDY		 								= ConROC:AbilityReady(_HeartStrike, timeShift);	
	local mofBlood											= ConROC:AbilityReady(_MarkofBlood, timeShift);
	local pestRDY											= ConROC:AbilityReady(_Pestilence, timeShift);
	local rTapRDY											= ConROC:AbilityReady(_RuneTap, timeShift);
	local strangRDY											= ConROC:AbilityReady(_Strangulate, timeShift);
	local uFrenzyRDY										= ConROC:AbilityReady(_UnholyFrenzy, timeShift);
		local uFrenzyRange 										= ConROC:IsSpellInRange(_UnholyFrenzy, 'target');
	local vBloodRDY											= ConROC:AbilityReady(_VampiricBlood, timeShift);
	
	local cIceRDY											= ConROC:AbilityReady(_ChainsofIce, timeShift);
	local eRWRDY											= ConROC:AbilityReady(_EmpowerRuneWeapon, timeShift);
	local fRWRDY											= ConROC:AbilityReady(_FrozenRuneWeapon, timeShift);
	local fStrikeRDY										= ConROC:AbilityReady(_FrostStrike, timeShift);
	local hornRDY											= ConROC:AbilityReady(_HornofWinter, timeShift);
		local hornBUFF											= ConROC:Buff(_HornofWinter, timeShift);
	if IsSpellKnown(_HowlingBlast) then
	local hBlastRDY											= ConROC:AbilityReady(_HowlingBlast, timeShift);
		local hBlastRange 										= ConROC:IsSpellInRange(_HowlingBlast, 'target');
		local tarInhBlast										= ConROC:Targets(_HowlingBlast);
	end
	local hColdRDY											= ConROC:AbilityReady(_HungeringCold, timeShift);
	local ibFortitudeRDY									= ConROC:AbilityReady(_IceboundFortitude, timeShift);
	local iTouchRDY											= ConROC:AbilityReady(_IcyTouch, timeShift);
		local iTouchDEBUFF										= ConROC:DebuffName(ids.Target_Debuff.FrostFever, timeShift);	
		local iTouchDur											= ConROC:TargetDebuffTime(ids.Target_Debuff.FrostFever, timeShift);	
	local lichborneRDY										= ConROC:AbilityReady(_Lichborne, timeShift);	
	local mFreezeRDY										= ConROC:AbilityReady(_MindFreeze, timeShift);
	local obliterateRDY										= ConROC:AbilityReady(_Obliterate, timeShift);
	local rStrikeRDY										= ConROC:AbilityReady(_RuneStrike, timeShift);
	local ubArmorRDY										= ConROC:AbilityReady(_UnbreakableArmor, timeShift);

	local amShellRDY										= ConROC:AbilityReady(_AntiMagicShell, timeShift);
	local amZoneRDY											= ConROC:AbilityReady(_AntiMagicZone, timeShift);
	local armyotDeadRDY										= ConROC:AbilityReady(_ArmyoftheDead, timeShift);
	local bShieldRDY										= ConROC:AbilityReady(_BoneShield, timeShift);
	--	local bShieldDEBUFF, bShieldCount						= ConROC:BuffName(_BoneShield, timeShift);	

	local cExplosionRDY										= ConROC:AbilityReady(_CorpseExplosion, timeShift);
	local dnDecayRDY										= ConROC:AbilityReady(_DeathandDecay, timeShift);
	local uDCoilRDY											= ConROC:AbilityReady(_UnholyDeathCoil, timeShift);
	local dGripRDY											= ConROC:AbilityReady(_DeathGrip, timeShift);
	local dStrikeRDY										= ConROC:AbilityReady(_DeathStrike, timeShift);
	local gFrenzyRDY										= ConROC:AbilityReady(_GhoulFrenzy, timeShift);
	local pStrikeRDY										= ConROC:AbilityReady(_PlagueStrike, timeShift);
		local pStrikeDEBUFF										= ConROC:DebuffName(ids.Target_Debuff.BloodPlague, timeShift);	
		local pStrikeDur										= ConROC:TargetDebuffTime(ids.Target_Debuff.BloodPlague, timeShift);	
	local raiseDeadRDY										= ConROC:AbilityReady(_RaiseDead, timeShift);
	local sStrikeRDY										= ConROC:AbilityReady(_ScourgeStrike, timeShift);
	local sGargoyleRDY										= ConROC:AbilityReady(_SummonGargoyle, timeShift);
--		local sArmorDEBUFF, sArmorCount							= ConROC:TargetDebuff(_SunderArmor, timeShift);	
--		local sArmorDEBUFF2		 								= ConROC:DebuffName(_SunderArmor, timeShift);	
--		local sArmorDUR											= sArmorEXP - GetTime();

--Talents	
	local hasSS												= ConROC:TalentChosen(Spec.Unholy, Unholy_Talent.ScourgeStrike)
--Conditions
	local hasKMBuff											= ConROC:BuffName(ids.Player_Buff.KillingMachine, timeShift);
	local hasRimeBuff										= ConROC:BuffName(ids.Player_Buff.FreezingFog, timeShift);
	local inStance											= GetShapeshiftForm();
	local summoned 											= ConROC:CallPet();
	local assist 											= ConROC:PetAssist();
	local incombat 											= UnitAffectingCombat('player');	
	local playerPh 											= ConROC:PercentHealth('player');
	local targetPh 											= ConROC:PercentHealth('target');
	local Close 											= CheckInteractDistance("target", 3);
	local tarInMelee										= 0;
	local tarInAoe											= 0;
	
	if IsSpellKnown(_PlagueStrike) then
		tarInMelee = ConROC:Targets(_PlagueStrike);
	elseif IsSpellKnown(_FrostStrike) then
		tarInMelee = ConROC:Targets(_FrostStrike);
	elseif IsSpellKnown(_BloodStrike) then
		tarInMelee = ConROC:Targets(_BloodStrike);
	end
	if ConROC_AoEButton:IsVisible() and IsSpellKnown(_BloodBoil) then
		tarInAoe = ConROC:Targets(_BloodBoil);
	end
--print(sArmorDUR); -- Still Testing Sunder Refresh Misses.
--Indicators
	ConROC:AbilityBurst(_SummonGargoyle, sGargoyleRDY);

	--print("_Runes",_Runes)
	if (br1 and br2) then
		_bloodrunes = 2;
	elseif(br1 or br2) then
		_bloodrunes = 1;
	else
		_bloodrunes = 0;
	end
	--print(_bloodrunes);
	if (ur1 and ur2) then
		_unholyrunes = 2;
	elseif(ur1 or ur2) then
		_unholyrunes = 1;
	else
		_unholyrunes = 0;
	end
	--print(_unholyrunes);
	if (fr1 and fr2) then
		_frostrunes = 2;
	elseif(fr1 or fr2) then
		_frostrunes = 1;
	else
		_frostrunes = 0;
	end
	--print(_frostrunes);

--Warnings
	if not assist and summoned and incombat then
		ConROC:Warnings("Pet is NOT attacking!!!", true);		
	end	
	
--Rotations
	if hornRDY and not hornBUFF and not incombat then
		return _HornofWinter
	end
	if currentSpecName == "Frost" then
		if not BloodPresence then
			return _BloodPresence
		end
		if ConROC_AoEButton:IsVisible() then
			if IsSpellKnown(_Pestilence) and pestRDY and (iTouchDEBUFF and pStrikeDEBUFF) then
				if ((iTouchDur or pStrikeDur) < 5) and (_bloodrunes > 0) then 
					return _Pestilence;
				else
					if (_bloodrunes == 2) then 
						return _BloodBoil;
					elseif (_bloodrunes == 1) and (_rundeCD < iTouchDur) and (_rundeCD < pStrikeDur) then  
						return _BloodBoil;
					end
				end
			end
			if IsSpellKnown(_HowlingBlast) and hBlastRDY and (iTouchDEBUFF and pStrikeDEBUFF) and ((iTouchDur or pStrikeDur) > 5) then
				return _HowlingBlast;
			end
			if IsSpellKnown(_IcyTouch) and iTouchRDY and not iTouchDEBUFF then
				--print("iTouchDEBUFF", iTouchDEBUFF);
				return _IcyTouch;
			end
			if IsSpellKnown(_PlagueStrike) and pStrikeRDY and not pStrikeDEBUFF then
				--print("_PlagueStrike");
				return _PlagueStrike;
			end
		else
			if IsSpellKnown(_HowlingBlast) and hBlastRDY and hasRimeBuff and (iTouchDEBUFF and pStrikeDEBUFF) and ((iTouchDur or pStrikeDur) > 5) then
				--print("_HowlingBlast");
				return _HowlingBlast;
			end

			if IsSpellKnown(_FrostStrike) and hasKMBuff and (_RunicPower >= 40) and fStrikeRDY and (iTouchDEBUFF and pStrikeDEBUFF) and ((iTouchDur or pStrikeDur) > 5) then
				--print("_FrostStrike");
				return _FrostStrike;
			end

			if IsSpellKnown(_Obliterate) and obliterateRDY and (iTouchDEBUFF and pStrikeDEBUFF) and ((iTouchDur or pStrikeDur) > 5) and ((_unholyrunes and _frostrunes ) >=1 ) then
				return _Obliterate;
			end
			
			if IsSpellKnown(_Pestilence) and pestRDY and (iTouchDEBUFF and pStrikeDEBUFF) then
					--print("iTouchDur", iTouchDur);
					--print("pStrikeDur", pStrikeDur);
				if ((iTouchDur or pStrikeDur) < 5) and (_bloodrunes > 0) then 
					return _Pestilence;
				else
					if (_RunicPower < 40) then 
						if (_bloodrunes == 2) then 
							return _BloodStrike;
						elseif (_bloodrunes == 1) and (_rundeCD < iTouchDur) and (_rundeCD < pStrikeDur) then  
							return _BloodStrike;
						end
					end
				end
			end

			if IsSpellKnown(_IcyTouch) and iTouchRDY and not iTouchDEBUFF then
				--print("iTouchDEBUFF", iTouchDEBUFF);
				return _IcyTouch;
			end
			if IsSpellKnown(_PlagueStrike) and pStrikeRDY and not pStrikeDEBUFF then
				--print("_PlagueStrike");
				return _PlagueStrike;
			end
			if IsSpellKnown(_FrostStrike) and (_RunicPower >= 40) then --and (iTouchDEBUFF and pStrikeDEBUFF) then
				--print("_FrostStrike to spend RP");
				return _FrostStrike;
			end
		end
	end

	if currentSpecName == "Blood" then
		if not FrostPresence then
			return _FrostPresence
		end
		if ConROC_AoEButton:IsVisible() then
			if IsSpellKnown(_DeathandDecay) and dnDecayRDY then
				return _DeathandDecay;
			end
			if IsSpellKnown(_IcyTouch) and iTouchRDY and not iTouchDEBUFF then
				--print("iTouchDEBUFF", iTouchDEBUFF);
				return _IcyTouch;
			end
			if IsSpellKnown(_PlagueStrike) and pStrikeRDY and not pStrikeDEBUFF then
				--print("_PlagueStrike");
				return _PlagueStrike;
			end
			if IsSpellKnown(_Pestilence) and pestRDY and (iTouchDEBUFF and pStrikeDEBUFF) then
				if ((iTouchDur or pStrikeDur) < 5) and (_bloodrunes > 0) then 
					return _Pestilence;
				else
					return _BloodBoil;
				end
			end
		else
			--[[if IsSpellKnown(_DeathGrip) and dGripRDY then
				return _DeathGrip;
			end--]]
			if IsSpellKnown(_IcyTouch) and iTouchRDY and not iTouchDEBUFF then
				return _IcyTouch;
			end
			if IsSpellKnown(_PlagueStrike) and pStrikeRDY and not pStrikeDEBUFF then
				return _PlagueStrike;
			end
			if IsSpellKnown(_Pestilence) and pestRDY and (iTouchDEBUFF and pStrikeDEBUFF) and ((iTouchDur or pStrikeDur) < 5) then
				return _Pestilence;
			end
			if IsSpellKnown(_DeathStrike) and dStrikeRDY then
				return _DeathStrike;
			end
			if dRWRDY then
				if ConROC:CheckBox(ConROC_SM_CD_UnholyFrenzy) and uFrenzyRDY then
					return _UnholyFrenzy
				elseif raiseDeadRDY then
					return RaiseDead
				else
					return DancingRuneWeapon
				end
			end
			if IsSpellKnown(_HeartStrike) and hStrikeRDY then
				return _HeartStrike
			end
			if IsSpellKnown(_DeathStrike) and dStrikeRDY then
				return _DeathStrike
			end
			if IsSpellKnown(_BloodTap) and bTapRDY then
				return _BloodTap;
			end
			if IsSpellKnown(_BloodDeathCoil) and bDCoilRDY and (_RunicPower >= 40) then
				return _BloodDeathCoil;
			end
			if IsSpellKnown(_IcyTouch) and iTouchRDY then
				return _IcyTouch;
			end
			if IsSpellKnown(_BloodStrike) and bStrikeRDY and not bStrikeDEBUFF then
				return _BloodStrike;
			end
			if IsSpellKnown(_EmpowerRuneWeapon) and eRWRDY then
				return _EmpowerRuneWeapon;
			end
			if IsSpellKnown(_Pestilence) and pestRDY and (iTouchDEBUFF and pStrikeDEBUFF) then
				if ((iTouchDur or pStrikeDur) < 5) and (_bloodrunes > 0) then 
					return _Pestilence;
				else
					return _IcyTouch;
				end
			end
		end
	end
	if currentSpecName == "Unholy" then
		if not incombat and iTouchRDY and pStrikeRDY and bStrikeRDY and sGargoyleRDY and ConROC:CheckBox(ConROC_SM_Option_PrePull) then
			useOpening = true
			openingNo = 0;
		else
			useOpening = false
		end
		if useOpening then
			if not UnholyPresence then
				return _UnholyPresence;
			end
			if (openingNo == 0) and IsSpellKnown(_PlagueStrike) and pStrikeRDY and not pStrikeDEBUFF then
				openingNo = 1
				return _PlagueStrike;
			end
			if (openingNo == 1) and IsSpellKnown(_IcyTouch) and iTouchRDY and not iTouchDEBUFF then
				openingNo = 2
				return _IcyTouch;
			end
			if (openingNo == 2) and IsSpellKnown(_BloodStrike) and bStrikeRDY and (_bloodrunes > 0) then
				if (_bloodrunes == 1) then
					openingNo = 3
				end
				return _BloodStrike
			end 
			if (openingNo == 3) and isSpellKnown(_BloodTap) and (_bloodrunes < 1) and bTapRDY then
				openingNo = 4
				return _BloodTap
			end
			if (openingNo == 4) and IsSpellKnown(_DeathandDecay) and dnDecayRDY then
				openingNo = 5
				return _DeathandDecay
			end
			if (openingNo == 5) and IsSpellKnown(_GhoulFrenzy) and gFrenzyRDY then
				openingNo = 6
				return _GhoulFrenzy
			end
			if (openingNo == 6) and IsSpellKnown(_SummonGargoyle) and sGargoyleRDY then
				openingNo = 7
				return _SummonGargoyle
			end
			if (openingNo == 7) and IsSpellKnown(_EmpowerRuneWeapon) and eRWRDY then
				openingNo = 8
				return _EmpowerRuneWeapon
			end
			if (openingNo == 8) and isSpellKnown(_BloodTap) and bTapRDY then
				openingNo = 9
				return _BloodTap
			end
			if (openingNo == 9) and isSpellKnown(_ArmyoftheDead) and armyotDeadRDY then
				openingNo = 10
				return _ArmyoftheDead
			end
			if (openingNo == 10) and not BloodPresence then
				useOpening = false
				return _BloodPresence;
			end
			return
		end

		if IsSpellKnown(_BloodTap) and (_bloodrunes == 0) and bTapRDY then
			return _BloodTap
		end
		if IsSpellKnown(_PlagueStrike) and pStrikeRDY and not pStrikeDEBUFF then
			return _PlagueStrike;
		end
		if IsSpellKnown(_IcyTouch) and iTouchRDY and not iTouchDEBUFF then
			return _IcyTouch;
		end
		if IsSpellKnown(_UnholyDeathCoil) and uDCoilRDY and (_RunicPower >= 40) then
			return _UnholyDeathCoil;
		end
		if IsSpellKnown(_BloodStrike) and bStrikeRDY and not bStrikeDEBUFF then
			return _BloodStrike;
		end
		if IsSpellKnown(_DeathandDecay) and dnDecayRDY then
			return _DeathandDecay
		end
		if IsSpellKnown(_ScourgeStrike) and sStrikeRDY and bStrikeDEBUFF and iTouchDEBUFF and pStrikeDEBUFF then
			return _ScourgeStrike;
		end		
		if IsSpellKnown(_BloodStrike) and bStrikeRDY then
			return _BloodStrike;
		end

	end
	return nil;
end

function ConROC.DeathKnight.Defense(_, timeShift, currentSpell, gcd, tChosen)
--Character
	local plvl 												= UnitLevel('player');
	
--Racials

--Ranks

	return nil;
end

function dkrunes()
	local _Runes = {
		rune1 = select(3, GetRuneCooldown(1)); --Blood
		rune2 = select(3, GetRuneCooldown(2));
		rune3 = select(3, GetRuneCooldown(3)); --Unholy
		rune4 = select(3, GetRuneCooldown(4));
		rune5 = select(3, GetRuneCooldown(5)); --Frost
		rune6 = select(3, GetRuneCooldown(6));
	}
	--print("_Runes.rune1",_Runes.rune1)
	local totalrunes = 0;
		for k, v in pairs(_Runes) do
			if v then
				totalrunes = totalrunes + 1;
			end
		end
	return totalrunes, _Runes.rune1, _Runes.rune2, _Runes.rune3, _Runes.rune4, _Runes.rune5, _Runes.rune6;
end

function ConROC:TargetDebuffTime(spellID, timeShift)
	timeShift = timeShift or 0;
	--print(select(1, GetSpellInfo(ids.Target_Debuff.FrostFever)))
	local spellName = GetSpellInfo(spellID);
	for i=1,16 do 
		local name, _, count, _, _, expirationTime, _, _, _, spell = UnitAura("target", i, 'HARMFUL');
		--print("name", name, "spellName", spellName)
		if name == spellName then
			if expirationTime ~= nil and (expirationTime - GetTime()) > timeShift then 
				local dur = expirationTime - GetTime() - (timeShift or 0);
				--print(name, "dur",dur)
				return dur;
			end 
		 end
	end
	return false, 0;
end