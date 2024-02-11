function is_in_list(list, element)
    for _, value in ipairs(list) do
        if value == element then
            return true 
        end
    end
    return false
end


function find_first_greater_element(list, minimum)
  for _, value in ipairs(list) do
      if value > minimum then
          return value
      end
  end
  -- if nothing was found return first element
  -- which will cycle through the lanes instead of getting stuck
  -- when the last one is displayed
  return list[1]
end


function get_all_cc_lanes_with_events(take)
    -- initialize list of lanes with events
    local cc_lanes_with_event = {}
    -- get total number of events for take
    local totalEvents = reaper.MIDI_CountEvts(take)
    for i = 0, totalEvents - 1 do
         local _, selected, muted, ppqpos, chanmsg, chan, msg2, msg3 = reaper.MIDI_GetCC(take, i)
         -- msg2 corresponds to the cc lance
         -- msg3 corresponds to the message content
         if msg2 and msg2 ~= 0 and msg3 ~= 0 then 
          if not is_in_list(cc_lanes_with_event, msg2) then
            table.insert(cc_lanes_with_event, msg2)
           end
         end
    end
    table.sort(cc_lanes_with_event)
    return cc_lanes_with_event
end

function main()
    local midiEditor = reaper.MIDIEditor_GetActive()
    if not midiEditor then return end

    reaper.Undo_BeginBlock()
    -- get list of all cc lanes with events
    take = reaper.MIDIEditor_EnumTakes(midiEditor, 0, false)
    cc_lanes_with_event = get_all_cc_lanes_with_events(take)
    -- if no cc lane with events just return
    if #cc_lanes_with_event == 0 then return end
     -- get last clicked cc lane
    last_clicked_cc_lane = reaper.MIDIEditor_GetSetting_int(midiEditor, 'last_clicked_cc_lane')
    if not last_clicked_cc_lane then last_clicked_cc_lane = 0 end
    -- compute next cc lane to be displayed
    next_cc_lane = find_first_greater_element(cc_lanes_with_event, last_clicked_cc_lane)
    -- computer corresponding reaper command
    -- general cas
    if next_cc_lane ~= 32 then
      command_id = 40238 + next_cc_lane
    -- special case : 32 cc lane corresponds to bank program
    -- which are better displayed this way
    else
      command_id = 40369
    end
    reaper.MIDIEditor_OnCommand(midiEditor, command_id)
    reaper.Undo_EndBlock("Next CC lance with events", -1)
    
end

main()
    
