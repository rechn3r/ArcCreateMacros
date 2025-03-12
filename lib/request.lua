do
    ---@class RSelectionResult
    ---@field tap LuaTap[]
    ---@field hold LuaHold[]
    ---@field arc LuaArc[]
    ---@field arctap LuaArcTap[]
    ---@field timing LuaTiming[]
    ---@field camera LuaCamera[]
    ---@field scenecontrol LuaScenecontrol[]
    ---@field all LuaChartEvent[]
    RSelectionResult = {}

    ---@class rech.lib.Request
    local this = {}
    this.__index = this

    ---@param constraint EventSelectionConstraint
    ---@param notification string
    ---@return RSelectionResult
    function this.Event(constraint, notification)
        local req = EventSelectionInput.requestSingleEvent(constraint, notification)
        coroutine.yield()
        ---@type RSelectionResult
        local result = {
            all = req.resultCombined,
            tap = req.result["tap"],
            hold = req.result["hold"],
            arc = req.result["arc"],
            arctap = req.result["arctap"],
            timing = req.result["timing"],
            camera = req.result["camera"],
            scenecontrol = req.result["scenecontrol"]
        }
        return result
    end

    ---@param constraint EventSelectionConstraint
    ---@param notification string
    ---@return RSelectionResult
    function this.Events(constraint, notification)
        local req = EventSelectionInput.requestEvents(constraint, notification)
        coroutine.yield()
        ---@type RSelectionResult
        local result = {
            all = req.resultCombined,
            tap = req.result["tap"],
            hold = req.result["hold"],
            arc = req.result["arc"],
            arctap = req.result["arctap"],
            timing = req.result["timing"],
            camera = req.result["camera"],
            scenecontrol = req.result["scenecontrol"]
        }
        return result
    end

    ---@param constraint EventSelectionConstraint
    ---@return RSelectionResult
    function this.CurrentSelection(constraint)
        local req = Event.getCurrentSelection(constraint)
        -- coroutine.yield()
        ---@type RSelectionResult
        local result = {
            all = req.resultCombined,
            tap = req.result["tap"],
            hold = req.result["hold"],
            arc = req.result["arc"],
            arctap = req.result["arctap"],
            timing = req.result["timing"],
            camera = req.result["camera"],
            scenecontrol = req.result["scenecontrol"]
        }
        return result
    end

    ---@param constraint EventSelectionConstraint
    ---@return RSelectionResult
    function this.Query(constraint)
        local queryResult = Event.query(constraint)
        coroutine.yield()
        ---@type RSelectionResult
        local result = {
            tap = queryResult["tap"],
            hold = queryResult["hold"],
            arc = queryResult["arc"],
            arctap = queryResult["arctap"],
            timing = queryResult["timing"],
            camera = queryResult["camera"],
            scenecontrol = queryResult["scenecontrol"],
            all = queryResult.resultCombined
        }
        return result
    end

    ---@param notification string
    ---@return number
    function this.TrackLane(notification)
        local req = TrackInput.requestLane(notification)
        coroutine.yield()
        return req.result["lane"]
    end

    ---@param timing integer
    ---@param notification string
    ---@return XY
    function this.VerticalPosition(timing, notification)
        local req = TrackInput.requestPosition(timing, notification)
        coroutine.yield()
        return req.result["xy"]
    end

    ---@param showVertical boolean
    ---@param notification string
    ---@return number
    function this.Timing(showVertical, notification)
        local req = TrackInput.requestTiming(showVertical, notification)
        coroutine.yield()
        return req.result["timing"]
    end

    return this
end
