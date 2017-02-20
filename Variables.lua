-- Creates character uniq save file

if not ghost then
  ghost = {}
end

if not ghost['frameScale'] then
  ghost['frameScale'] = 1;
end

if not ghost['lockButton'] then
  ghost['lockButton'] = true;
end

if not ghost['lockFrame'] then
  ghost['lockFrame'] = true;
end

if not ghost['showBindingText'] then
  ghost['showBindingText'] = true;
end

-- Small hack to find empty buttons. We want to avoid default buttons on eatch class.

if class == "DRUID" then
  ghost["ButtonID"] = {
    109,110,111,112,113,
    114,115,116,117,118,
    119,120,85,86,87,
    88,89,90,91,92,
    93,94,95,96, 48};
elseif class == "WARRIOR" then
  ghost["ButtonID"] = {
    109,110,111,112,113,
    114,115,116,117,118,
    119,120,37,38,39,
    40,41,42,43,44,
    45,46,47,48,60};
else
  ghost["ButtonID"] = {
    85,86,87,88,89,
    90,91,92,93,94,
    95,96,97,98,99,
    100,101,102,103,104,
    105,106,107,108,109};
end
