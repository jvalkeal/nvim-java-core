local log = require('java-core.utils.log')

local M = {}

local function on_workspace_executeClientCommand(err, result, ctx, config)
	log.debug('calling on_workspace_executeClientCommand err ', err)
	log.debug('calling on_workspace_executeClientCommand result ', result)
	log.debug('calling on_workspace_executeClientCommand ctx ', ctx)
	log.debug('calling on_workspace_executeClientCommand config', config)
	if (result.command == 'vscode-spring-boot.ls.start') then
		log.debug("XXX should start boot ls")
		require('lspconfig').bootls.setup({})
		require('lspconfig').bootls.launch()
  end
	return {}
end

function M.get_config()
	return {
		init_options = {
			extendedClientCapabilities = {
				classFileContentsSupport = true,
				generateToStringPromptSupport = true,
				hashCodeEqualsPromptSupport = true,
				advancedExtractRefactoringSupport = true,
				advancedOrganizeImportsSupport = true,
				generateConstructorsPromptSupport = true,
				generateDelegateMethodsPromptSupport = true,
				moveRefactoringSupport = true,
				overrideMethodsPromptSupport = true,
				executeClientCommandSupport = true,
				inferSelectionSupport = {
					'extractMethod',
					'extractVariable',
					'extractConstant',
					'extractVariableAllOccurrence',
				},
			},
		},
		handlers = {
			['workspace/executeClientCommand'] = on_workspace_executeClientCommand
		}
	}
end

return M
