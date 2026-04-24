''
  [config]

  [templates.mango]
  input_path = '${./mango.conf}'
  output_path = '~/.cache/matugen/mango.conf'
  post_hook = 'mmsg -d reload_config'

  [templates.kitty]
  input_path = '${./kitty.conf}'
  output_path = '~/.cache/matugen/kitty.conf'
  post_hook = 'pkill -USR1 kitty >/dev/null 2>&1'
''
