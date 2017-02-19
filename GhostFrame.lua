-- Creates frame template for all buttons

function ghostCreateFrame()
  local title = CreateFrame("Frame", "Ghost", UIParent)
  title:SetMovable(1)
  title:EnableMouse(1)
  title:SetScript("OnMouseDown",function()
      if ghost['lockFrame'] == false or IsShiftKeyDown() then
        this:StartMoving();
      end
    end)
  title:SetScript("OnMouseUp",function() this:StopMovingOrSizing() end)
  title:SetPoint("CENTER",0,0)
  title:SetWidth(209)
  title:SetHeight(209)
  Ghost:Hide();
end

-- Creates button

function ghostCreateButton()
  local Frame = Ghost;
  local newRow = true;
  local i = 0;

  for row = 1, 5, 1 do
    for col = 1, 5, 1 do
      i = i + 1;

      local btn = CreateFrame("CheckButton", "ghostButton"..i, Frame, "ActionBarButtonTemplate")
      btn:SetID(ghost["ButtonID"][i]);

      if (newRow == true) then
        if (i == 1) then
          btn:SetPoint("TOPLEFT", Frame, 7, -24)
        else
          btn:SetPoint("TOP", "ghostButton"..i - 5, "BOTTOM", 0, -4)
        end

        newRow = false;
      else
        btn:SetPoint("LEFT", "ghostButton"..i - 1, "RIGHT",4 , 0)
      end

      btn:SetScript("OnDragStart", function()
          if ghost['lockButton'] == false or IsShiftKeyDown() then
            PickupAction(this:GetID())
          end
        end)

      -- font template for buttons
      btn.title = btn:CreateFontString("ghostButton"..i.."Text", "OVERLAY")
      btn.title:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
      btn.title:SetTextColor(1, 1, 1)
      btn.title:SetPoint("TOP", btn ,"TOP", 0, 0)
    end
    newRow = true;
  end
end

-- Show frame under mouse pointer

function ghostShowFrame()
  if (keystate == "down") then
    local frameScale = ghost['frameScale'];
    local mouseX, mouseY = GetCursorPosition();
    local wowScale = UIParent:GetEffectiveScale()

    Ghost:ClearAllPoints();
    Ghost:SetScale(frameScale);
    Ghost:SetPoint("CENTER",WorldFrame,"BOTTOMLEFT", ( mouseX / frameScale) / wowScale, (mouseY / frameScale) / wowScale );

  -- Check if we need to show/ hide binding text
  -- if statement are always false at the moment, unsure why.
    
  --  if ghostText['showBindingText'] == true then
      ghostButtonText();
  --  else
  --    ghostButtonTextHide();
  --  end

    Ghost:Show();
  else
    Ghost:Hide();
  end
end

-- Set button text

function ghostButtonText()
  for i = 1, 25, 1 do
    local key1, key2 = GetBindingKey(format("ghostButton" .. i));
    key1 = tostring(key1);

    key1 = string.gsub(key1,"ALT","a");
    key1 = string.gsub(key1,"CTRL","c");
    key1 = string.gsub(key1,"SHIFT","s");
    key1 = string.gsub(key1,"NUMPAD", "np");
    key1 = string.gsub(key1,"nil", "");

    local gText = format("ghostButton"..i.."Text");
    getglobal(gText):SetText(key1);
    getglobal(gText):Show();
  end
end

function ghostButtonTextHide()
  for i = 1, 25, 1 do
    local gText = format("ghostButton"..i.."Text");
    getglobal(gText):Hide();
  end
end
