{ ... }:

{
  home._.programs.vscode.keybindings = [
    {
      key = "ctrl+k d";
      command = "editor.action.formatDocument";
    }
    {
      key = "ctrl+k ctrl+d";
      command = "editor.action.formatDocument";
    }
    {
      key = "ctrl+alt+1";
      command = "workbench.action.terminal.toggleTerminal";
    }
    {
      key = "alt+1";
      command = "workbench.view.explorer";
      when = "!explorerViewletVisible";
    }
    {
      key = "alt+1";
      command = "workbench.action.toggleSidebarVisibility";
      when = "explorerViewletVisible";
    }
    {
      key = "alt+2";
      command = "workbench.view.search";
      when = "!searchViewletVisible";
    }
    {
      key = "alt+2";
      command = "workbench.action.toggleSidebarVisibility";
      when = "searchViewletVisible";
    }
    {
      key = "alt+3";
      command = "workbench.view.extensions";
    }
    {
      key = "ctrl+cmd+1";
      command = "workbench.action.terminal.toggleTerminal";
    }
    {
      key = "cmd+1";
      command = "workbench.view.explorer";
      when = "!explorerViewletVisible";
    }
    {
      key = "cmd+1";
      command = "workbench.action.toggleSidebarVisibility";
      when = "explorerViewletVisible";
    }
    {
      key = "cmd+2";
      command = "workbench.view.search";
      when = "!searchViewletVisible";
    }
    {
      key = "cmd+2";
      command = "workbench.action.toggleSidebarVisibility";
      when = "searchViewletVisible";
    }
    {
      key = "cmd+3";
      command = "workbench.view.extensions";
    }
    {
      key = "shift+escape";
      command = "workbench.action.toggleSidebarVisibility";
      when = "!editorFocus && !inDebugRepl && !problemFocus && !terminalFocus";
    }
    {
      key = "shift+escape";
      command = "workbench.action.terminal.toggleTerminal";
      when = "terminalFocus";
    }
    {
      key = "ctrl+t";
      command = "workbench.action.quickOpen";
    }
    {
      key = "alt+enter";
      command = "editor.action.quickFix";
      when = "editorTextFocus";
    }
    {
      key = "cmd+enter";
      command = "editor.action.quickFix";
      when = "editorTextFocus";
    }
    {
      key = "ctrl+p";
      command = "-workbench.action.quickOpen";
    }
    {
      key = "ctrl+m";
      command = "workbench.action.toggleMaximizedPanel";
    }
  ];
}
