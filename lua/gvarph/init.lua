local function init()
    require 'gvarph.vim'.init()
    require 'gvarph.theme'.init()
    require 'gvarph.languages'.init()
    require 'gvarph.telescope'.init()
    require 'gvarph.floaterm'.init()
    require 'gvarph.copilot'.init()
end

return {
    init = init,
}
