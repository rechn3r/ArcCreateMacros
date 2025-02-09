do
    ---@type rech.Class
    local Class = require("rech.Class")
    ---@type rech.lib.Request
    local request = require("rech.lib.request")
    
    ---@class rech.editing.ArcToastify
    local this = Class()

    local __MACRO_ID = "rech.editing.ArcToastify"
    local __MACRO_DISPLAY_NAME = "Toastify arcs"

    ---Init macro
    ---@param parentId string
    function this.initMacro(parentId)
        removeMacro(__MACRO_ID)
        addMacroWithIcon(parentId, __MACRO_ID, __MACRO_DISPLAY_NAME, "ea54", this.activate)
    end

    function this.activate()
        local result = request.CurrentSelection(EventSelectionConstraint.arc())
        local arcs = result.arc
        if #arcs == 0 then
            notifyWarn("No arc selected.")
            return
        end
        local commands = Command.create(string.format("%s (%s)", __MACRO_DISPLAY_NAME, __MACRO_ID))
        for _, arc in ipairs(arcs) do
            Event.setSelection({arc})
            Context.currentTiming = arc.timing
            local duration = arc.endTiming - arc.timing
            local cutAt = request.Timing(false, "Select when the highlighted arc should be bent")
            cutAt = cutAt - arc.timing
            while cutAt < 1 or cutAt > duration do
                cutAt = request.Timing(false, "Target timing is outside arc timing, try again")
            end
            local newArc = Event.arc(arc.timing+cutAt, arc.endXY, arc.endTiming, arc.endXY, arc.isTrace, arc.color, "s", arc.timingGroup, arc.sfx)
            commands.add(newArc.save())
            arc.endTiming = math.floor(arc.timing+cutAt)
            arc.type = "s"
            commands.add(arc.save())
        end
        commands.commit()
    end

    return this
end
