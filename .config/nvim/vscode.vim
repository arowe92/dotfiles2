echo "VsCode Enabled"

nnoremap gk <cmd>call VSCodeNotify("editor.action.revealDefinition")<CR>
nnoremap gf <cmd>call VSCodeNotify("extension.searchFileUnderCursor")<CR>
nnoremap gh <cmd>call VSCodeNotify("editor.action.showDefinitionPreviewHover")<CR>

nnoremap <leader>\ <cmd>call VSCodeNotify("workbench.action.toggleSidebarVisibility")<CR>
nnoremap <leader>= <cmd>call VSCodeNotify("workbench.action.increaseViewWidth")<CR>
nnoremap <leader>- <cmd>call VSCodeNotify("workbench.action.decreaseViewWidth")<CR>

" Focuses
nnoremap <leader>fp <cmd>call VSCodeNotify("workbench.action.focusPanel")<CR>
nnoremap <leader>f] <cmd>call VSCodeNotify("workbench.action.focusAuxiliaryBar")<CR>
nnoremap <leader>f[ <cmd>call VSCodeNotify("workbench.action.focusSideBar")<CR>
nnoremap <leader>ft <cmd>call VSCodeNotify("terminal.focus")<CR>
nnoremap <leader>fo <cmd>call VSCodeNotify("workbench.panel.output.focus")<CR>
nnoremap <leader>fu <cmd>call VSCodeNotify("outline.focus")<CR>
nnoremap <leader>fe <cmd>call VSCodeNotify("workbench.files.action.focusFilesExplorer")<CR>

" Toggles
nnoremap <leader>tp <cmd>call VSCodeNotify("workbench.action.togglePanel")<CR>
nnoremap <leader>t] <cmd>call VSCodeNotify("workbench.action.toggleAuxiliaryBar")<CR>
nnoremap <leader>t[ <cmd>call VSCodeNotify("workbench.action.toggleSidebarVisibility")<CR>
nnoremap <leader>tt <cmd>call VSCodeNotify("workbench.action.terminal.toggleTerminal")<CR>
nnoremap <leader>to <cmd>call VSCodeNotify("workbench.action.output.toggleOutput")<CR>
