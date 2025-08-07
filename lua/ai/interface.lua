-- Intelligence class equivalent in Lua for AI-powered note organization
local secrets = require("ai.secrets")
local prompts = require("ai.prompts")

local M = {}

-- Intelligence class
local Intelligence = {}
Intelligence.__index = Intelligence

-- Constructor
function Intelligence:new(config)
  local obj = {
    config = config or {
      api_key = secrets.DEFAULT_CONFIG.API_KEY,
      base_url = secrets.DEFAULT_CONFIG.BASE_URL,
      model = secrets.DEFAULT_CONFIG.MODEL
    },
    curl_available = vim.fn.executable("curl") == 1
  }
  
  setmetatable(obj, Intelligence)
  return obj
end


-- Check if API key is configured
function Intelligence:_check_api_key()
  if not self.config.api_key or self.config.api_key == "" then
    error(secrets.ERROR_MESSAGES.API_KEY_REQUIRED)
  end
end

-- Make HTTP request using curl
function Intelligence:_make_request(url, headers, data)
  if not self.curl_available then
    error("curl is required but not available")
  end

  -- Create temporary file for response
  local temp_file = vim.fn.tempname()
  
  -- Build curl command
  local curl_cmd = {
    "curl",
    "-s",
    "-X", "POST",
    "-H", "Content-Type: application/json",
    "-o", temp_file
  }
  
  -- Add headers
  for _, header in ipairs(headers) do
    table.insert(curl_cmd, "-H")
    table.insert(curl_cmd, header)
  end
  
  -- Add data and URL
  table.insert(curl_cmd, "-d")
  table.insert(curl_cmd, vim.fn.json_encode(data))
  table.insert(curl_cmd, url)
  
  -- Execute curl command
  local result = vim.fn.system(curl_cmd)
  
  -- Read response from temp file
  local response_content = vim.fn.readfile(temp_file)
  vim.fn.delete(temp_file)
  
  if vim.v.shell_error ~= 0 then
    error("HTTP request failed: " .. result)
  end
  
  -- Parse JSON response
  local response_text = table.concat(response_content, "\n")
  if response_text == "" then
    error("Empty response from API")
  end
  
  local ok, response = pcall(vim.fn.json_decode, response_text)
  if not ok then
    error("Failed to parse JSON response: " .. response_text)
  end
  
  return response
end


-- Make chat completion request
function Intelligence:_chat_completion(messages, max_tokens)
  self:_check_api_key()
  
  local url = self.config.base_url .. "/chat/completions"
  local headers = {
    "Authorization: Bearer " .. self.config.api_key
  }
  
  local data = {
    model = self.config.model,
    messages = messages,
    temperature = secrets.AI_CONFIG.TEMPERATURE
  }
  
  if max_tokens then
    data.max_tokens = max_tokens
  end
  
  local response = self:_make_request(url, headers, data)
  
  if not response.choices or #response.choices == 0 then
    error("No response from AI model")
  end
  
  return response.choices[1].message.content
end

-- Process message and update notes
function Intelligence:process_message(message, current_content)
  local system_prompt = prompts.smart_append(current_content, message)
  
  local ok, updated_content = pcall(function()
    return self:_chat_completion({
      { role = "system", content = system_prompt }
    })
  end)
  
  if not ok then
    error(secrets.ERROR_MESSAGES.AI_API_ERROR .. ": " .. updated_content)
  end
  
  -- Generate summary
  local summary_prompt = prompts.smart_summary(message)
  local summary_ok, summary = pcall(function()
    return self:_chat_completion({
      { role = "system", content = summary_prompt }
    }, secrets.AI_CONFIG.MAX_SUMMARY_TOKENS)
  end)
  
  local final_summary = summary_ok and summary or secrets.SUCCESS_MESSAGES.NOTE_UPDATED
  if final_summary then
    final_summary = final_summary:gsub("^%s*(.-)%s*$", "%1") -- trim whitespace
  end
  
  return {
    success = true,
    updated_content = updated_content or "",
    message = final_summary or secrets.SUCCESS_MESSAGES.NOTE_UPDATED
  }
end

-- Reorganize note content
function Intelligence:reorganize_note(current_content)
  local reorganize_prompt = prompts.smart_reorganize(current_content)
  
  local ok, reorganized_content = pcall(function()
    return self:_chat_completion({
      { role = "system", content = reorganize_prompt }
    })
  end)
  
  if not ok then
    error(secrets.ERROR_MESSAGES.AI_API_ERROR .. ": " .. reorganized_content)
  end
  
  return {
    success = true,
    updated_content = reorganized_content or "",
    message = secrets.SUCCESS_MESSAGES.NOTE_REORGANIZED
  }
end

-- Export the Intelligence class constructor
M.Intelligence = Intelligence

return M