local function get_virtual_env(env_var)
  local function basename(path)
    local prefix = path
    local i = path:find("[\\/:][^\\/:]*$")
    if i then
      prefix = path:sub(i + 1)
    end
      return prefix
  end

  env_path = clink.get_env(env_var)
  if env_path then
    basen = basename(env_path)
    return basen
  end
    return nil
end


  -- * Segment object with these properties:
  ---- * isNeeded: sepcifies whether a segment should be added or not. For example: no Git segment is needed in a non-git folder
  ---- * text
  ---- * textColor: Use one of the color constants. Ex: colorWhite
  ---- * fillColor: Use one of the color constants. Ex: colorBlue
  local segment = {
    isNeeded = false,
    text = "",
    textColor = colorGreen,
    fillColor = colorWhite
  }
  
  ---
  -- Sets the properties of the Segment object, and prepares for a segment to be added
  ---
  local function init()
    local env_name = get_virtual_env('VIRTUAL_ENV')
    if env_name then
      segment.isNeeded = true
      segment.text = "  "..env_name.." "
    else
      segment.isNeeded = false
    end
  end 
  
  ---
  -- Uses the segment properties to add a new segment to the prompt
  ---
  local function addAddonSegment()
    init()
    if segment.isNeeded then 
        addSegment(segment.text, segment.textColor, segment.fillColor)
    end 
  end 
  
-- Register this addon with Clink
clink.prompt.register_filter(addAddonSegment, 60)
