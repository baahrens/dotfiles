-- local banner = [[
--      __....__                                           _..-'"`""+"'-.
--    ."`.._____`"-._                                  _.-"__...-----\""'\
--  ,'..._      '""-.`._                            _.'_."'       __..\---|
-- ( :    "..__     _,'."-._                      ,'_.'__`.----""'     \ /
--  . \        `",+'--.+`-..`.   o           o  .'-"   \  _.".-"''"""`"'/
--   \"`.+"'----+----.'       `.  .        .' ,'       .'" ___"._____,'.
--    \  .   __/......`.__      `. `.     ' ." __..--'"+'""     \    :-|
--     \-:--"  :      /__ `'"-.._ \  \   / /.-'__..---""`."'----.\___; '
--      .: _..+.--"'"/   `"--..__`_`. \ / /.-'"           `.     :   :7
--      ':"  .'    .'--------""'   `.(_X_)'"'"'"`----""'`'--`-''".--.'
--       \._.'-'""/    ______        / ^ \ _....--------...__`._'_."
--        `.\_`."_..."",---. `""`'"": / \ :____    .""`"._   "-."
--          `"",._...'"    '__..-''"`j   \'.   `"-;      ,`"""`.`.
--           ,".'    :      \     .'.| " |\ `.   /       `      \ \
--          '.'...--".       \  ,' / | - | .  "-/       ."`-.._  : .
--         j":     _,'_       .'  /  | = | '   /       ,-\     `.:.|
--         | .  _.'    ;      :  /   } = {  \ j       _\  `._    ' :
--         | ',"     .'".      ./    `._,'   ':      :  \    "._: j
--         '.':    ,"   ,".    .              \     ,-.  `._    '"|
--          \ `  .'    /   :_  '               \   :   \    `._/ j
--           . `'     /   /  \/                 ."".    \      : |
--           ; :     /   /   /                  "   \    \     ; :
--         ,'   \__.'___/__.'                    `.__\____\__.'   `.
--       .'  .'".  _....-"                          "--...._  ,--.  `.
--       `--'    `"                                         `"    `--"
--       ]]
local header = [[
           __  _
       .-.'  `; `-._  __  _
      (_,         .-:'  `; `-._
    ,'o"(        (_,           )
   (__,-'      ,'o"(            )>
      (       (__,-'            )
       `-'._.--._(             )
          |||  |||`-'._.--._.-'
                     |||  |||
                     ]]

local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'

dashboard.section.buttons.val = {
  dashboard.button("p", "Files", function() require("plugin/telescope_pickers").find_files() end),
  dashboard.button("g", "Git status", function() require("plugin/fugitive").git_status() end)
}

dashboard.config.opts.noautocmd = true
dashboard.section.header.val = header
dashboard.section.footer.val = ""
alpha.setup(dashboard.config)
