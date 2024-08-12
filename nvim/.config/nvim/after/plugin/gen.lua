local gen = require('gen')
gen.setup({
    -- model = "mistral",
    -- url = "http://localhost:8080/completion",
    --
    -- model = "mistral:instruct", -- The default model to use.
    -- model = "llama3.1", -- The default model to use.
    model = "llama3.1:70b-instruct-q3_K_S",
    host = "localhost", -- The host running the Ollama service.
    port = "11434", -- The port on which the Ollama service is listening.
    display_mode = "float", -- The display mode. Can be "float" or "split".
    show_prompt = false, -- Shows the Prompt submitted to Ollama.
    show_model = false, -- Displays which model you are using at the beginning of your chat session.
    no_auto_close = false, -- Never closes the window automatically.
    init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
    -- Function to initialize Ollama
    command = function(options)
        return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/generate -d $body"
    end,
    -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
    -- This can also be a command string.
    -- The executed command must return a JSON object with { response, context }
    -- (context property is optional).
    -- list_models = '<omitted lua function>', -- Retrieves a list of model names
    debug = false -- Prints errors and the command which is run.
})

gen.prompts['Process_Text'] = {
  prompt = "$input: \n$text",
  replace = true
}

local prompt = "Proofread and correct the following text, concentrating on grammar and reorganizing ideas if necessary to make the text clearer. Keep to the same academic style and don't cut out any information - all information is important. Don't hesitate to divide the text into several paragraphs, and long sentences into several sentences, only when possible. Don't repeat the same information and avoid pleonasms. Don't use paragraph headings. Don't put references"

gen.prompts['Correct_Accademic'] = {
  prompt = prompt .. ":\n$text",
  replace = true
}

local prompt = "Elaborate the following text. Correct the false information if there is any. Add missing information about the topic. Stay on the topic while adding information do not elaborate on the technologies that came after that as a newer variant of the the method described in the topic even if closely related. The added information should exactly be about the method described in the topic like adding some missing information, adding some research on the method, or adding some example use cases of the method"

gen.prompts['Elaborate_staying_on_topic'] = {
  prompt = prompt .. ":\n$text",
  replace = true
}

vim.keymap.set({ 'n', 'v' }, '<leader>]', ':Gen<CR>')
