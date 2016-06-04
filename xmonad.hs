
import XMonad

import XMonad.Actions.CycleWS      -- keys to cycle WS'
import XMonad.Actions.SpawnOn      -- for SpawnHere and SpawnOn

import XMonad.Hooks.DynamicLog     -- statusbar
import XMonad.Hooks.ManageDocks    -- dock/tray mgmt

import XMonad.Layout.NoBorders     -- for smartBorders
import XMonad.Layout.PerWorkspace  -- for onWorkspace

import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W

import XMonad.Wallpaper

--main = xmonad =<< xmobar myConfig

main = do
  setRandomWallpaper ["/home/jrw/.xmonad/wallpaper"]
  xmonad =<< xmobar myConfig

-- See below for the definitions used here.
myConfig = def --defaultConfig
         { terminal           = myTerminal
         , focusFollowsMouse  = myFocusFollowsMouse
         , borderWidth        = myBorderWidth
         , modMask            = myModMask
         , workspaces         = myWorkspaces
         , normalBorderColor  = myNormalBorderColor
         , focusedBorderColor = myFocusedBorderColor
         -- , keys               = myKeys
         -- , mouseBindings      = myMouseBindings
         , layoutHook         = smartBorders $ avoidStruts $ myLayoutHook
         , manageHook         = myManageHook <+> manageDocks <+> manageHook def
         , handleEventHook    = docksEventHook <+> handleEventHook def
         -- , logHook            = myLogHook
         , startupHook        = myStartupHook
         } `additionalKeys` myKeys `additionalKeysP` myKeysP

-- My Preferences --

myModMask            = winMask
myTerminal           = "urxvt"
myShell              = "zsh"
--myBackground         = "feh --bg-scale ~/.xmonad/wallpaper/haskell-pattern.png"
myBrowser            = "chromium --cipher-suite-blacklist=0x0033,0x0039,0x009E,0xcc15"  -- remove compromised DHE ciphers
myBorderWidth        = 1  -- in pixels
myNormalBorderColor  = "#ff0000"  -- red, unfocused
myFocusedBorderColor = "#dddddd"  -- grey, focused
myFocusFollowsMouse  = True
myWorkspaces         = map show [1..9]

myStartupHook        = spawnHere myTerminal -- >> spawnOn "2" myBrowser  -- spawnOn still doesn't seem to work!

myManageHook         = composeAll
                       [ className =? "feh"    --> doFloat
                       , className =? "Geeqie" --> doFloat
                       , className =? "Gimp  " --> doFloat                         
                       --, className =? "Chromium" --> doShift "2"
                       ]

myLayoutHook         = onWorkspace "2" (Full ||| tiled ||| Mirror tiled) $
                       tiled ||| Mirror tiled ||| Full
                       where
                           tiled = Tall nmaster delta ratio
                           nmaster = 1
                           delta = 3/100
                           ratio = 1/2

myKeys = [ ((laltMask .|. shiftMask   , xK_Right  ) , nextWS                             )
         , ((laltMask .|. shiftMask   , xK_Left   ) , prevWS                             )
         , ((laltMask .|. controlMask , xK_Right  ) , shiftToNext >> nextWS              )
         , ((laltMask .|. controlMask , xK_Left   ) , shiftToPrev >> prevWS              )
         , ((laltMask                 , xK_Tab    ) , windows W.focusDown                )
         , ((winMask                  , xK_w      ) , kill                               )
         , ((laltMask                 , xK_Return ) , spawn myTerminal                   )
         , ((laltMask .|. shiftMask   , xK_Return ) , spawn myBrowser                    )
         , ((0                        , xK_Print  ) , spawn screenshotCmd                )
         , ((controlMask              , xK_Print  ) , spawn windowshotCmd                )
         , ((winMask  .|. shiftMask   , xK_z      ) , spawn screenlockCmd                )
         ]

myKeysP = [ (lowerVolumeKey  , spawn lowerVolumeCmd )
          , (raiseVolumeKey  , spawn raiseVolumeCmd )
          , (muteVolumeKey   , spawn muteVolumeCmd  )
          , (sleepKey        , spawn sleepCmd       )
          , (powerKey        , spawn powerCmd       )
          ]


--- Some descriptive shortcuts

laltMask = mod1Mask -- left alt
raltMask = mod3Mask -- right alt
winMask  = mod4Mask -- windows key

lowerVolumeKey = "<XF86AudioLowerVolume>"
raiseVolumeKey = "<XF86AudioRaiseVolume>"
muteVolumeKey  = "<XF86AudioMute>"
sleepKey       = "<XF86Sleep>"
powerKey       = "<XF86PowerOff>"

lowerVolumeCmd = "amixer set Master 5%-"
raiseVolumeCmd = "amixer set Master unmute; amixer set Master 5%+"
muteVolumeCmd  = "amixer set Master toggle"
sleepCmd       = "systemctl suspend"
powerCmd       = "systemctl poweroff"

screenshotCmd  = "scrot; mpg123 ~/.sfx/camera-shutter-click-01.mp3"
windowshotCmd  = "sleep 0.2; scrot -s; mpg123 ~/.sfx/camera-shutter-click-01.mp3"
screenlockCmd  = "xscreensaver-command -lock"
