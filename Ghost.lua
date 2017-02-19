-- städa koden

function ghostOnEvent()
  ChatFrame1:AddMessage( ghostText['loaded'] , 1.0, 1.0, 0.0, 1.0);

  SLASH_Ghost1 = "/ghost";
  SlashCmdList["Ghost"] = function (msg)
    cmd, param = ghostCommandFormat( msg );

    if cmd == "reload" then
      ReloadUI();
    elseif cmd == ghostText['scale'] then
      slashCommandScale( param );
    elseif cmd == ghostText['reset'] then
      slashCommandReset( param );
    elseif cmd == ghostText['lock'] then
      slashCommandLock( param );
    elseif cmd == "text" then
      slashCommandText( param );
    else
      ChatFrame1:AddMessage( ghostText['slashHelp'] , 1.0, 1.0, 0.0, 1.0);
    end
  end

  ghostCreateFrame();
  ghostCreateButton();
end

-- Cut string in half at the first blankspace

function ghostCommandFormat( msg )
  if msg and strlen(msg) > 0 then
    msg = string.lower(msg)
  else
    msg = ""
  end

  local i, j, cmd, param = string.find(msg, "^([^ ]+) (.+)$")

  if not cmd then
    cmd = msg
  end

  if not cmd then
    cmd = ""
  end

  if not param then
    param = ""
  end

  return cmd, param;
end

-- Slash lock command

function slashCommandLock( param )
  cmdSub, paramSub = ghostCommandFormat( param )

  -- Lock buttons
  if cmdSub == "button" then
    if ghost['lockButton'] == false then
      ChatFrame1:AddMessage( ghostText['buttonLocked'] , 1.0, 1.0, 0.0, 1.0);
      ghost['lockButton'] = true;
    else
      ghost['lockButton'] = false;
      ChatFrame1:AddMessage( ghostText['buttonUnlocked'] , 1.0, 1.0, 0.0, 1.0);
    end
    -- Lock frame
  elseif cmdSub == "frame" then
    if ghost['lockFrame'] == false then
      ChatFrame1:AddMessage( ghostText['frameLocked'] , 1.0, 1.0, 0.0, 1.0);
      ghost['lockFrame'] = true;
    else
      ghost['lockFrame'] = false;
      ChatFrame1:AddMessage( ghostText['frameUnlocked'] , 1.0, 1.0, 0.0, 1.0);
    end
  else
    ChatFrame1:AddMessage( ghostText['lockHelp'] , 1.0, 1.0, 0.0, 1.0);
  end
end

-- Slash reset command

function slashCommandReset( param )
  cmdSub, paramSub = ghostCommandFormat( param )

  if cmdSub == "lock" then
    ChatFrame1:AddMessage( ghostText['resetLock'] , 1.0, 1.0, 0.0, 1.0);
    ghost['lockFrame'] = true;
    ghost['lockButton'] = true;
  elseif cmdSub == "scale" then
    ChatFrame1:AddMessage( ghostText['resetScale'] , 1.0, 1.0, 0.0, 1.0);
    ghost:ClearAllPoints();
    ghost:SetScale(1);
    ghost['frameScale'] = 1;
  else
    ChatFrame1:AddMessage( ghostText['resetHelp'] , 1.0, 1.0, 0.0, 1.0);
  end

end

-- Slash Scale command

function slashCommandScale( param )
  if param == "" then
    param = 0;
  end

  if param == nil then
    param = 0;
  end

  local scale = tonumber(param);

  if not scale then
    scale = 0;
  end
  if scale > 0 and scale <= 2.5 then
    ChatFrame1:AddMessage( ghostText['setScale'] .. scale, 1.0, 1.0, 0.0, 1.0);
    local scale = param;
    ghost:ClearAllPoints();
    ghost:SetScale(scale);
    ghost['frameScale'] = scale;
  else
    ChatFrame1:AddMessage( ghostText['scaleHelp'], 1.0, 1.0, 0.0, 1.0);
  end
end

-- Slash text command

function slashCommandText( param )
  if ghost['showBindingText'] == false then
    ghost['showBindingText'] = true;
    ChatFrame1:AddMessage( ghostText['ShowText'] , 1.0, 1.0, 0.0, 1.0);
  else
    ghost['showBindingText'] = false;
    ChatFrame1:AddMessage( ghostText['ShowNoText'] , 1.0, 1.0, 0.0, 1.0);
  end
end

local f = CreateFrame("Frame")
f:RegisterEvent("VARIABLES_LOADED")
f:SetScript("OnEvent", ghostOnEvent)
