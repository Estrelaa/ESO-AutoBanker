AutoBanker = {}

AutoBanker.name = "AutoBanker"

function AutoBanker.Initialize()
    EVENT_MANAGER:RegisterForEvent(AutoBanker.name, EVENT_OPEN_BANK, AutoBanker.OnBankOpened)
end

function AutoBanker.OnAddOnLoaded(event, addonName)
    if addonName == AutoBanker.name then
        AutoBanker.Initialize()
        EVENT_MANAGER:UnregisterForEvent(AutoBanker.name, EVENT_ADD_ON_LOADED)
    end
end

function AutoBanker.OnBankOpened(event, bankBag)
    if bankBag == BAG_BANK then
        -- Get the data of both the player bag and their bank
        PlayerInventory = SHARED_INVENTORY:GenerateFullSlotData(nil,BAG_BACKPACK)
        PlayerBank = SHARED_INVENTORY:GenerateFullSlotData(nil,BAG_BANK)

        -- for each item in the player bag, search for that same item in the player's bank
        for _, itemInBag in pairs(PlayerInventory) do
            for _, itemInBank in pairs(PlayerBank) do
                if (itemInBag.name == itemInBank.name) then
                    d("Found "..itemInBag.name.." in bank")
                    if IsProtectedFunction("RequestMoveItem") then
                        CallSecureProtected("RequestMoveItem", BAG_BACKPACK, itemInBag.slotIndex, BAG_BANK, itemInBank.slotIndex, 200)
                    end
                end
            end
        end
    end
end


-- Must keep at the end of the file, else it errors on load
EVENT_MANAGER:RegisterForEvent(AutoBanker.name, EVENT_ADD_ON_LOADED, AutoBanker.OnAddOnLoaded)
