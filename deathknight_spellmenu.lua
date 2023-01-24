local ConROC_Warrior, ids = ...;

local lastFrame = 0;
local lastDebuff = 0;
local lastRage = 0;
local lastStun = 0;

local plvl = UnitLevel('player');

local defaults = {
	["ConROC_SM_Role_Melee"] = true,

	["ConROC_Melee_Shout_BattleShout"] = true,
	["ConROC_Melee_Shout_Bloodrage"] = true,	
	["ConROC_Melee_Debuff_Rend"] = true,
	["ConROC_Melee_Debuff_ThunderClap"] = true,
	["ConROC_Melee_Debuff_SunderArmor"] = true,
	["ConROC_Tank_Debuff_SunderArmorCount"] = 5,
	["ConROC_Melee_Debuff_SunderArmorCount"] = 5,
	["ConROC_PvP_Debuff_SunderArmorCount"] = 5,
	["ConROC_Melee_Shout_DemoralizingShout"] = true,
	
	["ConROC_Melee_Rage_HeroicStrike"] = true,
	["ConROC_Melee_Rage_Cleave"] = true,
	["ConROC_Melee_Rage_Slam"] = true,
		
}


ConROCWarriorSpells = ConROCWarriorSpells or defaults;

function ConROC:SpellmenuClass()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCSpellmenuClass", ConROCSpellmenuFrame)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 30) --30 with Roles turned on. 1 when off.
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCSpellmenuFrame_Title", "BOTTOM", 0, 0)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)
		
	--Tank
		local radio1 = CreateFrame("CheckButton", "ConROC_SM_Role_Tank", frame, "UIRadioButtonTemplate");
		local radio1text = frame:CreateFontString(radio1, "ARTWORK", "GameFontRedSmall");
			radio1:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -10);
			radio1:SetChecked(ConROCWarriorSpells.ConROC_SM_Role_Tank);
			radio1:SetScript("OnClick",
				function()
					ConROC_SM_Role_Tank:SetChecked(true);
					ConROC_SM_Role_Melee:SetChecked(false);
					ConROC_SM_Role_PvP:SetChecked(false);
					ConROCWarriorSpells.ConROC_SM_Role_Tank = ConROC_SM_Role_Tank:GetChecked();
					ConROCWarriorSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCWarriorSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile()
				end
			);
			radio1text:SetText("Tank");				
		local r1t = radio1.texture;
			if not r1t then
				r1t = radio1:CreateTexture('Spellmenu_radio1_Texture', 'ARTWORK');
				r1t:SetTexture('Interface\\AddOns\\ConROC\\images\\shield2');
				r1t:SetBlendMode('BLEND');
				local color = ConROC.db.profile.defenseOverlayColor;
				r1t:SetVertexColor(color.r, color.g, color.b);				
				radio1.texture = r1t;
			end			
			r1t:SetScale(0.2);
			r1t:SetPoint("CENTER", radio1, "CENTER", 0, 0);
			radio1text:SetPoint("BOTTOM", radio1, "TOP", 0, 5);
		
	--Melee
		local radio2 = CreateFrame("CheckButton", "ConROC_SM_Role_Melee", frame, "UIRadioButtonTemplate");
		local radio2text = frame:CreateFontString(radio2, "ARTWORK", "GameFontRedSmall");		
			radio2:SetPoint("LEFT", radio1, "RIGHT", 18, 0);
			radio2:SetChecked(ConROCWarriorSpells.ConROC_SM_Role_Melee);
			radio2:SetScript("OnClick", 
				function()
					ConROC_SM_Role_Tank:SetChecked(false);
					ConROC_SM_Role_Melee:SetChecked(true);
					ConROC_SM_Role_PvP:SetChecked(false);
					ConROCWarriorSpells.ConROC_SM_Role_Tank = ConROC_SM_Role_Tank:GetChecked();
					ConROCWarriorSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCWarriorSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile()
				end
			);
			radio2text:SetText("Melee");					
		local r2t = radio2.texture; 
			if not r2t then
				r2t = radio2:CreateTexture('Spellmenu_radio2_Texture', 'ARTWORK');
				r2t:SetTexture('Interface\\AddOns\\ConROC\\images\\bigskull');
				r2t:SetBlendMode('BLEND');
				radio2.texture = r2t;
			end			
			r2t:SetScale(0.2);
			r2t:SetPoint("CENTER", radio2, "CENTER", 0, 0);
			radio2text:SetPoint("BOTTOM", radio2, "TOP", 0, 5);

	--PvP
		local radio4 = CreateFrame("CheckButton", "ConROC_SM_Role_PvP", frame, "UIRadioButtonTemplate");
		local radio4text = frame:CreateFontString(radio4, "ARTWORK", "GameFontRedSmall");
			radio4:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -15, -10);
			radio4:SetChecked(ConROCWarriorSpells.ConROC_SM_Role_PvP);
			radio4:SetScript("OnClick", 
			  function()
					ConROC_SM_Role_Melee:SetChecked(false);
					ConROC_SM_Role_Tank:SetChecked(false);
					ConROC_SM_Role_PvP:SetChecked(true);
					ConROCWarriorSpells.ConROC_SM_Role_Melee = ConROC_SM_Role_Melee:GetChecked();
					ConROCWarriorSpells.ConROC_SM_Role_Tank = ConROC_SM_Role_Tank:GetChecked();
					ConROCWarriorSpells.ConROC_SM_Role_PvP = ConROC_SM_Role_PvP:GetChecked();
					ConROC:RoleProfile()
				end
			);
			radio4text:SetText("PvP");					
		local r4t = radio4.texture;

			if not r4t then
				r4t = radio4:CreateTexture('Spellmenu_radio4_Texture', 'ARTWORK');
				r4t:SetTexture('Interface\\AddOns\\ConROC\\images\\lightning-interrupt');
				r4t:SetBlendMode('BLEND');				
				radio4.texture = r4t;
			end			
			r4t:SetScale(0.2);
			r4t:SetPoint("CENTER", radio4, "CENTER", 0, 0);
			radio4text:SetPoint("BOTTOM", radio4, "TOP", 0, 5);
			

		frame:Hide()
		lastFrame = frame;
	
	ConROC:CheckHeader1();
	ConROC:CheckHeader2();
	ConROC:CheckHeader3();
end

function ConROC:CheckHeader1()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckHeader1", ConROCSpellmenuClass)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 10)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		local fontAuras = frame:CreateFontString("ConROC_Spellmenu_CheckHeader1", "ARTWORK", "GameFontGreenSmall");
			fontAuras:SetText("Shouts and Debuffs");
			fontAuras:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_CheckFrame1_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				obutton:SetSize(12, 12)
				obutton:Hide()
				obutton:SetAlpha(1)
				
				obutton:SetText("v")
				obutton:SetNormalFontObject("GameFontHighlightSmall")

			local ohtex = obutton:CreateTexture()
				ohtex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				ohtex:SetTexCoord(0, 0.625, 0, 0.6875)
				ohtex:SetAllPoints()
				obutton:SetHighlightTexture(ohtex)

				obutton:SetScript("OnMouseUp", function (self, obutton, up)
					self:Hide();
					ConROCCheckFrame1:Show();
					ConROC_CheckFrame1_CloseButton:Show();
					ConROC:SpellMenuUpdate();
				end)

			local tbutton = CreateFrame("Button", 'ConROC_CheckFrame1_CloseButton', frame)
				tbutton:SetFrameStrata('MEDIUM')
				tbutton:SetFrameLevel('6')
				tbutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				tbutton:SetSize(12, 12)
				tbutton:Show()
				tbutton:SetAlpha(1)
				
				tbutton:SetText("^")
				tbutton:SetNormalFontObject("GameFontHighlightSmall")

			local htex = tbutton:CreateTexture()
				htex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				htex:SetTexCoord(0, 0.625, 0, 0.6875)
				htex:SetAllPoints()
				tbutton:SetHighlightTexture(htex)
				
				tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
					self:Hide();
					ConROCCheckFrame1:Hide();
					ConROC_CheckFrame1_OpenButton:Show();
					ConROC:SpellMenuUpdate();
				end)		
		
		frame:Show();
		lastFrame = frame;
		
	ConROC:CheckFrame1();
end

function ConROC:CheckFrame1()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckFrame1", ConROCCheckHeader1)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 5)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCCheckHeader1", "BOTTOM", 0, 0)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		lastDebuff = frame;
		lastFrame = frame;
		
	--Battle Shout
		local c1tspellName, _, c1tspell = GetSpellInfo(ids.Fury_Ability.BattleShoutRank1);
		local check1 = CreateFrame("CheckButton", "ConROC_SM_Shout_BattleShout", frame, "UICheckButtonTemplate");
		local check1text = frame:CreateFontString(check1, "ARTWORK", "GameFontHighlightSmall");		
			check1:SetPoint("TOP", ConROCCheckFrame1, "BOTTOM", -150, 0);
			check1:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				check1:SetChecked(ConROCWarriorSpells.ConROC_Tank_Shout_BattleShout);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check1:SetChecked(ConROCWarriorSpells.ConROC_Melee_Shout_BattleShout);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check1:SetChecked(ConROCWarriorSpells.ConROC_PvP_Shout_BattleShout);
			end
			check1:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCWarriorSpells.ConROC_Tank_Shout_BattleShout = ConROC_SM_Shout_BattleShout:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCWarriorSpells.ConROC_Melee_Shout_BattleShout = ConROC_SM_Shout_BattleShout:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarriorSpells.ConROC_PvP_Shout_BattleShout = ConROC_SM_Shout_BattleShout:GetChecked();
					end
				end);
			check1text:SetText(c1tspellName);				
		local c1t = check1.texture;
		 
			if not c1t then
				c1t = check1:CreateTexture('CheckFrame1_check1_Texture', 'ARTWORK');
				c1t:SetTexture(c1tspell);
				c1t:SetBlendMode('BLEND');
				check1.texture = c1t;
			end			
			c1t:SetScale(0.4);
			c1t:SetPoint("LEFT", check1, "RIGHT", 8, 0);
			check1text:SetPoint('LEFT', c1t, 'RIGHT', 5, 0);
			
		lastDebuff = check1;
		lastFrame = check1;

	--Rend
		local c2tspellName, _, c2tspell = GetSpellInfo(ids.Arms_Ability.RendRank1);
		local check2 = CreateFrame("CheckButton", "ConROC_SM_Debuff_Rend", frame, "UICheckButtonTemplate");
		local check2text = frame:CreateFontString(check2, "ARTWORK", "GameFontHighlightSmall");		
			check2:SetPoint("TOP", ConROCCheckFrame1, "BOTTOM", -150, 0);
			check2:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				check2:SetChecked(ConROCWarriorSpells.ConROC_Tank_Debuff_Rend);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check2:SetChecked(ConROCWarriorSpells.ConROC_Melee_Debuff_Rend);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check2:SetChecked(ConROCWarriorSpells.ConROC_PvP_Debuff_Rend);
			end
			check2:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCWarriorSpells.ConROC_Tank_Debuff_Rend = ConROC_SM_Debuff_Rend:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCWarriorSpells.ConROC_Melee_Debuff_Rend = ConROC_SM_Debuff_Rend:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarriorSpells.ConROC_PvP_Debuff_Rend = ConROC_SM_Debuff_Rend:GetChecked();
					end
				end);
			check2text:SetText(c2tspellName);				
		local c2t = check2.texture;
		 
			if not c2t then
				c2t = check2:CreateTexture('CheckFrame1_check2_Texture', 'ARTWORK');
				c2t:SetTexture(c2tspell);
				c2t:SetBlendMode('BLEND');
				check2.texture = c2t;
			end			
			c2t:SetScale(0.4);
			c2t:SetPoint("LEFT", check2, "RIGHT", 8, 0);
			check2text:SetPoint('LEFT', c2t, 'RIGHT', 5, 0);
			
		lastDebuff = check2;
		lastFrame = check2;
		
	--Thunder Clap
		local c3tspellName, _, c3tspell = GetSpellInfo(ids.Arms_Ability.ThunderClapRank1);
		local check3 = CreateFrame("CheckButton", "ConROC_SM_Debuff_ThunderClap", frame, "UICheckButtonTemplate");
		local check3text = frame:CreateFontString(check3, "ARTWORK", "GameFontHighlightSmall");		
			check3:SetPoint("TOP", ConROCCheckFrame1, "BOTTOM", -150, 0);
			check3:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				check3:SetChecked(ConROCWarriorSpells.ConROC_Tank_Debuff_ThunderClap);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check3:SetChecked(ConROCWarriorSpells.ConROC_Melee_Debuff_ThunderClap);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check3:SetChecked(ConROCWarriorSpells.ConROC_PvP_Debuff_ThunderClap);
			end
			check3:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCWarriorSpells.ConROC_Tank_Debuff_ThunderClap = ConROC_SM_Debuff_ThunderClap:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCWarriorSpells.ConROC_Melee_Debuff_ThunderClap = ConROC_SM_Debuff_ThunderClap:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarriorSpells.ConROC_PvP_Debuff_ThunderClap = ConROC_SM_Debuff_ThunderClap:GetChecked();
					end
				end);
			check3text:SetText(c3tspellName);				
		local c3t = check3.texture;
		 
			if not c3t then
				c3t = check3:CreateTexture('CheckFrame1_check3_Texture', 'ARTWORK');
				c3t:SetTexture(c3tspell);
				c3t:SetBlendMode('BLEND');
				check3.texture = c3t;
			end			
			c3t:SetScale(0.4);
			c3t:SetPoint("LEFT", check3, "RIGHT", 8, 0);
			check3text:SetPoint('LEFT', c3t, 'RIGHT', 5, 0);
			
		lastDebuff = check3;
		lastFrame = check3;

	--Sunder Armor
		local c4tspellName, _, c4tspell = GetSpellInfo(ids.Prot_Ability.SunderArmorRank1);
		local check4 = CreateFrame("CheckButton", "ConROC_SM_Debuff_SunderArmor", frame, "UICheckButtonTemplate");
		check4:SetPoint("TOP", ConROCCheckFrame1, "BOTTOM", -150, 0);
		check4:SetScale(.50);	
		
		if ConROC:CheckBox(ConROC_SM_Role_Tank) then
			check4:SetChecked(ConROCWarriorSpells.ConROC_Tank_Debuff_SunderArmor);
		elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
			check4:SetChecked(ConROCWarriorSpells.ConROC_Melee_Debuff_SunderArmor);
		elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
			check4:SetChecked(ConROCWarriorSpells.ConROC_PvP_Debuff_SunderArmor);
		end
		
		check4:SetScript("OnClick", 
			function()
				if ConROC:CheckBox(ConROC_SM_Role_Tank) then
					ConROCWarriorSpells.ConROC_Tank_Debuff_SunderArmor = ConROC_SM_Debuff_SunderArmor:GetChecked();
				elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
					ConROCWarriorSpells.ConROC_Melee_Debuff_SunderArmor = ConROC_SM_Debuff_SunderArmor:GetChecked();
				elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
					ConROCWarriorSpells.ConROC_PvP_Debuff_SunderArmor = ConROC_SM_Debuff_SunderArmor:GetChecked();
				end
			end);
		
		local c4t = check4:CreateTexture('CheckFrame1_check4_Texture', 'ARTWORK');
		c4t:SetTexture(c4tspell);
		c4t:SetBlendMode('BLEND');
		c4t:SetScale(0.4);
		c4t:SetPoint("LEFT", check4, "RIGHT", 8, 0);

		local check4text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
		check4text:SetText(c4tspellName);
		check4text:SetPoint('LEFT', c4t, 'RIGHT', 5, 0);

	--Sunder Armor Count
		local edit1 = CreateFrame("Frame", "ConROC_SM_Debuff_SunderArmorCount_Frame", frame);
		edit1:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", tile = true, tileSize = 16, insets = {left = 0, right = 0, top = 0, bottom = 0},});
		edit1:SetBackdropColor(0, 0, 0);
		edit1:SetPoint("LEFT", check4text, "RIGHT", 8, 0);
		edit1:SetSize(15, 15);
		
		local box1 = CreateFrame("EditBox", "ConROC_SM_Debuff_SunderArmorCount", edit1);	
		box1:SetPoint("TOP", 0, 0);
		box1:SetPoint("BOTTOM", 0, 0);
		box1:SetMultiLine(false);
		box1:SetFontObject(GameFontNormalSmall);
		box1:SetNumeric(true);
		box1:SetAutoFocus(false);
		box1:SetMaxLetters("1");
		box1:SetWidth(20);
		box1:SetTextInsets(3, 0, 0, 0);	
		
		if ConROC:CheckBox(ConROC_SM_Role_Tank) then
			box1:SetNumber(ConROCWarriorSpells.ConROC_Tank_Debuff_SunderArmorCount or 5);
		elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
			box1:SetNumber(ConROCWarriorSpells.ConROC_Melee_Debuff_SunderArmorCount or 5);
		elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
			box1:SetNumber(ConROCWarriorSpells.ConROC_PvP_Debuff_SunderArmorCount or 5);
		end		

		box1:SetScript("OnEditFocusLost", 
			function()
				if ConROC:CheckBox(ConROC_SM_Role_Tank) then
					ConROCWarriorSpells.ConROC_Tank_Debuff_SunderArmorCount = ConROC_SM_Debuff_SunderArmorCount:GetNumber();
				elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
					ConROCWarriorSpells.ConROC_Melee_Debuff_SunderArmorCount = ConROC_SM_Debuff_SunderArmorCount:GetNumber();
				elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
					ConROCWarriorSpells.ConROC_PvP_Debuff_SunderArmorCount = ConROC_SM_Debuff_SunderArmorCount:GetNumber();
				end
				box1:ClearFocus()
			end);
		box1:SetScript("OnEnterPressed", 
			function()
				if ConROC:CheckBox(ConROC_SM_Role_Tank) then
					ConROCWarriorSpells.ConROC_Tank_Debuff_SunderArmorCount = ConROC_SM_Debuff_SunderArmorCount:GetNumber();
				elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
					ConROCWarriorSpells.ConROC_Melee_Debuff_SunderArmorCount = ConROC_SM_Debuff_SunderArmorCount:GetNumber();
				elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
					ConROCWarriorSpells.ConROC_PvP_Debuff_SunderArmorCount = ConROC_SM_Debuff_SunderArmorCount:GetNumber();
				end
				box1:ClearFocus()
			end);
		box1:SetScript("OnEscapePressed", 
			function()
				if ConROC:CheckBox(ConROC_SM_Role_Tank) then
					ConROCWarriorSpells.ConROC_Tank_Debuff_SunderArmorCount = ConROC_SM_Debuff_SunderArmorCount:GetNumber();
				elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
					ConROCWarriorSpells.ConROC_Melee_Debuff_SunderArmorCount = ConROC_SM_Debuff_SunderArmorCount:GetNumber();
				elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
					ConROCWarriorSpells.ConROC_PvP_Debuff_SunderArmorCount = ConROC_SM_Debuff_SunderArmorCount:GetNumber();
				end
				box1:ClearFocus()
			end);

		lastDebuff = check4;
		lastFrame = check4;			

	--Bloodrage
		local c5tspellName, _, c5tspell = GetSpellInfo(ids.Prot_Ability.Bloodrage);
		local check5 = CreateFrame("CheckButton", "ConROC_SM_Shout_Bloodrage", frame, "UICheckButtonTemplate");
		local check5text = frame:CreateFontString(check5, "ARTWORK", "GameFontHighlightSmall");		
			check5:SetPoint("TOP", ConROCCheckFrame1, "BOTTOM", -150, 0);
			check5:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				check5:SetChecked(ConROCWarriorSpells.ConROC_Tank_Shout_Bloodrage);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check5:SetChecked(ConROCWarriorSpells.ConROC_Melee_Shout_Bloodrage);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check5:SetChecked(ConROCWarriorSpells.ConROC_PvP_Shout_Bloodrage);
			end
			check5:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCWarriorSpells.ConROC_Tank_Shout_Bloodrage = ConROC_SM_Shout_Bloodrage:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCWarriorSpells.ConROC_Melee_Shout_Bloodrage = ConROC_SM_Shout_Bloodrage:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarriorSpells.ConROC_PvP_Shout_Bloodrage = ConROC_SM_Shout_Bloodrage:GetChecked();
					end
				end);
			check5text:SetText(c5tspellName);				
		local c5t = check5.texture;
		 
			if not c5t then
				c5t = check5:CreateTexture('CheckFrame1_check5_Texture', 'ARTWORK');
				c5t:SetTexture(c5tspell);
				c5t:SetBlendMode('BLEND');
				check5.texture = c5t;
			end			
			c5t:SetScale(0.4);
			c5t:SetPoint("LEFT", check5, "RIGHT", 8, 0);
			check5text:SetPoint('LEFT', c5t, 'RIGHT', 5, 0);
			
		lastDebuff = check5;
		lastFrame = check5;
		
	--Demoralizing Shout
		local c6tspellName, _, c6tspell = GetSpellInfo(ids.Fury_Ability.DemoralizingShoutRank1);
		local check6 = CreateFrame("CheckButton", "ConROC_SM_Shout_DemoralizingShout", frame, "UICheckButtonTemplate");
		local check6text = frame:CreateFontString(check6, "ARTWORK", "GameFontHighlightSmall");		
			check6:SetPoint("TOP", ConROCCheckFrame1, "BOTTOM", -150, 0);
			check6:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				check6:SetChecked(ConROCWarriorSpells.ConROC_Tank_Shout_DemoralizingShout);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check6:SetChecked(ConROCWarriorSpells.ConROC_Melee_Shout_DemoralizingShout);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check6:SetChecked(ConROCWarriorSpells.ConROC_PvP_Shout_DemoralizingShout);
			end
			check6:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCWarriorSpells.ConROC_Tank_Shout_DemoralizingShout = ConROC_SM_Shout_DemoralizingShout:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCWarriorSpells.ConROC_Melee_Shout_DemoralizingShout = ConROC_SM_Shout_DemoralizingShout:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarriorSpells.ConROC_PvP_Shout_DemoralizingShout = ConROC_SM_Shout_DemoralizingShout:GetChecked();
					end
				end);
			check6text:SetText(c6tspellName);
		local c6t = check6.texture;
		 
			if not c6t then
				c6t = check6:CreateTexture('CheckFrame1_check6_Texture', 'ARTWORK');
				c6t:SetTexture(c6tspell);
				c6t:SetBlendMode('BLEND');
				check6.texture = c6t;
			end			
			c6t:SetScale(0.4);
			c6t:SetPoint("LEFT", check6, "RIGHT", 8, 0);
			check6text:SetPoint('LEFT', c6t, 'RIGHT', 5, 0);
			
		lastDebuff = check6;
		lastFrame = check6;
		
		frame:Show()
end

function ConROC:CheckHeader2()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckHeader2", ConROCSpellmenuClass)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 10)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		local fontAuras = frame:CreateFontString("ConROC_Spellmenu_CheckHeader2", "ARTWORK", "GameFontGreenSmall");
			fontAuras:SetText("Rage Dump");
			fontAuras:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_CheckFrame2_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				obutton:SetSize(12, 12)
				obutton:Hide()
				obutton:SetAlpha(1)
				
				obutton:SetText("v")
				obutton:SetNormalFontObject("GameFontHighlightSmall")

			local ohtex = obutton:CreateTexture()
				ohtex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				ohtex:SetTexCoord(0, 0.625, 0, 0.6875)
				ohtex:SetAllPoints()
				obutton:SetHighlightTexture(ohtex)

				obutton:SetScript("OnMouseUp", function (self, obutton, up)
					self:Hide();
					ConROCCheckFrame2:Show();
					ConROC_CheckFrame2_CloseButton:Show();
					ConROC:SpellMenuUpdate();
				end)

			local tbutton = CreateFrame("Button", 'ConROC_CheckFrame2_CloseButton', frame)
				tbutton:SetFrameStrata('MEDIUM')
				tbutton:SetFrameLevel('6')
				tbutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				tbutton:SetSize(12, 12)
				tbutton:Show()
				tbutton:SetAlpha(1)
				
				tbutton:SetText("^")
				tbutton:SetNormalFontObject("GameFontHighlightSmall")

			local htex = tbutton:CreateTexture()
				htex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				htex:SetTexCoord(0, 0.625, 0, 0.6875)
				htex:SetAllPoints()
				tbutton:SetHighlightTexture(htex)
				
				tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
					self:Hide();
					ConROCCheckFrame2:Hide();
					ConROC_CheckFrame2_OpenButton:Show();
					ConROC:SpellMenuUpdate();
				end)		
		
		frame:Show();
		lastFrame = frame;
		
	ConROC:CheckFrame2();
end

function ConROC:CheckFrame2()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckFrame2", ConROCCheckHeader2)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 5)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCCheckHeader2", "BOTTOM", 0, 0)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		lastRage = frame;
		lastFrame = frame;
		
	--Heroic Strike
		local c1tspellName, _, c1tspell = GetSpellInfo(ids.Arms_Ability.HeroicStrikeRank1);
		local check1 = CreateFrame("CheckButton", "ConROC_SM_Rage_HeroicStrike", frame, "UICheckButtonTemplate");
		local check1text = frame:CreateFontString(check1, "ARTWORK", "GameFontHighlightSmall");		
			check1:SetPoint("TOP", ConROCCheckFrame2, "BOTTOM", -150, 0);
			check1:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				check1:SetChecked(ConROCWarriorSpells.ConROC_Tank_Rage_HeroicStrike);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check1:SetChecked(ConROCWarriorSpells.ConROC_Melee_Rage_HeroicStrike);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check1:SetChecked(ConROCWarriorSpells.ConROC_PvP_Rage_HeroicStrike);
			end
			check1:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCWarriorSpells.ConROC_Tank_Rage_HeroicStrike = ConROC_SM_Rage_HeroicStrike:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCWarriorSpells.ConROC_Melee_Rage_HeroicStrike = ConROC_SM_Rage_HeroicStrike:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarriorSpells.ConROC_PvP_Rage_HeroicStrike = ConROC_SM_Rage_HeroicStrike:GetChecked();
					end
				end);
			check1text:SetText(c1tspellName);				
		local c1t = check1.texture;
		 
			if not c1t then
				c1t = check1:CreateTexture('CheckFrame2_check1_Texture', 'ARTWORK');
				c1t:SetTexture(c1tspell);
				c1t:SetBlendMode('BLEND');
				check1.texture = c1t;
			end			
			c1t:SetScale(0.4);
			c1t:SetPoint("LEFT", check1, "RIGHT", 8, 0);
			check1text:SetPoint('LEFT', c1t, 'RIGHT', 5, 0);
			
		lastRage = check1;
		lastFrame = check1;

	--Cleave
		local c2tspellName, _, c2tspell = GetSpellInfo(ids.Fury_Ability.CleaveRank1);
		local check2 = CreateFrame("CheckButton", "ConROC_SM_Rage_Cleave", frame, "UICheckButtonTemplate");
		local check2text = frame:CreateFontString(check2, "ARTWORK", "GameFontHighlightSmall");		
			check2:SetPoint("TOP", ConROCCheckFrame2, "BOTTOM", -150, 0);
			check2:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				check2:SetChecked(ConROCWarriorSpells.ConROC_Tank_Rage_Cleave);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check2:SetChecked(ConROCWarriorSpells.ConROC_Melee_Rage_Cleave);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check2:SetChecked(ConROCWarriorSpells.ConROC_PvP_Rage_Cleave);
			end
			check2:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCWarriorSpells.ConROC_Tank_Rage_Cleave = ConROC_SM_Rage_Cleave:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCWarriorSpells.ConROC_Melee_Rage_Cleave = ConROC_SM_Rage_Cleave:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarriorSpells.ConROC_PvP_Rage_Cleave = ConROC_SM_Rage_Cleave:GetChecked();
					end
				end);
			check2text:SetText(c2tspellName);				
		local c2t = check2.texture;
		 
			if not c2t then
				c2t = check2:CreateTexture('CheckFrame2_check2_Texture', 'ARTWORK');
				c2t:SetTexture(c2tspell);
				c2t:SetBlendMode('BLEND');
				check2.texture = c2t;
			end			
			c2t:SetScale(0.4);
			c2t:SetPoint("LEFT", check2, "RIGHT", 8, 0);
			check2text:SetPoint('LEFT', c2t, 'RIGHT', 5, 0);
			
		lastRage = check2;
		lastFrame = check2;
		
	--Slam
		local c3tspellName, _, c3tspell = GetSpellInfo(ids.Fury_Ability.SlamRank1);
		local check3 = CreateFrame("CheckButton", "ConROC_SM_Rage_Slam", frame, "UICheckButtonTemplate");
		local check3text = frame:CreateFontString(check3, "ARTWORK", "GameFontHighlightSmall");		
			check3:SetPoint("TOP", ConROCCheckFrame2, "BOTTOM", -150, 0);
			check3:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				check3:SetChecked(ConROCWarriorSpells.ConROC_Tank_Rage_Slam);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check3:SetChecked(ConROCWarriorSpells.ConROC_Melee_Rage_Slam);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check3:SetChecked(ConROCWarriorSpells.ConROC_PvP_Rage_Slam);
			end
			check3:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCWarriorSpells.ConROC_Tank_Rage_Slam = ConROC_SM_Rage_Slam:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCWarriorSpells.ConROC_Melee_Rage_Slam = ConROC_SM_Rage_Slam:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarriorSpells.ConROC_PvP_Rage_Slam = ConROC_SM_Rage_Slam:GetChecked();
					end
				end);
			check3text:SetText(c3tspellName);				
		local c3t = check3.texture;
		 
			if not c3t then
				c3t = check3:CreateTexture('CheckFrame2_check3_Texture', 'ARTWORK');
				c3t:SetTexture(c3tspell);
				c3t:SetBlendMode('BLEND');
				check3.texture = c3t;
			end			
			c3t:SetScale(0.4);
			c3t:SetPoint("LEFT", check3, "RIGHT", 8, 0);
			check3text:SetPoint('LEFT', c3t, 'RIGHT', 5, 0);
			
		lastRage = check3;
		lastFrame = check3;
		
		frame:Show()
end

function ConROC:CheckHeader3()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckHeader3", ConROCSpellmenuClass)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 10)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		local fontAuras = frame:CreateFontString("ConROC_Spellmenu_CheckHeader3", "ARTWORK", "GameFontGreenSmall");
			fontAuras:SetText("Stuns and Slows");
			fontAuras:SetPoint('TOP', frame, 'TOP');
		
			local obutton = CreateFrame("Button", 'ConROC_CheckFrame3_OpenButton', frame)
				obutton:SetFrameStrata('MEDIUM')
				obutton:SetFrameLevel('6')
				obutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				obutton:SetSize(12, 12)
				obutton:Hide()
				obutton:SetAlpha(1)
				
				obutton:SetText("v")
				obutton:SetNormalFontObject("GameFontHighlightSmall")

			local ohtex = obutton:CreateTexture()
				ohtex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				ohtex:SetTexCoord(0, 0.625, 0, 0.6875)
				ohtex:SetAllPoints()
				obutton:SetHighlightTexture(ohtex)

				obutton:SetScript("OnMouseUp", function (self, obutton, up)
					self:Hide();
					ConROCCheckFrame3:Show();
					ConROC_CheckFrame3_CloseButton:Show();
					ConROC:SpellMenuUpdate();
				end)

			local tbutton = CreateFrame("Button", 'ConROC_CheckFrame3_CloseButton', frame)
				tbutton:SetFrameStrata('MEDIUM')
				tbutton:SetFrameLevel('6')
				tbutton:SetPoint("LEFT", fontAuras, "RIGHT", 0, 0)
				tbutton:SetSize(12, 12)
				tbutton:Show()
				tbutton:SetAlpha(1)
				
				tbutton:SetText("^")
				tbutton:SetNormalFontObject("GameFontHighlightSmall")

			local htex = tbutton:CreateTexture()
				htex:SetTexture("Interface\\AddOns\\ConROC\\images\\buttonHighlight")
				htex:SetTexCoord(0, 0.625, 0, 0.6875)
				htex:SetAllPoints()
				tbutton:SetHighlightTexture(htex)
				
				tbutton:SetScript("OnMouseUp", function (self, tbutton, up)
					self:Hide();
					ConROCCheckFrame3:Hide();
					ConROC_CheckFrame3_OpenButton:Show();
					ConROC:SpellMenuUpdate();
				end)		
		
		frame:Show();
		lastFrame = frame;
		
	ConROC:CheckFrame3();
end

function ConROC:CheckFrame3()
	local _, Class, classId = UnitClass("player")
	local Color = RAID_CLASS_COLORS[Class]
	local frame = CreateFrame("Frame", "ConROCCheckFrame3", ConROCCheckHeader3)
		
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('5')
		frame:SetSize(180, 5)
		frame:SetAlpha(1)
		
		frame:SetPoint("TOP", "ConROCCheckHeader3", "BOTTOM", 0, 0)
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetClampedToScreen(true)

		lastStun = frame;
		lastFrame = frame;
		
	--Hamstring
		local c1tspellName, _, c1tspell = GetSpellInfo(ids.Arms_Ability.HamstringRank1);
		local check1 = CreateFrame("CheckButton", "ConROC_SM_Stun_Hamstring", frame, "UICheckButtonTemplate");
		local check1text = frame:CreateFontString(check1, "ARTWORK", "GameFontHighlightSmall");		
			check1:SetPoint("TOP", ConROCCheckFrame3, "BOTTOM", -150, 0);
			check1:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				check1:SetChecked(ConROCWarriorSpells.ConROC_Tank_Stun_Hamstring);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check1:SetChecked(ConROCWarriorSpells.ConROC_Melee_Stun_Hamstring);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check1:SetChecked(ConROCWarriorSpells.ConROC_PvP_Stun_Hamstring);
			end
			check1:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCWarriorSpells.ConROC_Tank_Stun_Hamstring = ConROC_SM_Stun_Hamstring:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCWarriorSpells.ConROC_Melee_Stun_Hamstring = ConROC_SM_Stun_Hamstring:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarriorSpells.ConROC_PvP_Stun_Hamstring = ConROC_SM_Stun_Hamstring:GetChecked();
					end
				end);
			check1text:SetText(c1tspellName);				
		local c1t = check1.texture;
		 
			if not c1t then
				c1t = check1:CreateTexture('CheckFrame3_check1_Texture', 'ARTWORK');
				c1t:SetTexture(c1tspell);
				c1t:SetBlendMode('BLEND');
				check1.texture = c1t;
			end			
			c1t:SetScale(0.4);
			c1t:SetPoint("LEFT", check1, "RIGHT", 8, 0);
			check1text:SetPoint('LEFT', c1t, 'RIGHT', 5, 0);
			
		lastStun = check1;
		lastFrame = check1;

	--Piercing Howl
		local c2tspellName, _, c2tspell = GetSpellInfo(ids.Fury_Ability.PiercingHowl);
		local check2 = CreateFrame("CheckButton", "ConROC_SM_Stun_PiercingHowl", frame, "UICheckButtonTemplate");
		local check2text = frame:CreateFontString(check2, "ARTWORK", "GameFontHighlightSmall");		
			check2:SetPoint("TOP", ConROCCheckFrame3, "BOTTOM", -150, 0);
			check2:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				check2:SetChecked(ConROCWarriorSpells.ConROC_Tank_Stun_PiercingHowl);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check2:SetChecked(ConROCWarriorSpells.ConROC_Melee_Stun_PiercingHowl);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check2:SetChecked(ConROCWarriorSpells.ConROC_PvP_Stun_PiercingHowl);
			end
			check2:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCWarriorSpells.ConROC_Tank_Stun_PiercingHowl = ConROC_SM_Stun_PiercingHowl:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCWarriorSpells.ConROC_Melee_Stun_PiercingHowl = ConROC_SM_Stun_PiercingHowl:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarriorSpells.ConROC_PvP_Stun_PiercingHowl = ConROC_SM_Stun_PiercingHowl:GetChecked();
					end
				end);
			check2text:SetText(c2tspellName);				
		local c2t = check2.texture;
		 
			if not c2t then
				c2t = check2:CreateTexture('CheckFrame3_check2_Texture', 'ARTWORK');
				c2t:SetTexture(c2tspell);
				c2t:SetBlendMode('BLEND');
				check2.texture = c2t;
			end			
			c2t:SetScale(0.4);
			c2t:SetPoint("LEFT", check2, "RIGHT", 8, 0);
			check2text:SetPoint('LEFT', c2t, 'RIGHT', 5, 0);
			
		lastStun = check2;
		lastFrame = check2;
		
	--Concussion Blow
		local c3tspellName, _, c3tspell = GetSpellInfo(ids.Prot_Ability.ConcussionBlow);
		local check3 = CreateFrame("CheckButton", "ConROC_SM_Stun_ConcussionBlow", frame, "UICheckButtonTemplate");
		local check3text = frame:CreateFontString(check3, "ARTWORK", "GameFontHighlightSmall");		
			check3:SetPoint("TOP", ConROCCheckFrame3, "BOTTOM", -150, 0);
			check3:SetScale(.50);
			if ConROC:CheckBox(ConROC_SM_Role_Tank) then
				check3:SetChecked(ConROCWarriorSpells.ConROC_Tank_Stun_ConcussionBlow);
			elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
				check3:SetChecked(ConROCWarriorSpells.ConROC_Melee_Stun_ConcussionBlow);
			elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
				check3:SetChecked(ConROCWarriorSpells.ConROC_PvP_Stun_ConcussionBlow);
			end
			check3:SetScript("OnClick", 
				function()
					if ConROC:CheckBox(ConROC_SM_Role_Tank) then
						ConROCWarriorSpells.ConROC_Tank_Stun_ConcussionBlow = ConROC_SM_Stun_ConcussionBlow:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
						ConROCWarriorSpells.ConROC_Melee_Stun_ConcussionBlow = ConROC_SM_Stun_ConcussionBlow:GetChecked();
					elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
						ConROCWarriorSpells.ConROC_PvP_Stun_ConcussionBlow = ConROC_SM_Stun_ConcussionBlow:GetChecked();
					end
				end);
			check3text:SetText(c3tspellName);				
		local c3t = check3.texture;
		 
			if not c3t then
				c3t = check3:CreateTexture('CheckFrame3_check3_Texture', 'ARTWORK');
				c3t:SetTexture(c3tspell);
				c3t:SetBlendMode('BLEND');
				check3.texture = c3t;
			end			
			c3t:SetScale(0.4);
			c3t:SetPoint("LEFT", check3, "RIGHT", 8, 0);
			check3text:SetPoint('LEFT', c3t, 'RIGHT', 5, 0);
			
		lastStun = check3;
		lastFrame = check3;
		
		frame:Show()
end

function ConROC:SpellMenuUpdate()
lastFrame = ConROCSpellmenuClass;

	--Shouts and Debuffs	
	if ConROCCheckFrame1 ~= nil then
		lastBuff = ConROCCheckFrame1;
		
		if plvl >= 1 then 
			ConROC_SM_Shout_BattleShout:Show();
			lastDebuff = ConROC_SM_Shout_BattleShout;
		else
			ConROC_SM_Shout_BattleShout:Hide();
		end	

		if plvl >= 4 then 
			ConROC_SM_Debuff_Rend:Show(); 
			ConROC_SM_Debuff_Rend:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);
			lastDebuff = ConROC_SM_Debuff_Rend;
		else
			ConROC_SM_Debuff_Rend:Hide();
		end	

		if plvl >= 6 then 
			ConROC_SM_Debuff_ThunderClap:Show(); 
			ConROC_SM_Debuff_ThunderClap:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);
			lastDebuff = ConROC_SM_Debuff_ThunderClap;
		else
			ConROC_SM_Debuff_ThunderClap:Hide();
		end	

		if plvl >= 10 then 
			ConROC_SM_Debuff_SunderArmor:Show(); 
			ConROC_SM_Debuff_SunderArmor:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);
			lastDebuff = ConROC_SM_Debuff_SunderArmor;
		else
			ConROC_SM_Debuff_SunderArmor:Hide();
		end	

		if plvl >= 10 then 
			ConROC_SM_Shout_Bloodrage:Show(); 
			ConROC_SM_Shout_Bloodrage:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);
			lastDebuff = ConROC_SM_Shout_Bloodrage;
		else
			ConROC_SM_Shout_Bloodrage:Hide();
		end

		if plvl >= 14 then 
			ConROC_SM_Shout_DemoralizingShout:Show(); 
			ConROC_SM_Shout_DemoralizingShout:SetPoint("TOP", lastDebuff, "BOTTOM", 0, 0);
			lastDebuff = ConROC_SM_Shout_DemoralizingShout;
		else
			ConROC_SM_Shout_DemoralizingShout:Hide();
		end
		
		if ConROCCheckFrame1:IsVisible() then
			lastFrame = lastDebuff;
		else
			lastFrame = ConROCCheckHeader1;
		end	
	end
	
	--Rage Dump
	if ConROCCheckFrame2 ~= nil then
		if lastFrame == lastDebuff then
			ConROCCheckHeader2:SetPoint("TOP", lastFrame, "BOTTOM", 75, -5);
		else 
			ConROCCheckHeader2:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5);
		end	

		lastRage = ConROCCheckFrame2;
		
		if plvl >= 1 then 
			ConROC_SM_Rage_HeroicStrike:Show();
			lastRage = ConROC_SM_Rage_HeroicStrike;
		else
			ConROC_SM_Rage_HeroicStrike:Hide();
		end	
		
		if plvl >= 20 then 
			ConROC_SM_Rage_Cleave:Show(); 
			ConROC_SM_Rage_Cleave:SetPoint("TOP", lastRage, "BOTTOM", 0, 0);
			lastRage = ConROC_SM_Rage_Cleave;
		else
			ConROC_SM_Rage_Cleave:Hide();
		end		
		
		if plvl >= 30 then 
			ConROC_SM_Rage_Slam:Show(); 
			ConROC_SM_Rage_Slam:SetPoint("TOP", lastRage, "BOTTOM", 0, 0);
			lastRage = ConROC_SM_Rage_Slam;
		else
			ConROC_SM_Rage_Slam:Hide();
		end

		if ConROCCheckFrame2:IsVisible() then
			lastFrame = lastRage;
		else
			lastFrame = ConROCCheckHeader2;
		end	
	end

	--Stuns and Slows	
	if ConROCCheckFrame3 ~= nil then
		if lastFrame == lastDebuff or lastFrame == lastRage then
			ConROCCheckHeader3:SetPoint("TOP", lastFrame, "BOTTOM", 75, -5);
		else 
			ConROCCheckHeader3:SetPoint("TOP", lastFrame, "BOTTOM", 0, -5);
		end	

		lastStun = ConROCCheckFrame3;
		
		if plvl >= 8 then 
			ConROC_SM_Stun_Hamstring:Show();
			lastStun = ConROC_SM_Stun_Hamstring;
		else
			ConROC_SM_Stun_Hamstring:Hide();
		end	
		
		if plvl >= 20 and IsSpellKnown(ids.Fury_Ability.PiercingHowl) then 
			ConROC_SM_Stun_PiercingHowl:Show(); 
			ConROC_SM_Stun_PiercingHowl:SetPoint("TOP", lastStun, "BOTTOM", 0, 0);
			lastStun = ConROC_SM_Stun_PiercingHowl;
		else
			ConROC_SM_Stun_PiercingHowl:Hide();
		end		
		
		if plvl >= 30 and IsSpellKnown(ids.Prot_Ability.ConcussionBlow) then 
			ConROC_SM_Stun_ConcussionBlow:Show(); 
			ConROC_SM_Stun_ConcussionBlow:SetPoint("TOP", lastStun, "BOTTOM", 0, 0);
			lastStun = ConROC_SM_Stun_ConcussionBlow;
		else
			ConROC_SM_Stun_ConcussionBlow:Hide();
		end

		if ConROCCheckFrame3:IsVisible() then
			lastFrame = lastStun;
		else
			lastFrame = ConROCCheckHeader3;
		end	
	end
end

function ConROC:RoleProfile()
	if ConROC:CheckBox(ConROC_SM_Role_Tank) then
		ConROC_SM_Shout_BattleShout:SetChecked(ConROCWarriorSpells.ConROC_Tank_Shout_BattleShout);
		ConROC_SM_Debuff_Rend:SetChecked(ConROCWarriorSpells.ConROC_Tank_Debuff_Rend);
		ConROC_SM_Debuff_ThunderClap:SetChecked(ConROCWarriorSpells.ConROC_Tank_Debuff_ThunderClap);
		ConROC_SM_Debuff_SunderArmor:SetChecked(ConROCWarriorSpells.ConROC_Tank_Debuff_SunderArmor);
		ConROC_SM_Debuff_SunderArmorCount:SetNumber(ConROCWarriorSpells.ConROC_Tank_Debuff_SunderArmorCount or 5);
		ConROC_SM_Shout_Bloodrage:SetChecked(ConROCWarriorSpells.ConROC_Tank_Shout_Bloodrage);
		ConROC_SM_Shout_DemoralizingShout:SetChecked(ConROCWarriorSpells.ConROC_Tank_Shout_DemoralizingShout);
		
		ConROC_SM_Rage_HeroicStrike:SetChecked(ConROCWarriorSpells.ConROC_Tank_Rage_HeroicStrike);
		ConROC_SM_Rage_Cleave:SetChecked(ConROCWarriorSpells.ConROC_Tank_Rage_Cleave);
		ConROC_SM_Rage_Slam:SetChecked(ConROCWarriorSpells.ConROC_Tank_Rage_Slam);
		
		ConROC_SM_Stun_Hamstring:SetChecked(ConROCWarriorSpells.ConROC_Tank_Stun_Hamstring);
		ConROC_SM_Stun_PiercingHowl:SetChecked(ConROCWarriorSpells.ConROC_Tank_Stun_PiercingHowl);
		ConROC_SM_Stun_ConcussionBlow:SetChecked(ConROCWarriorSpells.ConROC_Tank_Stun_ConcussionBlow);
		
	elseif ConROC:CheckBox(ConROC_SM_Role_Melee) then
		ConROC_SM_Shout_BattleShout:SetChecked(ConROCWarriorSpells.ConROC_Melee_Shout_BattleShout);
		ConROC_SM_Debuff_Rend:SetChecked(ConROCWarriorSpells.ConROC_Melee_Debuff_Rend);
		ConROC_SM_Debuff_ThunderClap:SetChecked(ConROCWarriorSpells.ConROC_Melee_Debuff_ThunderClap);
		ConROC_SM_Debuff_SunderArmor:SetChecked(ConROCWarriorSpells.ConROC_Melee_Debuff_SunderArmor);
		ConROC_SM_Debuff_SunderArmorCount:SetNumber(ConROCWarriorSpells.ConROC_Melee_Debuff_SunderArmorCount or 5);
		ConROC_SM_Shout_Bloodrage:SetChecked(ConROCWarriorSpells.ConROC_Melee_Shout_Bloodrage);
		ConROC_SM_Shout_DemoralizingShout:SetChecked(ConROCWarriorSpells.ConROC_Melee_Shout_DemoralizingShout);
		
		ConROC_SM_Rage_HeroicStrike:SetChecked(ConROCWarriorSpells.ConROC_Melee_Rage_HeroicStrike);
		ConROC_SM_Rage_Cleave:SetChecked(ConROCWarriorSpells.ConROC_Melee_Rage_Cleave);
		ConROC_SM_Rage_Slam:SetChecked(ConROCWarriorSpells.ConROC_Melee_Rage_Slam);		
	
		ConROC_SM_Stun_Hamstring:SetChecked(ConROCWarriorSpells.ConROC_Melee_Stun_Hamstring);
		ConROC_SM_Stun_PiercingHowl:SetChecked(ConROCWarriorSpells.ConROC_Melee_Stun_PiercingHowl);
		ConROC_SM_Stun_ConcussionBlow:SetChecked(ConROCWarriorSpells.ConROC_Melee_Stun_ConcussionBlow);
		
	elseif ConROC:CheckBox(ConROC_SM_Role_PvP) then
		ConROC_SM_Shout_BattleShout:SetChecked(ConROCWarriorSpells.ConROC_PvP_Shout_BattleShout);
		ConROC_SM_Debuff_Rend:SetChecked(ConROCWarriorSpells.ConROC_PvP_Debuff_Rend);
		ConROC_SM_Debuff_ThunderClap:SetChecked(ConROCWarriorSpells.ConROC_PvP_Debuff_ThunderClap);
		ConROC_SM_Debuff_SunderArmor:SetChecked(ConROCWarriorSpells.ConROC_PvP_Debuff_SunderArmor);
		ConROC_SM_Debuff_SunderArmorCount:SetNumber(ConROCWarriorSpells.ConROC_PvP_Debuff_SunderArmorCount or 5);
		ConROC_SM_Shout_Bloodrage:SetChecked(ConROCWarriorSpells.ConROC_PvP_Shout_Bloodrage);
		ConROC_SM_Shout_DemoralizingShout:SetChecked(ConROCWarriorSpells.ConROC_PvP_Shout_DemoralizingShout);
		
		ConROC_SM_Rage_HeroicStrike:SetChecked(ConROCWarriorSpells.ConROC_PvP_Rage_HeroicStrike);
		ConROC_SM_Rage_Cleave:SetChecked(ConROCWarriorSpells.ConROC_PvP_Rage_Cleave);
		ConROC_SM_Rage_Slam:SetChecked(ConROCWarriorSpells.ConROC_PvP_Rage_Slam);		
	
		ConROC_SM_Stun_Hamstring:SetChecked(ConROCWarriorSpells.ConROC_PvP_Stun_Hamstring);
		ConROC_SM_Stun_PiercingHowl:SetChecked(ConROCWarriorSpells.ConROC_PvP_Stun_PiercingHowl);
		ConROC_SM_Stun_ConcussionBlow:SetChecked(ConROCWarriorSpells.ConROC_PvP_Stun_ConcussionBlow);
		
	end
end