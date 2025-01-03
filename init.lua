hs.window.animationDuration = 0

local HotTerm = {}
local terminalApp = "Kitty"
local screenHeight = 350

HotTerm.__index = HotTerm

local function transformWindow(appWindow)
    local screenFrame = hs.screen.mainScreen():frame()
    appWindow:setFrame(hs.geometry.rect(screenFrame.x, screenFrame.y, screenFrame.w, screenFrame.h - screenHeight), 0)
end

local function showHotWindow(app)
    local currentSpace = hs.spaces.activeSpaceOnScreen()
    local appWindow = app:mainWindow()
    hs.spaces.moveWindowToSpace(appWindow, currentSpace)
    appWindow:focus()
    return appWindow
end

local function toggleTerminal()
    local app = hs.application.get(terminalApp)
    if app and app:isFrontmost() then
        app:hide()
        return
    end
    -- local currentScreen = hs.screen.mainScreen()
    -- local screenUUID = currentScreen:getUUID()
    -- local allSpaces = hs.spaces.allSpaces()
    -- local allSpacesForScreen = allSpaces[screenUUID]
    -- local currentSpace = hs.spaces.activeSpaceOnScreen()
    -- local appWindow = app:mainWindow()
    -- local windowSpaces = hs.spaces.windowSpaces(appWindow)
    -- hs.spaces.moveWindowToSpace(appWindow, currentSpace)
    -- appWindow:focus()
    -- hs.spaces.moveWindowToSpace(app:mainWindow(), hs.spaces.focusedSpace(), true)
    -- app:setFrontmost()
    -- app = hs.application.open(terminalApp, 5, true)
    -- showHotWindow(app)
    -- transformWindow(app, hs.screen.mainScreen())
    
    local appWindow = showHotWindow(app)
    transformWindow(appWindow)
end

function HotTerm:init()
    hs.hotkey.bind({ "cmd", "alt" }, "space", toggleTerminal)
end

return HotTerm
