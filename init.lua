hs.window.animationDuration = 0

local HotTerm = {}
local terminalApp = "Kitty"
local screenHeight = 200
HotTerm.__index = HotTerm

local function transformWindow(app, screen)
    local screenFrame = screen:frame()
    local termWindow = app:mainWindow()
    termWindow:setFrame(hs.geometry.rect(screenFrame.x, screenFrame.y, screenFrame.w, screenFrame.h - screenHeight), 0)
end

local function showHotWindow(app, screen)
    if not screen then
        hs.alert.show("No screen found for hotkey terminal")
        return
    end
    if app and app:isHidden() then
        app:unhide()
    end
    local spaceId = hs.spaces.focusedSpace()
    local termWindow = app:mainWindow()
    hs.spaces.moveWindowToSpace(termWindow, spaceId, true)
    app:activate()
    app:mainWindow():focus()
end

local function toggleTerminal()
    local app = hs.application.find(terminalApp)
    local focusedScreen = hs.screen.mainScreen()  -- Get the focused screen

    if not app then
        app = hs.application.open(terminalApp, 5, true)
        showHotWindow(app, focusedScreen)
        transformWindow(app, focusedScreen)
        return
    end
    if app:isFrontmost() then
        app:hide()
        return
    end
    showHotWindow(app, focusedScreen)
    transformWindow(app, focusedScreen)
end

function HotTerm:init()
    hs.hotkey.bind({ "cmd", "alt" }, "space", toggleTerminal)
end

return HotTerm
