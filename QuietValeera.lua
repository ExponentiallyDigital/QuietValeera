-- from ShutUpValeera addon: faster for processing, free memory, only exec on login not enter world
-- Mute Valeera Sound IDs
local soundIDs = {7243762, 7243934, 7329273, 7430043, 7430047, 7430050, 7430053, 7430056, 7430059, 7430063, 7430066, 7430069, 7430072, 7430075, 7430078, 7430082, 7430086, 7430089, 7430092, 7430095, 7430098, 7430101, 7430104, 7430107, 7430110, 7430113, 7430116, 7430119, 7430122, 7430125, 7430156, 7430159, 7430162, 7430165, 7430168, 7430171, 7430174, 7430177, 7430180, 7430183, 7430186, 7430189, 7430192, 7430196, 7430199, 7430202, 7430205, 7430208, 7430211, 7430230, 7430233, 7430237, 7430257, 7430268, 7430275, 7430283, 7430294, 7430314, 7430324, 7430333, 7430336, 7430339, 7430342, 7430345, 7430348, 7430351, 7430354, 7430357, 7430360, 7430363, 7430366, 7430369, 7430372, 7430375, 7430378, 7430381, 7430384, 7430388, 7430391, 7430394, 7430397, 7430400, 7430405, 7430416, 7430423, 7430428, 7430431, 7430434, 7430437, 7430440, 7430443, 7430446, 7430449, 7430452, 7430456, 7430459, 7430462, 7430465, 7430468, 7430471, 7430474, 7430477, 7430480, 7430483, 7430486, 7430489, 7430492, 7430498, 7430506, 7430512, 7430516, 7430519, 7430538, 7430547, 7430550, 7430555, 7430561, 7430565, 7430733, 7430740, 7430751, 7430754, 7430778, 7430781, 7430784, 7430787, 7430790, 7430793, 7430796, 7430799, 7430864, 7430867, 7430870, 7430881, 7430973, 7430985, 7430989, 7431077, 7431084, 7431087, 7431093, 7431103, 7431106, 7431109, 7431112, 7431115, 7431119, 7431123, 7440991, 7461759}
local muted = false

-- Function to mute the sound files
local function MuteSounds()
    if muted then return end
    for i = 1, #soundIDs do
        MuteSoundFile(soundIDs[i])
    end
    muted = true
    soundIDs = nil -- free memory
end

-- Create frame and set event handling
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN") -- fires once per session
frame:SetScript("OnEvent", MuteSounds)

-- Check if a chat type is enabled in chat settings
local function IsChatTypeEnabled(event)
    local chatTypeIndex = GetChatTypeIndex(event)
    if not chatTypeIndex then return true end
    
    local info = ChatTypeInfo[chatTypeIndex]
    return info and info.shown ~= false
end

local function ValeeraTextFilter(self, event, msg, author, ...)
    -- Check if Valeera sent this message
    if author == "Valeera Sanguinar" then
        -- If the chat type is disabled, block it (user doesn't want to see it anyway)
        if not IsChatTypeEnabled(event) then
            return true
        end
        -- Chat type is enabled, so block Valeera's messages specifically
        return true
    end
    
    return false        -- allow others
end

local events = {
    "CHAT_MSG_MONSTER_SAY",
    "CHAT_MSG_MONSTER_YELL",
    "CHAT_MSG_SAY",
    "CHAT_MSG_EMOTE",
    "CHAT_MSG_TEXT_EMOTE",
    "CHAT_MSG_MONSTER_EMOTE",
}

for _, ev in ipairs(events) do
    ChatFrame_AddMessageEventFilter(ev, ValeeraTextFilter)
end
