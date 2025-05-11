{ config, ... }:

let
  fontFamily = "JetBrainsMono Nerd Font";
  fontSize = config.neon.common.font.size;
in
{
  home._.programs.vscode.profiles.default.userSettings = {
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
      rulers = [ 120 ];
    };
    explorer = {
      openEditors.visible = 0;
      confirmDelete = false;
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
