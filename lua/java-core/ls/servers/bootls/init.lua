local config = require('java-core.ls.servers.bootls.config')
local log = require('java-core.utils.log')
local path = require('java-core.utils.path')
local mason = require('java-core.utils.mason')

local M = {}

function M.get_config(opts)
	log.debug('XXX generating bootls config')

  local sts4_root = mason.get_shared_path('sts4')
  local bootls_root = mason.get_shared_path('bootls')
	log.debug('XXX sts4 root: ', sts4_root)
	log.debug('XXX bootls root: ', bootls_root)
	local classes_root = path.join(bootls_root, 'BOOT-INF', 'classes')
	local application_properties = path.join(classes_root, 'application.properties')
	local lib_root = path.join(bootls_root, 'BOOT-INF', 'lib', '*')
	local base_config = config.get_config()
	log.debug('XXX orig bootls config: ', base_config)

	base_config.cmd = {
		'java',
		'-cp',
		-- '/home/jvalkealahti/.local/share/nvim-java3/mason/packages/sts4/extension/language-server/BOOT-INF/classes:/home/jvalkealahti/.local/share/nvim-java3/mason/packages/sts4/extension/language-server/BOOT-INF/lib/*',
		classes_root .. ":" .. lib_root,
    '-XX:+HeapDumpOnOutOfMemoryError',
    '-Xmx1024m',
    '-Dsts.lsp.client=vscode',
    '-Dsts.log.file=/tmp/bootls.log',
    '-XX:TieredStopAtLevel=1',
    '-Xlog:jni+resolve=off',
		'-Dlogging.level.org.springframework=debug',
    -- '-Dspring.config.location=file:/home/jvalkealahti/.local/share/nvim-java3/mason/packages/sts4/extension/language-server/BOOT-INF/classes/application.properties',
    '-Dspring.config.location=file:' .. application_properties,
    'org.springframework.ide.vscode.boot.app.BootLanguageServerBootApp',
	}

	log.debug('XXX generated bootls setup config: ', base_config)
	return base_config
end



return M

