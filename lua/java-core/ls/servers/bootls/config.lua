local log = require('java-core.utils.log')
-- local util = require 'lspconfig.util'
-- local root_files = {
--   -- Single-module projects
--   {
--     'build.xml', -- Ant
--     'pom.xml', -- Maven
--     'settings.gradle', -- Gradle
--     'settings.gradle.kts', -- Gradle
--   },
--   -- Multi-module projects
--   { 'build.gradle', 'build.gradle.kts' },
-- }

-- local function on_sts_addClasspathListener(err, result, ctx, config)
-- 	log.debug('calling on_sts_addClasspathListener err ', err)
-- 	log.debug('calling on_sts_addClasspathListener result ', result)
-- 	log.debug('calling on_sts_addClasspathListener ctx ', ctx)
-- 	log.debug('calling on_sts_addClasspathListener config', config)
-- 	return {}
-- end

local M = {}

function M.get_config()
	return {
		-- init_options = {
		-- 	extendedClientCapabilities = {
		-- 		executeClientCommandSupport = true,
		-- 	},
		-- },
		-- capabilities = {
		-- 	workspace = {
		-- 		executeCommand = {
		-- 			dynamicRegistration = true
		-- 		}
		-- 	},
		-- },
		-- filetypes = { 'java', 'yaml', 'yml' },
  --   root_dir = function(fname)
  --     for _, patterns in ipairs(root_files) do
  --       local root = util.root_pattern(unpack(patterns))(fname)
  --       if root then
  --         return root
  --       end
  --     end
  --   end,
		-- single_file_support = true,
		-- handlers = {
		-- 	['sts/addClasspathListener'] = on_sts_addClasspathListener
		-- },
	}
end

return M
