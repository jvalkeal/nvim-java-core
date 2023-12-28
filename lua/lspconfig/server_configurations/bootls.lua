local util = require 'lspconfig.util'
local log = require('java-core.utils.log')
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

local function on_sts_addClasspathListener(err, result, ctx, config)
	log.debug('calling on_sts_addClasspathListener err ', err)
	log.debug('calling on_sts_addClasspathListener result ', result)
	log.debug('calling on_sts_addClasspathListener ctx ', ctx)
	log.debug('calling on_sts_addClasspathListener config', config)
	return {}
end

return {
	default_config = {
		-- cmd = {
		-- 	'java',
		-- 	'-cp',
		-- 	'/home/jvalkealahti/.local/share/nvim-java3/mason/packages/sts4/extension/language-server/BOOT-INF/classes:/home/jvalkealahti/.local/share/nvim-java3/mason/packages/sts4/extension/language-server/BOOT-INF/lib/*',
  --     '-XX:+HeapDumpOnOutOfMemoryError',
  --     '-Xmx1024m',
  --     '-Dsts.lsp.client=vscode',
  --     -- '-Dsts.log.file=/dev/null',
  --     '-Dsts.log.file=/tmp/bootls.log',
  --     '-XX:TieredStopAtLevel=1',
  --     '-Xlog:jni+resolve=off',
		-- 	'-Dlogging.level.org.springframework=debug',
  --     '-Dspring.config.location=file:/home/jvalkealahti/.local/share/nvim-java3/mason/packages/sts4/extension/language-server/BOOT-INF/classes/application.properties',
  --     'org.springframework.ide.vscode.boot.app.BootLanguageServerBootApp',
		-- },
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
			['sts/addClasspathListener'] = on_sts_addClasspathListener
		}
	}
}

