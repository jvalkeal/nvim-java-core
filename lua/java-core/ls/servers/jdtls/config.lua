local log = require('java-core.utils.log')

local M = {}

-- local function xxx2()
-- 	log.debug('calling xxx2')
-- end

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
		-- handlers = {
		-- 	['sts/addClasspathListener'] = xxx2
		-- }
	}
end

return M
