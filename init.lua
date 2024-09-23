local terminalApp = "Alacritty"

hs.window.animationDuration = 0

local HotTerm = {}

HotTerm.__index = HotTerm

local function transformWindow(app)    
    local termWindow = app:mainWindow()
    local termFrame = termWindow:screen():frame()
    local w = app:mainWindow()
    w:setFrame(hs.geometry.rect(termFrame.x, termFrame.y, termFrame.w, termFrame.h / 2),0 )
end

local function showHotWindow(app)
    if app and app:isHidden() then
        app:unhide()
    end
    local spaceId = hs.spaces.focusedSpace()
    local termWindow = app:mainWindow()
    hs.spaces.moveWindowToSpace(termWindow, spaceId, true)
    app:activate()
    app:mainWindow():focus()
end

function toggleTerminal()
    local app = hs.application.find(terminalApp)
    if not app then
        app = hs.application.open(terminalApp)
        showHotWindow(app)
        transformWindow(app)
        return
    end
    if app:isFrontmost() then
        app:hide()
        return
    end
    showHotWindow(app)
    transformWindow(app)
end

function HotTerm:init()
    hs.hotkey.bind({ "cmd", "alt"}, "space", toggleTerminal)
end

return HotTerm
