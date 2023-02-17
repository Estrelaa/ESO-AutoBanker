AutoBanker = {}

AutoBanker.name = "AutoBanker"

function AutoBanker.OnAddOnLoaded(event, addonName)
    if addonName == AutoBanker.name then
        EVENT_MANAGER:RegisterForEvent(AutoBanker.name, EVENT_OPEN_BANK, AutoBanker.OnBankOpened)
        EVENT_MANAGER:UnregisterForEvent(AutoBanker.name, EVENT_ADD_ON_LOADED)
    end
end

function AutoBanker.OnBankOpened(event, bankBag)
    if bankBag == BAG_BANK then
        -- Get the data of both the player bag and their bank
        PlayerInventory = SHARED_INVENTORY:GenerateFullSlotData(nil,BAG_BACKPACK)
        PlayerBank = SHARED_INVENTORY:GenerateFullSlotData(nil,BAG_BANK)
        local itemCount = 0;

        -- for each item in the player bag, search for that same item in the player's bank
        for _, itemInBag in pairs(PlayerInventory) do
            for _, itemInBank in pairs(PlayerBank) do
                if (itemInBag.name == itemInBank.name) then
                    if IsProtectedFunction("RequestMoveItem") then
                        CallSecureProtected("RequestMoveItem", BAG_BACKPACK, itemInBag.slotIndex, BAG_BANK, itemInBank.slotIndex, 200)
                        itemCount = itemCount + 1
                    end
                end
            end
        end
    end

    d("Attempted to move"..itemCount.." items to your bank")
end


-- Must keep at the end of the file, else it errors on load
EVENT_MANAGER:RegisterForEvent(AutoBanker.name, EVENT_ADD_ON_LOADED, AutoBanker.OnAddOnLoaded)
