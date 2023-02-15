AutoBanker = {}

AutoBanker.name = "AutoBanker"

function AutoBanker.Initialize()
end

function AutoBanker.OnAddOnLoaded(event, addonName)
    if addonName == AutoBanker.name then
        AutoBanker.Initialize()
        EVENT_MANAGER:UnregisterForEvent(AutoBanker.name, EVENT_ADD_ON_LOADED)
    end
end

EVENT_MANAGER:RegisterForEvent(AutoBanker.name, EVENT_ADD_ON_LOADED, AutoBanker.OnAddOnLoaded)