on start(project, location, panes)

  set HOME to (path to home folder as string)
  set UTILS to ".alfred:shared:utils.scpt"

  set utils to load script alias (HOME & UTILS)

  tell utils
    set appName to project
    set tickTock to tickTock()

    set primaryPaneParams   to item 1 of panes
    set secondaryPaneParams to item 2 of panes
    set tertiaryPaneParams  to item 3 of panes

    set primaryPaneName      to name of (primaryPaneParams   & { name: "primary" })
    set primaryPaneCommand   to exec of (primaryPaneParams   & { exec: "" })
    set secondaryPaneName    to name of (secondaryPaneParams & { name: "secondary" })
    set secondaryPaneCommand to exec of (secondaryPaneParams & { exec: "" })
    set tertiaryPaneName     to name of (tertiaryPaneParams  & { name: "tertiary" })
    set tertiaryPaneCommand  to exec of (tertiaryPaneParams  & { exec: "" })
  end tell

  tell application "iTerm"

    set primaryTerm to (create window with default profile)
    tell primaryTerm
      tell current session
        set name to appName & " | " & primaryPaneName
        write text "cd " & location
        delay tickTock
        tell utils to clearTerminalScreen()
      end tell
    end tell

    set secondaryTerm to (create window with default profile)
    tell secondaryTerm
      tell current session
        set name to appName & " | " & secondaryPaneName
        write text "cd " & location
        if secondaryPaneCommand is not "" then
          write text secondaryPaneCommand
        end if
        delay tickTock
        tell utils to clearTerminalScreen()
      end tell
    end tell

    set tertiaryTerm to (create window with default profile)
    tell tertiaryTerm
      tell current session
        set name to appName & " | " & tertiaryPaneName
        write text "cd " & location
        delay tickTock
        tell utils to clearTerminalScreen()
        if tertiaryPaneCommand is not "" then
          write text tertiaryPaneCommand
        end if
        delay tickTock
      end tell
    end tell

    select primaryTerm
    tell primaryTerm
      tell current session
        write text "kwmc tree restore 2-cols--medium"
        delay tickTock
        tell utils to clearTerminalScreen()
        if primaryPaneCommand is not "" then
          write text primaryPaneCommand
          delay tickTock
          tell utils to clearTerminalScreen()
        end if
        write text "git status"
      end tell
    end tell

  end tell

end start
