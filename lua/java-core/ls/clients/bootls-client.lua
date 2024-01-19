local log = require('java-core.utils.log')
local class = require('java-core.utils.class')
local async = require('java-core.utils.async')
local await = async.wait_handle_error

local JdtlsClient = require('java-core.ls.clients.jdtls-client')


local BootlsClient = class(JdtlsClient)

function BootlsClient:_init(client)
	self:super(client)
end

function BootlsClient:new(args)
	local o = {
		client = (args or {}).client,
	}

	setmetatable(o, self)
	self.__index = self
	return o
end

function BootlsClient:execute_command(command, arguments, buffer)
	log.debug('executing: workspace/executeCommand - ' .. command)

	local cmd_info = {
		command = command,
		arguments = arguments,
	}

	return await(function(callback)
		local on_response = function(err, result)
			if err then
				log.error(command .. ' failed! arguments: ', arguments, ' error: ', err)
			else
				log.debug(command .. ' success! response: ', result)
			end

			callback(err, result)
		end

		return self.client.request(
			'workspace/executeCommand',
			cmd_info,
			on_response,
			buffer
		)
	end)
end

-- function BootlsClient:find_java_projects()
-- 	return self:execute_command(
-- 		'vscode.java.test.findJavaProjects',
-- 		{ vim.uri_from_fname(self.client.config.root_dir) }
-- 	)
-- end

