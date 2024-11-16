local terminalApp = "org.alacritty"
hs.window.animationDuration = 0

local HotTerm = {}

HotTerm.__index = HotTerm

local function transformWindow(app)
    local mouseScreen = hs.mouse.getCurrentScreen()
    local screenFrame = mouseScreen:frame()
    local termWindow = app:mainWindow()
    termWindow:setFrame(hs.geometry.rect(screenFrame.x, screenFrame.y, screenFrame.w, screenFrame.h - 400), 0)
end

local function showHotWindow(app)
    local mouseScreen = hs.mouse.getCurrentScreen()
    if not mouseScreen then
        hs.alert.show("No mouse screen found for hotkey terminal")
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

function toggleTerminal()
    local app = hs.application.find(terminalApp)

    if not app then
        app = hs.application.open(terminalApp, 5, true)
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
    hs.hotkey.bind({ "cmd", "alt" }, "space", toggleTerminal)
end

return HotTerm
