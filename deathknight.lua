ConROC.Warrior = {};

local ConROC_Warrior, ids = ...;

function ConROC:EnableRotationModule()
	self.Description = 'Warrior';
	self.NextSpell = ConROC.Warrior.Damage;

	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;
	
	ConROC:SpellmenuClass();
--	ConROCSpellmenuFrame:Hide();
end

function ConROC:EnableDefenseModule()
	self.NextDef = ConROC.Warrior.Defense;
end

function ConROC:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
	
	ConROC:JustSundered(spellID);
end

local Racial, Spec, Stance, Arms_Ability, Arms_Talent, Fury_Ability, Fury_Talent, Prot_Ability, Prot_Talent, Player_Buff, Player_Debuff, Target_Debuff = ids.Racial, ids.Spec, ids.Stance, ids.Arms_Ability, ids.Arms_Talent, ids.Fury_Ability, ids.Fury_Talent, ids.Prot_Ability, ids.Prot_Talent, ids.Player_Buff, ids.Player_Debuff, ids.Target_Debuff;	

--Arms
local _Charge = Arms_Ability.ChargeRank1;
local _Hamstring = Arms_Ability.HamstringRank1;
local _HeroicStrike = Arms_Ability.HeroicStrikeRank1;
local _MortalStrike = Arms_Ability.MortalStrikeRank1;
local _Overpower = Arms_Ability.OverpowerRank1;
local _Rend = Arms_Ability.RendRank1;

--Fury
local _BattleShout = Fury_Ability.BattleShoutRank1;
local _Bloodthirst = Fury_Ability.BloodthirstRank1;
local _Cleave = Fury_Ability.CleaveRank1;
local _Execute = Fury_Ability.ExecuteRank1;
local _Intercept = Fury_Ability.InterceptRank1;
local _Pummel = Fury_Ability.PummelRank1;
local _Slam = Fury_Ability.SlamRank1;

--Protection
local _Revenge = Prot_Ability.RevengeRank1;
local _ShieldBash = Prot_Ability.ShieldBashRank1;
local _ShieldSlam = Prot_Ability.ShieldSlamRank1;
local _SunderArmor = Prot_Ability.SunderArmorRank1;

local sArmorEXP = 0;
	
function ConROC.Warrior.Damage(_, timeShift, currentSpell, gcd)
--Character
	local plvl 												= UnitLevel('player');
	
--Racials

--Resources	
	local rage 												= UnitPower('player', Enum.PowerType.Rage);
	local rageMax 											= UnitPowerMax('player', Enum.PowerType.Rage);

--Ranks
	--Arms
	if IsSpellKnown(Arms_Ability.ChargeRank3) then _Charge = Arms_Ability.ChargeRank3;
	elseif IsSpellKnown(Arms_Ability.ChargeRank2) then _Charge = Arms_Ability.ChargeRank2; end
	
	if IsSpellKnown(Arms_Ability.HamstringRank3) then _Hamstring = Arms_Ability.HamstringRank3;
	elseif IsSpellKnown(Arms_Ability.HamstringRank2) then _Hamstring = Arms_Ability.HamstringRank2; end	
	
	if IsSpellKnown(Arms_Ability.HeroicStrikeRank9) then _HeroicStrike = Arms_Ability.HeroicStrikeRank9;
	elseif IsSpellKnown(Arms_Ability.HeroicStrikeRank8) then _HeroicStrike = Arms_Ability.HeroicStrikeRank8;
	elseif IsSpellKnown(Arms_Ability.HeroicStrikeRank7) then _HeroicStrike = Arms_Ability.HeroicStrikeRank7;
	elseif IsSpellKnown(Arms_Ability.HeroicStrikeRank6) then _HeroicStrike = Arms_Ability.HeroicStrikeRank6;
	elseif IsSpellKnown(Arms_Ability.HeroicStrikeRank5) then _HeroicStrike = Arms_Ability.HeroicStrikeRank5;
	elseif IsSpellKnown(Arms_Ability.HeroicStrikeRank4) then _HeroicStrike = Arms_Ability.HeroicStrikeRank4;
	elseif IsSpellKnown(Arms_Ability.HeroicStrikeRank3) then _HeroicStrike = Arms_Ability.HeroicStrikeRank3;
	elseif IsSpellKnown(Arms_Ability.HeroicStrikeRank2) then _HeroicStrike = Arms_Ability.HeroicStrikeRank2; end
	
	if IsSpellKnown(Arms_Ability.MortalStrikeRank4) then _MortalStrike = Arms_Ability.MortalStrikeRank4;
	elseif IsSpellKnown(Arms_Ability.MortalStrikeRank3) then _MortalStrike = Arms_Ability.MortalStrikeRank3;
	elseif IsSpellKnown(Arms_Ability.MortalStrikeRank2) then _MortalStrike = Arms_Ability.MortalStrikeRank2; end

	if IsSpellKnown(Arms_Ability.OverpowerRank4) then _Overpower = Arms_Ability.OverpowerRank4;
	elseif IsSpellKnown(Arms_Ability.OverpowerRank3) then _Overpower = Arms_Ability.OverpowerRank3;
	elseif IsSpellKnown(Arms_Ability.OverpowerRank2) then _Overpower = Arms_Ability.OverpowerRank2; end
	
	if IsSpellKnown(Arms_Ability.RendRank7) then _Rend = Arms_Ability.RendRank7;
	elseif IsSpellKnown(Arms_Ability.RendRank6) then _Rend = Arms_Ability.RendRank6;
	elseif IsSpellKnown(Arms_Ability.RendRank5) then _Rend = Arms_Ability.RendRank5;
	elseif IsSpellKnown(Arms_Ability.RendRank4) then _Rend = Arms_Ability.RendRank4;
	elseif IsSpellKnown(Arms_Ability.RendRank3) then _Rend = Arms_Ability.RendRank3;
	elseif IsSpellKnown(Arms_Ability.RendRank2) then _Rend = Arms_Ability.RendRank2; end
	
	--Fury
	if IsSpellKnown(Fury_Ability.BattleShoutRank7) then _BattleShout = Fury_Ability.BattleShoutRank7;
	elseif IsSpellKnown(Fury_Ability.BattleShoutRank6) then _BattleShout = Fury_Ability.BattleShoutRank6;
	elseif IsSpellKnown(Fury_Ability.BattleShoutRank5) then _BattleShout = Fury_Ability.BattleShoutRank5;
	elseif IsSpellKnown(Fury_Ability.BattleShoutRank4) then _BattleShout = Fury_Ability.BattleShoutRank4;
	elseif IsSpellKnown(Fury_Ability.BattleShoutRank3) then _BattleShout = Fury_Ability.BattleShoutRank3;
	elseif IsSpellKnown(Fury_Ability.BattleShoutRank2) then _BattleShout = Fury_Ability.BattleShoutRank2; end	
	
	if IsSpellKnown(Fury_Ability.BloodthirstRank4) then _Bloodthirst = Fury_Ability.BloodthirstRank4;
	elseif IsSpellKnown(Fury_Ability.BloodthirstRank3) then _Bloodthirst = Fury_Ability.BloodthirstRank3;
	elseif IsSpellKnown(Fury_Ability.BloodthirstRank2) then _Bloodthirst = Fury_Ability.BloodthirstRank2; end	
	
	if IsSpellKnown(Fury_Ability.CleaveRank5) then _Cleave = Fury_Ability.CleaveRank5;
	elseif IsSpellKnown(Fury_Ability.CleaveRank4) then _Cleave = Fury_Ability.CleaveRank4;
	elseif IsSpellKnown(Fury_Ability.CleaveRank3) then _Cleave = Fury_Ability.CleaveRank3;
	elseif IsSpellKnown(Fury_Ability.CleaveRank2) then _Cleave = Fury_Ability.CleaveRank2; end
	
	if IsSpellKnown(Fury_Ability.ExecuteRank5) then _Execute = Fury_Ability.ExecuteRank5;
	elseif IsSpellKnown(Fury_Ability.ExecuteRank4) then _Execute = Fury_Ability.ExecuteRank4;
	elseif IsSpellKnown(Fury_Ability.ExecuteRank3) then _Execute = Fury_Ability.ExecuteRank3;
	elseif IsSpellKnown(Fury_Ability.ExecuteRank2) then _Execute = Fury_Ability.ExecuteRank2; end
	
	if IsSpellKnown(Fury_Ability.InterceptRank3) then _Intercept = Fury_Ability.InterceptRank3;
	elseif IsSpellKnown(Fury_Ability.InterceptRank2) then _Intercept = Fury_Ability.InterceptRank2; end

	if IsSpellKnown(Fury_Ability.PummelRank2) then _Pummel = Fury_Ability.PummelRank2; end

	if IsSpellKnown(Fury_Ability.SlamRank4) then _Slam = Fury_Ability.SlamRank4;
	elseif IsSpellKnown(Fury_Ability.SlamRank3) then _Slam = Fury_Ability.SlamRank3;
	elseif IsSpellKnown(Fury_Ability.SlamRank2) then _Slam = Fury_Ability.SlamRank2; end
	
	--Protection
	if IsSpellKnown(Prot_Ability.RevengeRank6) then _Revenge = Prot_Ability.RevengeRank6;
	elseif IsSpellKnown(Prot_Ability.RevengeRank5) then _Revenge = Prot_Ability.RevengeRank5;
	elseif IsSpellKnown(Prot_Ability.RevengeRank4) then _Revenge = Prot_Ability.RevengeRank4;
	elseif IsSpellKnown(Prot_Ability.RevengeRank3) then _Revenge = Prot_Ability.RevengeRank3;
	elseif IsSpellKnown(Prot_Ability.RevengeRank2) then _Revenge = Prot_Ability.RevengeRank2; end
	
	if IsSpellKnown(Prot_Ability.ShieldBashRank3) then _ShieldBash = Prot_Ability.ShieldBashRank3;
	elseif IsSpellKnown(Prot_Ability.ShieldBashRank2) then _ShieldBash = Prot_Ability.ShieldBashRank2; end
	
	if IsSpellKnown(Prot_Ability.ShieldSlamRank4) then _ShieldSlam = Prot_Ability.ShieldSlamRank4;
	elseif IsSpellKnown(Prot_Ability.ShieldSlamRank3) then _ShieldSlam = Prot_Ability.ShieldSlamRank3;
	elseif IsSpellKnown(Prot_Ability.ShieldSlamRank2) then _ShieldSlam = Prot_Ability.ShieldSlamRank2; end
	
	if IsSpellKnown(Prot_Ability.SunderArmorRank5) then _SunderArmor = Prot_Ability.SunderArmorRank5;
	elseif IsSpellKnown(Prot_Ability.SunderArmorRank4) then _SunderArmor = Prot_Ability.SunderArmorRank4;
	elseif IsSpellKnown(Prot_Ability.SunderArmorRank3) then _SunderArmor = Prot_Ability.SunderArmorRank3;
	elseif IsSpellKnown(Prot_Ability.SunderArmorRank2) then _SunderArmor = Prot_Ability.SunderArmorRank2; end
	
--Abilities
	local chargeRDY		 									= ConROC:AbilityReady(_Charge, timeShift);
		local inChRange 										= ConROC:IsSpellInRange(_Charge, 'target');
	local hstringRDY		 								= ConROC:AbilityReady(_Hamstring, timeShift);
		local hstringDEBUFF		 								= ConROC:DebuffName(_Hamstring, timeShift);	
	local hStrikeRDY		 								= ConROC:AbilityReady(_HeroicStrike, timeShift);
	local mStrikeRDY		 								= ConROC:AbilityReady(_MortalStrike, timeShift);
	local oPowerRDY											= ConROC:AbilityReady(_Overpower, timeShift);	
	local sStrikesRDY										= ConROC:AbilityReady(Arms_Ability.SweepingStrikes, timeShift);	
	local rendRDY											= ConROC:AbilityReady(_Rend, timeShift);
		local rendDEBUFF		 								= ConROC:TargetDebuff(_Rend, timeShift);
		
	local batShoutRDY		 								= ConROC:AbilityReady(_BattleShout, timeShift);	
		local batShoutBUFF		 								= ConROC:BuffName(_BattleShout, timeShift);
	local bThirstRDY, bthirstCD								= ConROC:AbilityReady(_Bloodthirst, timeShift);
		local bThirstBUFF										= ConROC:Buff(_Bloodthirst, timeShift);
	local cleaveRDY											= ConROC:AbilityReady(_Cleave, timeShift);
	local dWishRDY											= ConROC:AbilityReady(Fury_Ability.DeathWish, timeShift);
	local exeRDY											= ConROC:AbilityReady(_Execute, timeShift);
	local interRDY											= ConROC:AbilityReady(_Intercept, timeShift);
		local interRange 										= ConROC:IsSpellInRange(_Intercept, 'target');
	local iShoutRDY											= ConROC:AbilityReady(Fury_Ability.IntimidatingShout, timeShift);
	local pHowlRDY											= ConROC:AbilityReady(Fury_Ability.PiercingHowl, timeShift);
		local pHowlDEBUFF		 								= ConROC:DebuffName(Fury_Ability.PiercingHowl, timeShift);	
	local pummelRDY											= ConROC:AbilityReady(_Pummel, timeShift);
	local reckRDY											= ConROC:AbilityReady(Fury_Ability.Recklessness, timeShift);
	local slamRDY											= ConROC:AbilityReady(_Slam, timeShift);
	local wwRDY												= ConROC:AbilityReady(Fury_Ability.Whirlwind, timeShift);
	
	local bRageRDY											= ConROC:AbilityReady(Prot_Ability.Bloodrage, timeShift);
	local cBlowRDY											= ConROC:AbilityReady(Prot_Ability.ConcussionBlow, timeShift);
	local revengeRDY										= ConROC:AbilityReady(_Revenge, timeShift);
	local sBashRDY											= ConROC:AbilityReady(_ShieldBash, timeShift);	
	local sSlamRDY											= ConROC:AbilityReady(_ShieldSlam, timeShift);	
	local sArmorRDY											= ConROC:AbilityReady(_SunderArmor, timeShift);
		local sArmorDEBUFF, sArmorCount							= ConROC:TargetDebuff(_SunderArmor, timeShift);	
		local sArmorDEBUFF2		 								= ConROC:DebuffName(_SunderArmor, timeShift);	
		local sArmorDUR											= sArmorEXP - GetTime();
	local batStanceRDY 										= ConROC:AbilityReady(Arms_Ability.BattleStance, timeShift);
	local defStanceRDY 										= ConROC:AbilityReady(Prot_Ability.DefensiveStance, timeShift);
	local berStanceRDY 										= ConROC:AbilityReady(Fury_Ability.BerserkerStance, timeShift);

--Conditions
	local inStance											= GetShapeshiftForm();
	local incombat 											= UnitAffectingCombat('player');	
	local playerPh 											= ConROC:PercentHealth('player');
	local targetPh 											= ConROC:PercentHealth('target');
	local Close 											= CheckInteractDistance("target", 3);
	local tarInMelee										= 0;
	
	if IsSpellKnown(_Rend) then
		tarInMelee = ConROC:Targets(_Rend);
	end
--print(sArmorDUR); -- Still Testing Sunder Refresh Misses.
--Indicators		
	ConROC:AbilityMovement(_Charge, chargeRDY and inChRange and not incombat and inStance == Stance.Battle);
	ConROC:AbilityMovement(_Intercept, interRDY and interRange and inStance == Stance.Berserker);
	ConROC:AbilityTaunt(_HeroicStrike, ConROC:CheckBox(ConROC_SM_Rage_HeroicStrike) and hStrikeRDY and rage >= 30 and ((tarInMelee >= 1 and not ConROC:CheckBox(ConROC_SM_Rage_Cleave)) or (tarInMelee == 1 and ConROC:CheckBox(ConROC_SM_Rage_Cleave)))); --Felt looks better then Burst.
	ConROC:AbilityTaunt(_Cleave, ConROC:CheckBox(ConROC_SM_Rage_Cleave) and cleaveRDY and rage >= 40 and tarInMelee >= 2);
	
	ConROC:AbilityBurst(Arms_Ability.SweepingStrikes, sStrikesRDY and inStance == Stance.Battle and tarInMelee >= 2);
	ConROC:AbilityBurst(Fury_Ability.DeathWish, dWishRDY and incombat and not ConROC:TarYou());
	ConROC:AbilityBurst(Fury_Ability.Recklessness, reckRDY and incombat and not ConROC:TarYou() and ((not ConROC:TalentChosen(Spec.Fury, Fury_Talent.DeathWish)) or (ConROC:TalentChosen(Spec.Fury, Fury_Talent.DeathWish) and dWishRDY)));
	
--Warnings	
	
--Rotations	
	if ConROC:CheckBox(ConROC_SM_Shout_BattleShout) and batShoutRDY and not batShoutBUFF then
		return _BattleShout;
	end
	
	if ConROC:CheckBox(ConROC_SM_Shout_Bloodrage) and bRageRDY and rage <= 75 and playerPh >= 70 and incombat then
		return Prot_Ability.Bloodrage;
	end
	
	if ConROC:CheckBox(ConROC_SM_Debuff_SunderArmor) and sArmorRDY and sArmorDEBUFF and sArmorDUR <= 6 then
		return _SunderArmor;
	end

	if wwRDY and tarInMelee >= 3 and inStance == Stance.Berserker then
		return Fury_Ability.Whirlwind;
	end	
	
	if exeRDY and targetPh <= 20 and inStance == (Stance.Battle or Stance.Berserker) then
		return _Execute;
	end
	
	if oPowerRDY and inStance == Stance.Battle then
		return _Overpower;
	end
	
	if revengeRDY and inStance == Stance.Defensive then
		return _Revenge;
	end	
	
	if bThirstRDY then
		return _Bloodthirst;
	end		
	
	if ConROC:TalentChosen(Spec.Fury, Fury_Talent.Bloodthirst) then
		if wwRDY and bthirstCD > 2 and inStance == Stance.Berserker then
			return Fury_Ability.Whirlwind;
		end	
	else
		if wwRDY and inStance == Stance.Berserker then
			return Fury_Ability.Whirlwind;
		end
	end

	if sSlamRDY and ConROC:Equipped('Shields', 'SECONDARYHANDSLOT') then
		return _ShieldSlam;
	end
	
	if mStrikeRDY then
		return _MortalStrike;
	end
	
	if ConROC:CheckBox(ConROC_SM_Debuff_Rend) and rendRDY and not rendDEBUFF and inStance == (Stance.Battle or Stance.Defensive) and not (ConROC:CreatureType('Mechanical') or ConROC:CreatureType('Elemental') or ConROC:CreatureType('Undead')) then
		return _Rend;
	end
	
	if ConROC:CheckBox(ConROC_SM_Debuff_SunderArmor) and sArmorRDY and (not sArmorDEBUFF2 or sArmorCount < ConROC_SM_Debuff_SunderArmorCount:GetNumber()) and rage >= 30 then
		return _SunderArmor;
	end
	
	if ConROC:CheckBox(ConROC_SM_Stun_PiercingHowl) and pHowlRDY and not pHowlDEBUFF and not hstringDEBUFF and tarInMelee >= 2 then
		return Fury_Ability.PiercingHowl;
	end
	
	if ConROC:CheckBox(ConROC_SM_Stun_Hamstring) and hstringRDY and not hstringDEBUFF and not pHowlDEBUFF and inStance == (Stance.Battle or Stance.Berserker) then
		return _Hamstring;
	end
	
	if ConROC:CheckBox(ConROC_SM_Stun_ConcussionBlow) and cBlowRDY then
		return Prot_Ability.ConcussionBlow;
	end

	if ConROC:CheckBox(ConROC_SM_Rage_Cleave) and cleaveRDY and rage >= 85 and tarInMelee >= 2 then
		return _Cleave;
	end	
	
	if ConROC:CheckBox(ConROC_SM_Rage_Slam) and slamRDY and not ConROC:TarYou() then
		return _Slam;
	end		

	if ConROC:CheckBox(ConROC_SM_Rage_HeroicStrike) and hStrikeRDY and rage >= 85 and ((tarInMelee >= 1 and not ConROC:CheckBox(ConROC_SM_Rage_Cleave)) or (tarInMelee == 1 and ConROC:CheckBox(ConROC_SM_Rage_Cleave))) then
		return _HeroicStrike;
	end	

	return nil;
end

function ConROC.Warrior.Defense(_, timeShift, currentSpell, gcd, tChosen)
--Character
	local plvl 												= UnitLevel('player');
	
--Racials

--Ranks
	--Arms
	local _MockingBlow = Arms_Ability.MockingBlowRank1;
	local _ThunderClap = Arms_Ability.ThunderClapRank1;
	
	if IsSpellKnown(Arms_Ability.MockingBlowRank5) then _MockingBlow = Arms_Ability.MockingBlowRank5;
	elseif IsSpellKnown(Arms_Ability.MockingBlowRank4) then _MockingBlow = Arms_Ability.MockingBlowRank4;
	elseif IsSpellKnown(Arms_Ability.MockingBlowRank3) then _MockingBlow = Arms_Ability.MockingBlowRank3;
	elseif IsSpellKnown(Arms_Ability.MockingBlowRank2) then _MockingBlow = Arms_Ability.MockingBlowRank2; end	

	if IsSpellKnown(Arms_Ability.ThunderClapRank6) then _ThunderClap = Arms_Ability.ThunderClapRank6;
	elseif IsSpellKnown(Arms_Ability.ThunderClapRank5) then _ThunderClap = Arms_Ability.ThunderClapRank5;
	elseif IsSpellKnown(Arms_Ability.ThunderClapRank4) then _ThunderClap = Arms_Ability.ThunderClapRank4;
	elseif IsSpellKnown(Arms_Ability.ThunderClapRank3) then _ThunderClap = Arms_Ability.ThunderClapRank3;
	elseif IsSpellKnown(Arms_Ability.ThunderClapRank2) then _ThunderClap = Arms_Ability.ThunderClapRank2; end

	--Fury
	local _DemoralizingShout = Fury_Ability.DemoralizingShoutRank1;

	if IsSpellKnown(Fury_Ability.DemoralizingShoutRank5) then _DemoralizingShout = Fury_Ability.DemoralizingShoutRank5;
	elseif IsSpellKnown(Fury_Ability.DemoralizingShoutRank4) then _DemoralizingShout = Fury_Ability.DemoralizingShoutRank4;
	elseif IsSpellKnown(Fury_Ability.DemoralizingShoutRank3) then _DemoralizingShout = Fury_Ability.DemoralizingShoutRank3;
	elseif IsSpellKnown(Fury_Ability.DemoralizingShoutRank2) then _DemoralizingShout = Fury_Ability.DemoralizingShoutRank2; end
	
--Resources	
	local rage 												= UnitPower('player', Enum.PowerType.Rage);
	local rageMax 											= UnitPowerMax('player', Enum.PowerType.Rage);
	
--Abilities	
	local mBlowRDY		 									= ConROC:AbilityReady(_MockingBlow, timeShift);
	local retalRDY											= ConROC:AbilityReady(Arms_Ability.Retaliation, timeShift);
	local tclapRDY											= ConROC:AbilityReady(_ThunderClap, timeShift);	
		local tclapDEBUFF		 								= ConROC:TargetDebuff(_ThunderClap, timeShift);	
		
	local berRageRDY										= ConROC:AbilityReady(Fury_Ability.BerserkerRage, timeShift);
	local cShoutRDY											= ConROC:AbilityReady(Fury_Ability.ChallengingShout, timeShift);
	local dShoutRDY											= ConROC:AbilityReady(_DemoralizingShout, timeShift);
		local dShoutDEBUFF										= ConROC:DebuffName(_DemoralizingShout);
		local dRoarDEBUFF										= ConROC:DebuffName(99); --Demoralizing Roar
		
	local disarmRDY											= ConROC:AbilityReady(Prot_Ability.Disarm, timeShift);
	local lStandRDY											= ConROC:AbilityReady(Prot_Ability.LastStand, timeShift);
	local sBlockRDY											= ConROC:AbilityReady(Prot_Ability.ShieldBlock, timeShift);
		local sBlockBUFF										= ConROC:Buff(Prot_Ability.ShieldBlock, timeShift);
	local sWallRDY											= ConROC:AbilityReady(Prot_Ability.ShieldWall, timeShift);
	local tauntRDY											= ConROC:AbilityReady(Prot_Ability.Taunt, timeShift);
			
--Conditions	
	local playerPh 											= ConROC:PercentHealth('player');
	local inStance											= GetShapeshiftForm();
	local tarInMelee										= 0;
	local incombat 											= UnitAffectingCombat('player');
	
	if IsSpellKnown(Prot_Ability.Taunt) then
		tarInMelee = ConROC:Targets(Prot_Ability.Taunt);
	end
	
--Indicators	
	ConROC:AbilityTaunt(Prot_Ability.Taunt, ConROC:CheckBox(ConROC_SM_Role_Tank) and tauntRDY and inStance == Stance.Defensive and not ConROC:TarYou());
	ConROC:AbilityTaunt(_MockingBlow, ConROC:CheckBox(ConROC_SM_Role_Tank) and mBlowRDY and inStance == Stance.Battle);
	ConROC:AbilityTaunt(Fury_Ability.ChallengingShout, ConROC:CheckBox(ConROC_SM_Role_Tank) and cShoutRDY and tarInMelee >= 3);
	
--Rotations	
	if lStandRDY and incombat and playerPh <= 35 then
		return Prot_Ability.LastStand;
	end

	if sWallRDY and inStance == Stance.Defensive and playerPh <= 25 and ConROC:Equipped('Shields', 'SECONDARYHANDSLOT') then
		return Prot_Ability.ShieldWall;
	end
	
	if sBlockRDY and not sBlockBUFF and inStance == Stance.Defensive then
		return Prot_Ability.ShieldBlock;
	end
	
	if ConROC:CheckBox(ConROC_SM_Debuff_ThunderClap) and tclapRDY and not tclapDEBUFF and inStance == Stance.Battle then
		return _ThunderClap;
	end

	if berRageRDY and inStance == Stance.Berserker then
		return Fury_Ability.BerserkerRage;
	end
	
	if ConROC:CheckBox(ConROC_SM_Shout_DemoralizingShout) and dShoutRDY and not (dShoutDEBUFF or dRoarDEBUFF) then
		return _DemoralizingShout;
	end
	
	if retalRDY and incombat and inStance == Stance.Battle and not ConROC:Equipped('Shields', 'SECONDARYHANDSLOT') then
		return Arms_Ability.Retaliation;
	end
	
	return nil;
end

function ConROC:JustSundered(spellID)
	if spellID == _SunderArmor then
		local expTime = GetTime() + 30;
		sArmorEXP = expTime;
	end
end
