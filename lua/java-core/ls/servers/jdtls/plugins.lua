local mason = require('java-core.utils.mason')
local path = require('java-core.utils.path')
local file = require('java-core.utils.file')
local log = require('java-core.utils.log')

local List = require('java-core.utils.list')

local M = {}

local plugin_to_jar_path_map = {
	-- ['java-test'] = '*.jar',
	-- ['java-debug-adapter'] = '*.jar',
	['java-test'] = {
		'com.microsoft.java.test.plugin-*.jar',
		'junit-*.jar',
		'org.apiguardian.api_-*.jar',
		'org.eclipse.*.jar',
		'org.opentest4j_*.jar',
	},
	['java-debug-adapter'] = {'*.jar'},
}

---Returns a list of .jar file paths for given list of jdtls plugins
---@param plugins string[]
---@return string[] # list of .jar file paths
function M.get_plugin_paths(plugins)
	local plugin_paths = List:new()

	for _, plugin in ipairs(plugins) do
		-- local relative_path = plugin_to_jar_path_map[plugin]
		-- local plugin_shared_path = mason.get_shared_path(plugin)
		-- local full_path = path.join(plugin_shared_path, relative_path)
		-- local resolved_paths = file.get_file_list(full_path)
		-- plugin_paths:push(resolved_paths)
		-- log.debug('resolved paths1', plugin)
		-- log.debug('resolved paths2', resolved_paths)

		local relative_paths = plugin_to_jar_path_map[plugin]
		local plugin_shared_path = mason.get_shared_path(plugin)
		for _, pattern in ipairs(relative_paths) do
		  local full_path = path.join(plugin_shared_path, pattern)
		  local resolved_paths = file.get_file_list(full_path)
		  plugin_paths:push(resolved_paths)
		  log.debug('resolved paths1', plugin)
		  log.debug('resolved paths2', pattern)
		  log.debug('resolved paths3', resolved_paths)
		end

	end

	return plugin_paths:flatten()
end

return M
