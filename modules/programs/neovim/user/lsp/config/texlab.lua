return {
  settings = {
    texlab = {
      build = {
        onSave = true,
        executable = "tectonic",
        args = {
          "-X",
          "compile",
          "%f",
          "--synctex",
          "--keep-logs",
          "--keep-intermediates"
        },
      },
    },
  },
};
