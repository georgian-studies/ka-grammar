-- example:
-- `main.lua noun სახლ;1`
-- `main.lua verb წერ;და`
-- `main.lua verb კარგ;და;ავ`
--local service = require("service")
--service:render_word(arg[1], arg[2])


local dictionary = require("modules/dictionary/dictionary")
dictionary.generate("modules/dictionary/dictionary.jsonc", "modules/dictionary/dictionary.html")
