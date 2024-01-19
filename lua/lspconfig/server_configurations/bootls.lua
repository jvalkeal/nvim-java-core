local util = require 'lspconfig.util'
local log = require('java-core.utils.log')
local lsp = require('java-core.utils.lsp')

local root_files = {
  -- Single-module projects
  {
    'build.xml', -- Ant
    'pom.xml', -- Maven
    'settings.gradle', -- Gradle
    'settings.gradle.kts', -- Gradle
  },
  -- Multi-module projects
  { 'build.gradle', 'build.gradle.kts' },
}

local function on_sts_addClasspathListenerxxxx(err, result, ctx, config)
	log.debug('calling on_sts_addClasspathListener err ', err)
	log.debug('calling on_sts_addClasspathListener result ', result)
	log.debug('calling on_sts_addClasspathListener result callbackCommandId', result.callbackCommandId)
	log.debug('calling on_sts_addClasspathListener ctx ', ctx)
	log.debug('calling on_sts_addClasspathListener config', config)
	local ret = lsp.execute_command({command = 'sts.java.addClasspathListener'}, {
		callbackCommandId = result.callbackCommandId
	})
	log.debug('XXX calling on_sts_addClasspathListener ret', ret)
	return {}
end

local function on_sts_addClasspathListenerxx(err, result, ctx, config)
	local client = lsp.get_jdtls_client()
	local callback = function (e, res)
		log.debug('XXX callback: ', e, res)
	end
	client.request('workspace/executeCommand', {
			command = 'sts.java.addClasspathListener',
		  arguments = result.callbackCommandId
		}, callback)
	return {}
end

-- local JdtlsClient = require('java-core.ls.clients.jdtls-client')
-- local async = require('java-core.utils.async').sync
-- local await = require('java-core.utils.async').wait
-- local wrap = require('java-core.utils.async').wrap

local function on_sts_addClasspathListener(err, result, ctx, config)
	local client = lsp.get_jdtls_client()
  log.debug('XXX request_sync')
	local r = client.request_sync('workspace/executeCommand', {
		  command = 'sts.java.addClasspathListener',
		  arguments = result.callbackCommandId
		}, 5000)
  log.debug('XXX request_sync done: ', r)
	if not r.err then
    log.debug('XXX request_sync ok')
		return {}
	end
  log.debug('XXX request_sync error')
	return {}
end

local function on_sts_removeClasspathListener(err, result, ctx, config)
	local client = lsp.get_jdtls_client()
  log.debug('XXX request_sync')
	local r = client.request_sync('workspace/executeCommand', {
		  command = 'sts.java.removeClasspathListener',
		  arguments = result.callbackCommandId
		}, 5000)
  log.debug('XXX request_sync done: ', r)
	if not r.err then
    log.debug('XXX request_sync ok')
		return {}
	end
  log.debug('XXX request_sync error')
	return {}
end

return {
	default_config = {
		init_options = {
			extendedClientCapabilities = {
				executeClientCommandSupport = true,
			},
		},
		capabilities = {
			workspace = {
				executeCommand = {
					dynamicRegistration = true
				}
			},
		},
		filetypes = { 'java', 'yaml', 'yml' },
    root_dir = function(fname)
      for _, patterns in ipairs(root_files) do
        local root = util.root_pattern(unpack(patterns))(fname)
        if root then
          return root
        end
      end
    end,
		single_file_support = true,
		handlers = {
			['sts/addClasspathListener'] = on_sts_addClasspathListener,
			['sts/removeClasspathListener'] = on_sts_removeClasspathListener,
		}
	}
}

