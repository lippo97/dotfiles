import XMonad

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.ManageHook
import XMonad.Util.NamedScratchpad
import XMonad.Prompt
import XMonad.Prompt.Workspace
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.Circle
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spiral
import XMonad.Layout.Fullscreen
import XMonad.Layout.LayoutHints
import XMonad.Actions.WorkspaceNames
import XMonad.Config.Gnome
import Data.Char
import Data.List
import Data.Function
import Graphics.X11.ExtraTypes.XF86
import System.IO

import qualified DBus as D
import qualified DBus.Client as D

myModMask = mod4Mask
myTerminal = "st"
myBorderWidth = 3
myNormalBorderColor = "#c0c0c0"
myFocusedBorderColor = "#b35959"

-- Workspace stuff
xmobarEscape = concatMap doubleLts
  where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

namedWorkspaces = [
      "home"
    , "dev"
    , "doc"
    , "www"
    , "media"
    , "tmp"
  ]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape)
                $ namedWorkspaces
  where
        clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                      (i,ws) <- zip [1..length namedWorkspaces] l,
                      let n = i ]

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    [ ((modMask,               xK_Return)       , spawn $ XMonad.terminal conf)
    , ((modMask,               xK_d     )       , spawn "rofi -show run")
    , ((modMask,               xK_f     )       , spawn "firefox -P default")
    , ((modMask .|. shiftMask, xK_q)            , spawn "shutdown_dmenu")
    , ((modMask .|. shiftMask, xK_v)            , spawn "st -e vim ~/.vimrc")
    , ((modMask .|. shiftMask, xK_c)            , spawn "st -e vim ~/.xmonad/xmonad.hs")
    , ((modMask .|. shiftMask, xK_b)            , spawn "st -e vim ~/.xmobar/xmobarrc")

    -- , ((modMask              , xK_x)            , spawn "xmodmap ~/.Xmodmap")

    -- close focused window
    , ((modMask,               xK_q), kill)

     -- Rotate through the available layout algorithms
    , ((modMask,               xK_Tab ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modMask,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modMask,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modMask,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modMask,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modMask,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modMask,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

     --toggle the status bar gap
    , ((modMask              , xK_b     ), sendMessage ToggleStruts)

    -- Restart xmonad
    , ((modMask .|. shiftMask, xK_r     ),
       broadcastMessage ReleaseResources >> restart "xmonad" True)

    --, ((modMask              , xK_g     ),
       --workspacePrompt  myXPConfig (windows . W.greedyView))
    --, ((modMask .|. shiftMask, xK_g     ),
       --workspacePrompt  myXPConfig (windows . W.shift))
    ]

    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

    ++

    [ ((0, xF86XK_MonBrightnessDown)            , spawn "xbacklight -5 -time 0")
    , ((0, xF86XK_MonBrightnessUp)              , spawn "xbacklight +5 -time 0")
    , ((0, xF86XK_AudioRaiseVolume)             , spawn "pamixer -i 5")
    , ((0, xF86XK_AudioLowerVolume)             , spawn "pamixer -d 5")
    , ((0, xF86XK_AudioMute)                    , spawn "pamixer -t")]

    ++
    [ ((modMask, xK_space), spawn "togglexkbmap")
    ]

-- myLayout = avoidStruts $ layoutHook defaultConfig
myLayout = avoidStruts $
           tiled
           ||| Mirror tiled
           ||| Full
           ||| tabbed shrinkText defaultTheme
           ||| threeCol
--           ||| spiral (4/3)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     threeCol = ThreeCol nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 2/100

myManageHook = composeAll [
    manageDocks
  , fullscreenManageHook
  , isFullscreen --> doFullFloat
  , manageHook gnomeConfig
  ]

myEventHook = handleEventHook def <+> XMonad.Layout.Fullscreen.fullscreenEventHook <+> XMonad.Hooks.EwmhDesktops.fullscreenEventHook <+> hintsEventHook


-- hack to let firefox fullscreen

myBarHook = spawn "gnome-panel"
myAutostartHook = spawn "~/.scripts/autostart.sh"
myStartupHook = startupHook def <+> setFullscreenSupported <+> myBarHook <+> myAutostartHook

setFullscreenSupported :: X ()
setFullscreenSupported = withDisplay $ \dpy -> do
    r <- asks theRoot
    a <- getAtom "_NET_SUPPORTED"
    c <- getAtom "ATOM"
    supp <- mapM getAtom ["_NET_WM_STATE_HIDDEN"
                         ,"_NET_WM_STATE_FULLSCREEN" -- XXX Copy-pasted to add this line
                         ,"_NET_NUMBER_OF_DESKTOPS"
                         ,"_NET_CLIENT_LIST"
                         ,"_NET_CLIENT_LIST_STACKING"
                         ,"_NET_CURRENT_DESKTOP"
                         ,"_NET_DESKTOP_NAMES"
                         ,"_NET_ACTIVE_WINDOW"
                         ,"_NET_WM_DESKTOP"
                         ,"_NET_WM_STRUT"
                         ]
    io $ changeProperty32 dpy r a c propModeReplace (fmap fromIntegral supp)
    setWMName "LG3D"

myLogHook = ewmhDesktopsLogHook

main = do
  xmonad $ docks $ ewmh gnomeConfig {
    modMask            = myModMask
    , terminal           = myTerminal
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , workspaces         = myWorkspaces

                           -- key bindings
    , keys               = myKeys
    , layoutHook         = myLayout
    , manageHook         = myManageHook
    , handleEventHook    = myEventHook
    , startupHook        = myStartupHook
    , logHook            = myLogHook
                           --
    -- , logHook = dynamicLogWithPP xmobarPP
    --             {
    --               ppOutput = hPutStrLn xmproc
    --             , ppCurrent = xmobarColor "#b3af5a" ""
    --             , ppHidden = xmobarColor "#c0c0c0" "" . wrap "•" "" . removeNSP
    --             , ppHiddenNoWindows = xmobarColor "#c0c0c0" "" . removeNSP
    --             , ppUrgent  = xmobarColor "red" ""
    --             , ppTitle   = \x -> ""
    --             , ppLayout = \xs -> ""
    --             }
    }


-- removeNSP :: String -> String
-- removeNSP "NSP" = ""
-- removeNSP x = x
