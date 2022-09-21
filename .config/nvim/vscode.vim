echo "VsCode Enabled"

" Dont Share Clipboard
set clipboard=
nnoremap X "_d

function! Map(keys, cmd)
    execute "nnoremap ".a:keys. " <cmd>call VSCodeNotify(".a:cmd.")<CR>"
endfunction
command! -nargs=+ Map call Map(<f-args>)

Map gk "editor.action.revealDefinition"
Map gf "extension.searchFileUnderCursor"
Map gh "editor.action.showDefinitionPreviewHover"

Map <leader>\\ "workbench.action.toggleSidebarVisibility"
Map <leader><S-\> "workbench.files.action.showActiveFileInExplorer"
Map <leader>= "workbench.action.increaseViewWidth"
Map <leader>- "workbench.action.decreaseViewWidth"

" Focuses
Map <leader>fp "workbench.action.focusPanel"
Map <leader>f] "workbench.action.focusAuxiliaryBar"
Map <leader>f[ "workbench.action.focusSideBar"
Map <leader>ft "terminal.focus"
Map <leader>fo "workbench.panel.output.focus"
Map <leader>fu "outline.focus"
Map <leader>fe "workbench.files.action.focusFilesExplorer"

" Edits
Map <leader>ek "workbench.action.openGlobalKeybindings"

" Toggles
Map <leader>tp "workbench.action.togglePanel"
Map <leader>t] "workbench.action.toggleAuxiliaryBar"
Map <leader>t[ "workbench.action.toggleSidebarVisibility"
Map <leader>tt "workbench.action.terminal.toggleTerminal"
Map <leader>to "workbench.action.output.toggleOutput"
Map <leader>tm "editor.action.toggleMinimap"
Map <leader>tz "workbench.action.toggleZenMode"
Map <leader>tt "workbench.action.toggleTabsVisibility"
Map <leader>tu "outline-map-view.toggleVisibility"
Map <leader>ta "workbench.action.toggleActivityBarVisibility"

Map <leader>x= "outline-map.addDepth"
Map <leader>x- "outline-map.reduceDepth"

" LSP Stuff
Map ]x "editor.action.marker.next"
Map [x "editor.action.marker.prev"
Map <leader>cf "editor.action.formatDocument"
Map <leader>cr "editor.action.rename"
Map <leader>ca "editor.action.autoFix"
Map <leader>cA "editor.action.quickFix"

" Folding Stuff
Map [z "editor.gotoPreviousFold"
Map ]z "editor.gotoNextFold"
Map <leader>za "editor.toggleFold"
Map <leader>z1 "editor.foldLevel1"
Map <leader>z2 "editor.foldLevel2"
Map <leader>z3 "editor.foldLevel3"
Map <leader>z4 "editor.foldLevel4"
Map <leader>z5 "editor.foldLevel5"
Map <leader>z6 "editor.foldLevel6"


