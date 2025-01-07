return {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  config = function() 
    require'nvim-treesitter.configs'.setup {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },

      injections = {
        sql_in_python = [[
        ; Match regular SQL strings with placeholders
        (string) @sql (#match? @sql "(SELECT|INSERT|UPDATE|DELETE).*%s")

        ; Match psycopg.sql.SQL() patterns
        (call_expression
          function: (attribute (identifier) @func (#eq? @func "SQL"))  
          arguments: (argument_list (string) @sql)
        )
        ]],
      },
    }
  end
}
