local terminalApp = "Alacritty"

hs.window.animationDuration = 0

local HotTerm = {}

HotTerm.__index = HotTerm

local function transformWindow(w, screenFrame)
    w:setFrame(hs.geometry.rect(screenFrame.x, screenFrame.y, screenFrame.w, screenFrame.h / 2),0 )
end

function toggleTerminal()
    local app = hs.application.find(terminalApp)
    if app and app:isHidden() then
        app:unhide()
        return
    end
    if not app then
        app = hs.application.open(terminalApp)
        transformWindow(app:mainWindow(), app:mainWindow():screen():frame())
        return
    end
    if app:isFrontmost() then
        app:hide()
        return
    end
    local spaceId = hs.spaces.focusedSpace()
    local termWindow = app:mainWindow()
    local termFrame = termWindow:screen():frame()
    hs.spaces.moveWindowToSpace(termWindow, spaceId, true)
    transformWindow(termWindow, termFrame)
    app:setFrontmost(true)
    app:activate()
end

function HotTerm:init()
    hs.hotkey.bind({ "cmd", "alt"}, "space", toggleTerminal)
end

return HotTerm
