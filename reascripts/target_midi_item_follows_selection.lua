-- Fonction pour activer l'item contenant la première note sélectionnée
function activate_item_containing_selected_notes()
    -- Obtenir l'éditeur MIDI actif
    local midi_editor = reaper.MIDIEditor_GetActive()
    if not midi_editor then 
        reaper.ShowConsoleMsg("Aucun éditeur MIDI actif.\n")
        return 
    end
    
    local n_tracks = reaper.CountTracks()
    for i = 0, n_tracks - 1 do
      local take = reaper.MIDIEditor_GetTake(midi_editor)
      if reaper.MIDI_EnumSelNotes(take, -1) ~= -1 then
          return
      end
    reaper.MIDIEditor_OnCommand(midi_editor, 40835)
    end
    
end


-- Appel de la fonction pour activer l'item du premier note sélectionnée
activate_item_containing_selected_notes()

