local log = require('java-core.utils.log')
local List = require('java-core.utils.list')

local M = {}

---Returns the client by name of the language server
---@param name string name of the language server
---@return LspClient | nil
function M.find_client_by_name(name)
	local clients = List:new(vim.lsp.get_active_clients())
	log.info('XXX active clients: ', clients)

	return clients:find(function(client)
		return client.name == name
	end)
end

---Returns the jdtls client object
---@return LspClient
function M.get_jdtls_client()
	local client = M.find_client_by_name('jdtls')

	if not client then
		local msg = 'No active jdtls client found'

		log.error(msg)
		error(msg)
	end

	return client
end

function M.execute_command(command, params, callback, bufnr)
  local clients = {}
  local candidates = vim.lsp.get_active_clients({ bufnr = bufnr })
  for _, c in pairs(candidates) do
    local command_provider = c.server_capabilities.executeCommandProvider
    local commands = type(command_provider) == 'table' and command_provider.commands or {}
    if vim.tbl_contains(commands, command.command) then
      table.insert(clients, c)
    end
  end
  local num_clients = vim.tbl_count(clients)
  if num_clients == 0 then
    if bufnr then
      -- User could've switched buffer to non-java file, try all clients
      return M.execute_command(command, params, callback, nil)
    else
      -- vim.notify('No LSP client found that supports ' .. command, vim.log.levels.ERROR)
      vim.notify('No LSP client found that supports ' .. command.command, vim.log.levels.ERROR)
      return
    end
  end

  if num_clients > 1 then
    vim.notify(
      'Multiple LSP clients found that support ' .. command.command .. ' you should have at most one JDTLS server running',
      vim.log.levels.WARN)
  end

  local co
  if not callback then
    co = coroutine.running()
    if co then
      callback = function(err, resp)
        coroutine.resume(co, err, resp)
      end
    end
  end
  -- clients[1].request('workspace/executeCommand', command, callback, bufnr)
  clients[1].request(command, params, callback, bufnr)
  if co then
    return coroutine.yield()
  end
end

return M
