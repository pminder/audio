-- Toggle last two FX of master track (used for monitoring)

-- Get master track
local master_track = reaper.GetMasterTrack()

if master_track then
  -- For last 3 FX
  for fx =  reaper.TrackFX_GetCount(master_track)-2, reaper.TrackFX_GetCount(master_track)-1 do
    -- Get FX state
    local state = reaper.TrackFX_GetEnabled(master_track, fx)
    -- Set FX state
    reaper.TrackFX_SetEnabled( master_track, fx, not state )
  end
end
