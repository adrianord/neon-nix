{ ... }:

let
  fontFamily = "JetBrainsMono Nerd Font";
  fontSize = 13;
in
{
  home._.programs.vscode.userSettings = {
    editor = {
      inherit fontFamily fontSize;
      renderWhitespace = "all";
      wordWrap = "off";
      minimap.enabled = false;
      bracketPairColorization.enabled = false;
      lineNumbers = "relative";
      formatOnSave = false;
      formatOnPaste = false;
      insertSpaces = true;
      inlineSuggest.enabled = true;
      stickyScroll.enabled = true;
    };
    explorer = {
      openEditors.visible = 0;
    };
    workbench = {
      sideBar.location = "right";
      editor.enablePreview = false;
      activityBar.visible = true;
      settings.editor = "json";
      startupEditor = "newUntitleFile";
    };
    terminal = {
      copyOnSelection = false;
      integrated = {
        inherit fontFamily fontSize;
        scrollback = 1000000000;
      };
    };
    files = {
      trimTailingWhitespace = true;
      insertFinalNewLine = true;
    };
  };
}
