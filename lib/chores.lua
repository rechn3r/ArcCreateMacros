do
    ---@class rech.lib.Chores
    local this = {}
    this.__index = this

    ---@param timing integer
    ---@param xy XY
    ---@param color integer
    ---@param timingGroup integer
    ---@param sfx string
    ---@return LuaChartCommand, LuaChartCommand
    function this.SaveSingleArcTap(timing, xy, color, timingGroup, sfx)
        local arc = Event.arc(timing, xy, timing, xy, true, color, "s", timingGroup, sfx)
        local arctap = Event.arcTap(timing, arc)
        return arc.save(), arctap.save()
    end
    return this
end
