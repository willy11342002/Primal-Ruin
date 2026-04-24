@tool
extends VBoxContainer

# ==============================================================================
# 🌍 全域多語言本地化字典 (i18n)
# ==============================================================================
class I18N:
	static var locale: String = "zh_TW" 
	
	const DICT = {
		"zh_TW": {
			"language_setting": "介面語言 (Language):",
			"lang_auto": "跟隨編輯器 (Auto)",
			"default_dir": "預設目錄:",
			"browse_bind": "瀏覽/綁定",
			"search_file": "搜尋檔案名稱...",
			"refresh": "🔄️重新整理",
			"settings": "⚙️設定",
			"edit_template": "📝 修改範本",
			"new_instance": "+ 新建實例",
			"all_global": "All (全域)",
			"all_subclasses": "-- (全部子類別) --",
			"dir_format": "[%s 目錄]:",
			"global_dir": "[全域目錄]:",
			"file_name_global": "File Name (全域內容)",
			"file_name": "File Name",
			"edit_array": "編輯陣列",
			"browse_file": "瀏覽檔案...",
			"open_text_editor": "開啟多行大文字編輯器",
			"complex_obj": "[複雜物件/資源]",
			"select_prefix": "選擇 ",
			"support_file": " ; 支援檔案",
			"all_files": "*.* ; 所有檔案",
			
			"scan_settings": "全域設定與掃描設定",
			"ignore_folders": "🚫 忽略的資料夾",
			"include_folders": "✅ 強制包含例外",
			"add": "+ 新增",
			"delete": "- 刪除",
			
			"edit_array_title": "編輯陣列",
			"add_new_element": "+ 新增元素",
			"editing_prefix": "編輯: ",
			
			"template_wizard_title": "視覺化範本修改器 (定向注入)",
			"existing_vars": "目前已有變數 (懸停查看詳情):",
			"belong_group": "所屬群組:",
			"input_new_group": "輸入新群組名稱...",
			"insert_pos": "插入位置:",
			"new_var_name": "新變數名稱 (英文):",
			"var_doc": "用途說明 (第一行):",
			"var_type": "變數類型:",
			"inject_code": "⚡ 精準注入程式碼",
			"create_group_only": "📦 僅在此處建立新群組 (不加變數)",
			"modify_template_prefix": "定向修改範本: ",
			"group_prefix": "📦 [群組] ",
			"no_group": "[ 無群組 / 根目錄 ]",
			"new_group_opt": "[ + 新建群組... ]",
			"at_group_end": "👇 [在此群組最末尾]",
			"after_var_prefix": "↳ 變數之後: ",
			"at_file_end": "📄 [檔案最末尾]",
			"after_group_prefix": "📦 群組之後: ",
			
			"creator_title": "視覺化新建實例",
			"file_name_no_ext": "檔案名稱 (無副檔名): ",
			"init_prop_config": "👇 初始化屬性設定 (滑鼠懸停屬性名稱可看說明詳情)",
			"path_edit_later": " [路徑，建立後編輯]",
			"uninferred_type": "(未推斷型別) 當作文字處理",
			
			"text_editor_title": "大文字編輯器 (支援多行與自動換行)",
			"editing_long_text": "正在編輯長文字: ",
			"var_name_prefix": "變數名稱: ",
			"inherited_or_no_doc": "繼承或無說明的變數"
		},
		"en": {
			"language_setting": "UI Language:",
			"lang_auto": "Auto (Follow Editor)",
			"default_dir": "Default Dir:",
			"browse_bind": "Browse/Bind",
			"search_file": "Search file name...",
			"refresh": "🔄️Refresh",
			"settings": "⚙️Settings",
			"edit_template": "📝 Edit Template",
			"new_instance": "+ New Instance",
			"all_global": "All (Global)",
			"all_subclasses": "-- (All Subclasses) --",
			"dir_format": "[%s Dir]:",
			"global_dir": "[Global Dir]:",
			"file_name_global": "File Name (Global Content)",
			"file_name": "File Name",
			"edit_array": "Edit Array",
			"browse_file": "Browse File...",
			"open_text_editor": "Open multi-line text editor",
			"complex_obj": "[Complex Object/Resource]",
			"select_prefix": "Select ",
			"support_file": " ; Supported Files",
			"all_files": "*.* ; All Files",
			
			"scan_settings": "Global Config & Scan Settings",
			"ignore_folders": "🚫 Ignored Folders",
			"include_folders": "✅ Force Included Folders",
			"add": "+ Add",
			"delete": "- Delete",
			
			"edit_array_title": "Edit Array",
			"add_new_element": "+ Add New Element",
			"editing_prefix": "Editing: ",
			
			"template_wizard_title": "Visual Template Modifier",
			"existing_vars": "Existing variables (hover for details):",
			"belong_group": "Belonging Group:",
			"input_new_group": "Input new group name...",
			"insert_pos": "Insert Position:",
			"new_var_name": "New Var Name (EN):",
			"var_doc": "Usage Doc (1st line):",
			"var_type": "Variable Type:",
			"inject_code": "⚡ Precision Code Injection",
			"create_group_only": "📦 Create new group only here",
			"modify_template_prefix": "Targeted Modify: ",
			"group_prefix": "📦 [Group] ",
			"no_group": "[ No Group / Root ]",
			"new_group_opt": "[ + New Group... ]",
			"at_group_end": "👇 [At the end of this group]",
			"after_var_prefix": "↳ After variable: ",
			"at_file_end": "📄 [At the end of file]",
			"after_group_prefix": "📦 After group: ",
			
			"creator_title": "Visual Instance Creator",
			"file_name_no_ext": "File Name (No Ext): ",
			"init_prop_config": "👇 Init Properties (Hover for docs)",
			"path_edit_later": " [Path, edit after creation]",
			"uninferred_type": "(Uninferred type) Treated as text",
			
			"text_editor_title": "Large Text Editor (Multi-line & Wrap)",
			"editing_long_text": "Editing long text: ",
			"var_name_prefix": "Var: ",
			"inherited_or_no_doc": "Inherited or undocumented variable"
		}
	}

	static func T(key: String) -> String:
		if DICT.has(locale) and DICT[locale].has(key): return DICT[locale][key]
		if DICT["en"].has(key): return DICT["en"][key]
		return key

# ==============================================================================
# 🌟 核心主類別 (Main Controller)
# ==============================================================================
var plugin: EditorPlugin
var current_pick_mode: int = 0
var current_class_path: Array[String] = []

var config: DBConfig
var scanner: DBScanner
var ui_settings: SettingsDialogUI
var ui_array: ArrayEditorUI
var ui_template: TemplateWizardUI
var ui_creator: AdvancedCreatorUI
var ui_text: TextEditorUI 

var folder_label: Label
var folder_input: LineEdit
var search_bar: LineEdit
var selectors_container: HFlowContainer
var browse_btn: Button
var refresh_btn: Button
var settings_btn: Button
var edit_template_btn: Button
var new_btn: Button
var tree: Tree
var dir_dialog: EditorFileDialog
var cell_file_dialog: EditorFileDialog

var _pending_file_cell_res: Resource
var _pending_file_cell_prop: String

var _sort_col: int = 0
var _sort_asc: bool = true

func _init() -> void:
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	config = DBConfig.new(); config.load_config()
	_apply_language_setting() # 初始化時套用語言
	
	scanner = DBScanner.new(config)
	_build_main_ui()
	_init_sub_dialogs()
	_connect_main_signals()

func _ready() -> void: 
	call_deferred("_initialize_plugin")

func _initialize_plugin() -> void: 
	scanner.extract_global_resource_classes()
	_rebuild_selectors()

# --- 語言熱更新邏輯 ---
func _apply_language_setting() -> void:
	if config.language == "auto":
		if Engine.is_editor_hint() and EditorInterface.get_editor_settings():
			var ed_lang = EditorInterface.get_editor_settings().get_setting("interface/editor/editor_language")
			if I18N.DICT.has(ed_lang): I18N.locale = ed_lang
			elif ed_lang.begins_with("zh_TW") or ed_lang.begins_with("zh_Hant"): I18N.locale = "zh_TW"
			elif I18N.DICT.has(ed_lang.left(2)): I18N.locale = ed_lang.left(2)
			else: I18N.locale = "en"
	else:
		I18N.locale = config.language

func _update_ui_texts() -> void:
	# 1. 重新整理字典環境
	_apply_language_setting()
	
	# 2. 重新整理主介面上的靜態文字
	folder_label.text = I18N.T("dir_format") % _get_active_class_name() if _get_active_class_name() != "" else I18N.T("global_dir")
	browse_btn.text = I18N.T("browse_bind")
	search_bar.placeholder_text = I18N.T("search_file")
	refresh_btn.text = I18N.T("refresh")
	settings_btn.text = I18N.T("settings")
	edit_template_btn.text = I18N.T("edit_template")
	new_btn.text = I18N.T("new_instance")
	
	# 3. 重新整理子視窗的靜態標題
	ui_settings.title = I18N.T("scan_settings")
	ui_settings._refresh_texts() # 通知設定面板重新整理內部文字
	ui_array.title = I18N.T("edit_array_title")
	ui_template.title = I18N.T("template_wizard_title")
	ui_creator.title = I18N.T("creator_title")
	ui_text.title = I18N.T("text_editor_title")
	
	# 4. 重新整理動態清單
	_rebuild_selectors()
	_update_table()

# --- UI 建構邏輯 ---
func _build_main_ui() -> void:
	var row1 = HBoxContainer.new(); add_child(row1)
	folder_label = Label.new(); folder_label.text = I18N.T("default_dir"); folder_label.custom_minimum_size = Vector2(80, 0); folder_label.add_theme_color_override("font_color", Color(1.0, 0.8, 0.4)); row1.add_child(folder_label)
	folder_input = LineEdit.new(); folder_input.size_flags_horizontal = Control.SIZE_EXPAND_FILL; row1.add_child(folder_input)
	browse_btn = Button.new(); browse_btn.text = I18N.T("browse_bind"); row1.add_child(browse_btn)
	browse_btn.pressed.connect(func(): current_pick_mode = 0; dir_dialog.popup_file_dialog())

	var row2 = HBoxContainer.new(); add_child(row2)
	search_bar = LineEdit.new(); search_bar.placeholder_text = I18N.T("search_file"); search_bar.size_flags_horizontal = Control.SIZE_EXPAND_FILL; row2.add_child(search_bar)
	refresh_btn = Button.new(); refresh_btn.text = I18N.T("refresh"); row2.add_child(refresh_btn)
	settings_btn = Button.new(); settings_btn.text = I18N.T("settings"); row2.add_child(settings_btn)
	refresh_btn.pressed.connect(_on_refresh_btn_pressed)
	settings_btn.pressed.connect(func(): ui_settings.open_dialog())

	var row3 = HBoxContainer.new(); add_child(row3)
	selectors_container = HFlowContainer.new(); selectors_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL; row3.add_child(selectors_container)
	row3.add_child(VSeparator.new())
	
	edit_template_btn = Button.new(); edit_template_btn.text = I18N.T("edit_template"); edit_template_btn.add_theme_color_override("font_color", Color(0.4, 0.8, 1.0)); row3.add_child(edit_template_btn)
	new_btn = Button.new(); new_btn.text = I18N.T("new_instance"); new_btn.add_theme_color_override("font_color", Color(0.4, 1.0, 0.4)); row3.add_child(new_btn)

	tree = Tree.new(); tree.size_flags_vertical = Control.SIZE_EXPAND_FILL; tree.hide_root = true; tree.columns = 1; tree.column_titles_visible = true; add_child(tree)
	
	dir_dialog = EditorFileDialog.new(); dir_dialog.file_mode = EditorFileDialog.FILE_MODE_OPEN_DIR; add_child(dir_dialog)
	cell_file_dialog = EditorFileDialog.new(); cell_file_dialog.file_mode = EditorFileDialog.FILE_MODE_OPEN_FILE; add_child(cell_file_dialog)

func _init_sub_dialogs() -> void:
	ui_settings = SettingsDialogUI.new(config); add_child(ui_settings)
	ui_array = ArrayEditorUI.new(); add_child(ui_array)
	ui_template = TemplateWizardUI.new(); add_child(ui_template)
	ui_creator = AdvancedCreatorUI.new(); add_child(ui_creator)
	ui_text = TextEditorUI.new(); add_child(ui_text) 
	
	# 監聽設定面板的更新訊號（例如切換了語言）
	ui_settings.settings_changed.connect(func(): _update_ui_texts(); _on_refresh_btn_pressed())
	
	ui_array.data_changed.connect(func(): _rescan_plugin(); _update_table())
	ui_template.script_modified.connect(func(): _rescan_plugin(); call_deferred("_refresh_current_view"))
	ui_creator.instance_created.connect(func(path): _rescan_plugin(); _refresh_current_view(); if plugin: plugin.get_editor_interface().edit_resource(load(path)))
	ui_text.text_saved.connect(func(): _rescan_plugin(); _update_table()) 
	
func _connect_main_signals() -> void:
	folder_input.text_submitted.connect(_on_folder_input_submitted)
	dir_dialog.dir_selected.connect(_on_dir_selected)
	cell_file_dialog.file_selected.connect(_on_cell_file_selected)
	search_bar.text_changed.connect(func(_t): _update_table())
	edit_template_btn.pressed.connect(func(): ui_template.open_wizard(plugin, _get_active_class_name(), scanner.available_types, scanner))
	new_btn.pressed.connect(func(): ui_creator.open_creator(_get_active_class_name(), scanner.available_types, scanner, _get_current_target_folder()))
	
	tree.item_edited.connect(_on_tree_item_edited)
	tree.cell_selected.connect(_on_tree_cell_selected)
	tree.button_clicked.connect(_on_tree_button_clicked)
	tree.column_title_clicked.connect(_on_column_title_clicked)

# --- 主控調度邏輯 ---
func _get_active_class_name() -> String: 
	return current_class_path.back() if current_class_path.size() > 0 else ""

func _get_current_target_folder() -> String:
	var active_cls = _get_active_class_name()
	return config.class_folder_bindings.get(active_cls, config.default_folder) if active_cls != "" else config.default_folder

func _rescan_plugin() -> void:
	if plugin: plugin.get_editor_interface().get_resource_filesystem().scan()

func _on_dir_selected(dir: String) -> void:
	if not dir.ends_with("/"): dir += "/"
	if current_pick_mode == 0:
		var active_cls = _get_active_class_name()
		if active_cls == "": config.default_folder = dir 
		else: config.class_folder_bindings[active_cls] = dir
		config.save_config()
		_on_selection_hierarchy_changed()

func _on_folder_input_submitted(new_text: String) -> void:
	var active_cls = _get_active_class_name()
	if active_cls == "": config.default_folder = new_text 
	else: config.class_folder_bindings[active_cls] = new_text
	config.save_config()
	_on_selection_hierarchy_changed()

func _rebuild_selectors() -> void:
	for child in selectors_container.get_children(): child.queue_free()
	var lvl0_selected = current_class_path[0] if current_class_path.size() > 0 else ""
	_create_selector_dropdown(0, scanner.root_classes, lvl0_selected)
	var current_parent = ""
	for i in range(current_class_path.size()):
		current_parent = current_class_path[i]
		if scanner.class_hierarchy.has(current_parent) and scanner.class_hierarchy[current_parent].size() > 0:
			var next_sel = current_class_path[i + 1] if i + 1 < current_class_path.size() else ""
			_create_selector_dropdown(i + 1, scanner.class_hierarchy[current_parent], next_sel)
	_on_selection_hierarchy_changed()

func _create_selector_dropdown(level: int, options: Array, selected_val: String) -> void:
	var ob = OptionButton.new()
	ob.add_item(I18N.T("all_global") if level == 0 else I18N.T("all_subclasses"))
	var select_idx = 0
	for i in range(options.size()):
		ob.add_item(options[i])
		if options[i] == selected_val: select_idx = i + 1
	ob.selected = select_idx
	ob.item_selected.connect(func(idx):
		current_class_path.resize(level)
		if idx > 0: current_class_path.append(ob.get_item_text(idx))
		_rebuild_selectors()
	)
	selectors_container.add_child(ob)

func _on_selection_hierarchy_changed() -> void:
	var active_cls = _get_active_class_name()
	new_btn.disabled = (active_cls == "")
	edit_template_btn.disabled = (active_cls == "")
	folder_label.text = I18N.T("dir_format") % active_cls if active_cls != "" else I18N.T("global_dir")
	folder_input.text = _get_current_target_folder()
	_refresh_current_view()

func _refresh_current_view() -> void:
	scanner.all_resources.clear()
	var tf = folder_input.text
	if DirAccess.dir_exists_absolute(tf): scanner.scan_directory(tf)
	_update_table()

func _on_refresh_btn_pressed() -> void: 
	scanner.extract_global_resource_classes()
	_rebuild_selectors()

func _on_column_title_clicked(col: int, _mouse_btn: int) -> void:
	if _sort_col == col: _sort_asc = not _sort_asc
	else: _sort_col = col; _sort_asc = true
	_update_table()

# --- Tree 表格邏輯 ---
func _update_table() -> void:
	tree.clear()
	var root = tree.create_item()
	var filter_text = search_bar.text.to_lower()
	var active_cls = _get_active_class_name()
	
	if active_cls == "":
		_sort_col = 0
		tree.columns = 1
		tree.set_column_title(0, I18N.T("file_name_global") + (" ▲" if _sort_asc else " ▼"))
		var gpaths: Array = []
		for path in scanner.all_resources:
			var fn = path.get_file()
			if filter_text.is_empty() or fn.to_lower().contains(filter_text):
				gpaths.append(path)
		gpaths.sort_custom(func(a, b):
			var fa = a.get_file().to_lower(); var fb = b.get_file().to_lower()
			return fa < fb if _sort_asc else fa > fb
		)
		for path in gpaths:
			var item = tree.create_item(root)
			item.set_text(0, path.get_file())
			item.set_metadata(0, path)
		return
		
	var target_script = scanner.available_types.get(active_cls)
	if not target_script: return
	
	var properties_info = scanner.get_custom_properties_info(target_script)
	# 展開 Vector2/Vector2i 為兩個獨立欄 (X, Y)
	var expanded_props: Array = []
	for p in properties_info:
		if p.type in [TYPE_VECTOR2, TYPE_VECTOR2I]:
			expanded_props.append({"name": p.name, "type": p.type, "hint": p.hint, "hint_string": p.hint_string, "component": "x"})
			expanded_props.append({"name": p.name, "type": p.type, "hint": p.hint, "hint_string": p.hint_string, "component": "y"})
		else:
			expanded_props.append(p)

	_sort_col = clamp(_sort_col, 0, expanded_props.size())
	tree.columns = expanded_props.size() + 1
	var fn_col_title = I18N.T("file_name") + (" ▲" if _sort_col == 0 and _sort_asc else (" ▼" if _sort_col == 0 else ""))
	tree.set_column_title(0, fn_col_title)
	tree.set_column_expand(0, false)
	tree.set_column_custom_minimum_width(0, 180)
	
	for i in range(expanded_props.size()):
		var col = i + 1
		var p = expanded_props[i]
		var title = p.name.capitalize()
		if p.has("component"): title += " (%s)" % (p.component as String).to_upper()
		if _sort_col == col: title += " ▲" if _sort_asc else " ▼"
		tree.set_column_title(col, title)
		tree.set_column_expand(col, false)
		tree.set_column_custom_minimum_width(col, 130)
		
	var sorted_paths: Array = []
	for path in scanner.all_resources:
		var res_c = scanner.all_resources[path]
		if not filter_text.is_empty() and not path.get_file().to_lower().contains(filter_text): continue
		if scanner.is_script_inheriting(res_c.get_script(), target_script):
			sorted_paths.append(path)
	
	sorted_paths.sort_custom(func(a, b):
		var res_a = scanner.all_resources[a]; var res_b = scanner.all_resources[b]
		var va; var vb
		if _sort_col == 0:
			va = a.get_file().to_lower(); vb = b.get_file().to_lower()
		else:
			var pd = expanded_props[_sort_col - 1]
			var ra = res_a.get(pd.name); var rb = res_b.get(pd.name)
			if pd.has("component"):
				va = (ra.x if pd.component == "x" else ra.y) if ra else 0.0
				vb = (rb.x if pd.component == "x" else rb.y) if rb else 0.0
			elif pd.type in [TYPE_INT, TYPE_FLOAT]:
				va = ra if ra != null else 0; vb = rb if rb != null else 0
			elif pd.type == TYPE_BOOL:
				va = 1 if ra else 0; vb = 1 if rb else 0
			else:
				va = str(ra).to_lower() if ra != null else ""; vb = str(rb).to_lower() if rb != null else ""
		if va < vb: return _sort_asc
		if va > vb: return not _sort_asc
		return false
	)
	
	for path in sorted_paths:
		var res = scanner.all_resources[path]
		var file_name = path.get_file()
		var item = tree.create_item(root)
		item.set_text(0, file_name)
		item.set_metadata(0, path)
		item.set_tooltip_text(0, file_name)
		
		for i in range(expanded_props.size()):
			var prop_dict = expanded_props[i]
			var value = res.get(prop_dict.name)
			var col = i + 1
			item.set_metadata(col, prop_dict) 
			var is_file = (prop_dict.type == TYPE_STRING and (prop_dict.hint == PROPERTY_HINT_FILE or prop_dict.hint == PROPERTY_HINT_DIR))
			
			var str_val = str(value) if value != null else ""
			if prop_dict.type == TYPE_ARRAY: str_val = "Array [%d]" % (value.size() if value else 0)
			item.set_tooltip_text(col, str_val)
			
			if prop_dict.type == TYPE_ARRAY:
				item.set_cell_mode(col, TreeItem.CELL_MODE_STRING)
				item.set_text(col, str_val)
				item.set_editable(col, false)
				item.add_button(col, get_theme_icon("Edit", "EditorIcons"), 0, false, I18N.T("edit_array"))
			elif is_file:
				item.set_cell_mode(col, TreeItem.CELL_MODE_STRING)
				item.set_text(col, str_val)
				item.set_editable(col, true)
				item.add_button(col, get_theme_icon("Folder", "EditorIcons"), 1, false, I18N.T("browse_file"))
			elif prop_dict.type == TYPE_BOOL:
				item.set_cell_mode(col, TreeItem.CELL_MODE_CHECK)
				item.set_checked(col, value if value != null else false)
				item.set_editable(col, true)
			elif prop_dict.type in [TYPE_INT, TYPE_FLOAT]:
				item.set_cell_mode(col, TreeItem.CELL_MODE_RANGE)
				item.set_range_config(col, -9999999, 9999999, 0.01 if prop_dict.type == TYPE_FLOAT else 1)
				item.set_range(col, value if value != null else 0)
				item.set_editable(col, true)
			elif prop_dict.type == TYPE_STRING:
				item.set_cell_mode(col, TreeItem.CELL_MODE_STRING)
				item.set_text(col, str_val.replace("\n", " ↵ "))
				item.set_editable(col, true) 
				item.add_button(col, get_theme_icon("TextEdit", "EditorIcons"), 2, false, I18N.T("open_text_editor"))
			elif prop_dict.has("component"):
				var v = value if value != null else (Vector2i.ZERO if prop_dict.type == TYPE_VECTOR2I else Vector2.ZERO)
				var step = 1.0 if prop_dict.type == TYPE_VECTOR2I else 0.01
				item.set_cell_mode(col, TreeItem.CELL_MODE_RANGE)
				item.set_range_config(col, -9999999, 9999999, step)
				item.set_range(col, v.x if prop_dict.component == "x" else v.y)
				item.set_editable(col, true)
			else:
				item.set_cell_mode(col, TreeItem.CELL_MODE_STRING)
				item.set_text(col, I18N.T("complex_obj"))
				item.set_editable(col, false)

func _on_tree_button_clicked(item: TreeItem, column: int, id: int, mouse_btn: int) -> void:
	if mouse_btn != MOUSE_BUTTON_LEFT: return
	var res = scanner.all_resources.get(item.get_metadata(0))
	var prop_dict = item.get_metadata(column)
	if not res or not prop_dict: return
	
	if id == 0: 
		ui_array.open_editor(plugin, res, prop_dict)
	elif id == 1: 
		_pending_file_cell_res = res; _pending_file_cell_prop = prop_dict.name
		cell_file_dialog.filters = PackedStringArray([prop_dict.hint_string + I18N.T("support_file") if prop_dict.hint_string != "" else I18N.T("all_files")])
		cell_file_dialog.title = I18N.T("select_prefix") + prop_dict.name
		cell_file_dialog.popup_file_dialog()
	elif id == 2: 
		ui_text.open_editor(res, prop_dict.name)

func _on_cell_file_selected(path: String) -> void:
	if _pending_file_cell_res:
		_pending_file_cell_res.set(_pending_file_cell_prop, path)
		ResourceSaver.save(_pending_file_cell_res, _pending_file_cell_res.resource_path)
		_rescan_plugin(); _update_table()

func _on_tree_item_edited() -> void:
	var item = tree.get_edited(); var col = tree.get_edited_column()
	var res = scanner.all_resources.get(item.get_metadata(0))
	var prop_dict = item.get_metadata(col)
	if not res or not prop_dict: return
	var new_val = null
	if prop_dict.type == TYPE_BOOL: new_val = item.is_checked(col)
	elif prop_dict.type in [TYPE_INT, TYPE_FLOAT]: new_val = item.get_range(col)
	elif prop_dict.type == TYPE_STRING: new_val = item.get_text(col)
	elif prop_dict.has("component"):
		var current_val = res.get(prop_dict.name)
		var is_int = prop_dict.type == TYPE_VECTOR2I
		var cx: float = current_val.x if current_val else 0.0
		var cy: float = current_val.y if current_val else 0.0
		if prop_dict.component == "x": cx = item.get_range(col)
		else: cy = item.get_range(col)
		new_val = Vector2i(cx, cy) if is_int else Vector2(cx, cy)
	else: return
	res.set(prop_dict.name, new_val)
	ResourceSaver.save(res, res.resource_path)
	_rescan_plugin()

func _on_tree_cell_selected() -> void:
	if not plugin: return
	var selected = tree.get_selected()
	if selected and selected.get_metadata(0):
		var res = scanner.all_resources.get(selected.get_metadata(0)) as Resource
		if res: plugin.get_editor_interface().edit_resource(res)


# ==============================================================================
# 🧩 內部類別 1: 資料與設定管理器 (DBConfig)
# ==============================================================================
class DBConfig extends RefCounted:
	const CONFIG_PATH = "res://addons/resource_database/settings.cfg"
	var language: String = "auto" # 🚀 語言設定
	var class_folder_bindings: Dictionary = {}
	var default_folder: String = "res://"
	var ignore_dirs: Array = ["res://addons/", "res://GDTag/"]
	var include_dirs: Array = []

	func load_config() -> void:
		var cfg = ConfigFile.new()
		if cfg.load(CONFIG_PATH) == OK:
			language = cfg.get_value("Settings", "language", "auto")
			default_folder = cfg.get_value("Settings", "default_folder", "res://")
			ignore_dirs = cfg.get_value("Settings", "ignore_dirs", ["res://addons/", "res://GDTag/"])
			include_dirs = cfg.get_value("Settings", "include_dirs", [])
			if cfg.has_section("ClassBindings"):
				for key in cfg.get_section_keys("ClassBindings"): 
					var val = cfg.get_value("ClassBindings", key)
					if val: class_folder_bindings[key] = val

	func save_config() -> void:
		var cfg = ConfigFile.new()
		cfg.set_value("Settings", "language", language)
		cfg.set_value("Settings", "default_folder", default_folder)
		cfg.set_value("Settings", "ignore_dirs", ignore_dirs)
		cfg.set_value("Settings", "include_dirs", include_dirs)
		for key in class_folder_bindings: cfg.set_value("ClassBindings", key, class_folder_bindings[key])
		cfg.save(CONFIG_PATH)

# ==============================================================================
# 🧩 內部類別 2: 核心掃描器與解析器 (DBScanner)
# ==============================================================================
class DBScanner extends RefCounted:
	var config: DBConfig
	var all_resources: Dictionary = {}
	var available_types: Dictionary = {}
	var root_classes: Array[String] = []
	var class_hierarchy: Dictionary = {}

	func _init(cfg: DBConfig): config = cfg

	func extract_global_resource_classes() -> void:
		available_types.clear(); root_classes.clear(); class_hierarchy.clear()
		var valid_info = {}
		for c in ProjectSettings.get_global_class_list():
			var cls = c.get("class", ""); var pth = c.get("path", "")
			if cls == "" or pth == "": continue
			var is_white = false
			for inc in config.include_dirs: if pth.begins_with(inc): is_white = true; break
			var keep = true
			if not is_white:
				for ig in config.ignore_dirs: if pth.begins_with(ig): keep = false; break
			if not keep: continue
			var script = load(pth) as Script
			if script and script.get_instance_base_type() == "Resource":
				available_types[cls] = script; valid_info[cls] = c.get("base", "")
		for cls in valid_info:
			var base = valid_info[cls]
			if valid_info.has(base):
				if not class_hierarchy.has(base): class_hierarchy[base] = []
				class_hierarchy[base].append(cls)
			else:
				root_classes.append(cls)
				if not class_hierarchy.has(cls): class_hierarchy[cls] = []

	func scan_directory(path: String) -> void:
		var dir = DirAccess.open(path)
		if dir:
			dir.list_dir_begin()
			var fn = dir.get_next()
			while fn != "":
				if dir.current_is_dir() and not fn.begins_with("."): scan_directory(path + "/" + fn)
				elif fn.ends_with(".tres"):
					var full = path.path_join(fn).replace("//", "/").replace("res:/", "res://")
					var res = ResourceLoader.load(full) as Resource
					if res: all_resources[full] = res
				fn = dir.get_next()

	func is_script_inheriting(script_a: Script, script_b: Script) -> bool:
		if script_a == null: return false
		if script_a == script_b: return true
		var base = script_a.get_base_script()
		while base != null:
			if base == script_b: return true
			base = base.get_base_script()
		return false

	func get_custom_properties_info(target: Script) -> Array:
		var props: Array = []
		if not target: return props
		var temp = target.new()
		if not temp: return props
		for p in temp.get_property_list():
			if (p.usage & PROPERTY_USAGE_SCRIPT_VARIABLE) > 0 and (p.usage & PROPERTY_USAGE_EDITOR) > 0:
				props.append({"name": p.name, "type": p.type, "hint": p.hint, "hint_string": p.hint_string})
		if not temp is RefCounted: temp.free()
		return props
		
	func get_properties_with_docs(target: Script) -> Array:
		var res: Array = []
		if not target: return res
		
		var real_props = {}
		for p in get_custom_properties_info(target): real_props[p.name] = p
			
		var lines = target.source_code.split("\n")
		var cur_grp = ""
		var cur_docs: Array[String] = [] 
		var found_vars = []
		
		for i in range(lines.size()):
			var l = lines[i].strip_edges()
			if l.find("@export_group") != -1:
				var s = l.find('"'); var e = l.find('"', s + 1)
				if s != -1 and e != -1:
					cur_grp = l.substr(s + 1, e - s - 1)
					res.append({"name": cur_grp, "type": TYPE_NIL, "group": "", "display_name": "", "tooltip": "", "hint": 0, "hint_string": "", "is_group": true, "line": i})
				continue
				
			if l.begins_with("##"): 
				cur_docs.append(l.substr(2).strip_edges())
				continue
			
			if l.find("@export") != -1 and l.find("var ") != -1:
				var vs = l.find("var ")
				var after_var = l.substr(vs + 4).strip_edges()
				var v_name = ""
				for c_idx in range(after_var.length()):
					if after_var[c_idx] in [":", "=", " "]:
						v_name = after_var.substr(0, c_idx).strip_edges()
						break
				if v_name == "": v_name = after_var
				
				var d_name = v_name; var t_tip = ""
				if cur_docs.size() > 0:
					d_name = cur_docs[0] 
					if cur_docs.size() > 1:
						var tip_lines = []
						for x in range(1, cur_docs.size()): tip_lines.append(cur_docs[x])
						t_tip = "\n".join(tip_lines) 
					else: t_tip = I18N.T("var_name_prefix") + v_name 
				else: t_tip = I18N.T("var_name_prefix") + v_name
				
				if real_props.has(v_name):
					var rp = real_props[v_name]
					res.append({"name": v_name, "type": rp.type, "group": cur_grp, "display_name": d_name, "tooltip": t_tip, "hint": rp.hint, "hint_string": rp.hint_string, "is_group": false, "line": i})
					found_vars.append(v_name)
				
				cur_docs.clear()
				
		for rn in real_props:
			if not rn in found_vars:
				var rp = real_props[rn]
				res.append({"name": rn, "type": rp.type, "group": "", "display_name": rn, "tooltip": I18N.T("inherited_or_no_doc"), "hint": rp.hint, "hint_string": rp.hint_string, "is_group": false, "line": -1})
				
		return res

# ==============================================================================
# 🧩 內部類別 3: 設定視窗 UI 元件 (SettingsDialogUI)
# ==============================================================================
class SettingsDialogUI extends AcceptDialog:
	signal settings_changed
	var config: DBConfig
	var lang_lbl: Label
	var lang_opt: OptionButton
	var ignore_lbl: Label
	var include_lbl: Label
	var btn_add_ig: Button; var btn_del_ig: Button
	var btn_add_in: Button; var btn_del_in: Button
	var ignore_list: ItemList
	var include_list: ItemList
	var dir_dialog: EditorFileDialog
	var is_adding_ignore: bool = true
	
	func _init(cfg: DBConfig):
		config = cfg
		title = I18N.T("scan_settings"); min_size = Vector2(600, 400)
		var mv = VBoxContainer.new(); mv.size_flags_vertical = Control.SIZE_EXPAND_FILL; add_child(mv)
		
		# 🚀 新增：語言選擇模組
		var lang_hb = HBoxContainer.new()
		lang_lbl = Label.new(); lang_lbl.text = I18N.T("language_setting"); lang_hb.add_child(lang_lbl)
		lang_opt = OptionButton.new()
		lang_opt.add_item(I18N.T("lang_auto")) # 0
		lang_opt.add_item("繁體中文") # 1
		lang_opt.add_item("English") # 2
		
		match config.language:
			"auto": lang_opt.selected = 0
			"zh_TW": lang_opt.selected = 1
			"en": lang_opt.selected = 2
		lang_opt.item_selected.connect(_on_lang_changed)
		lang_hb.add_child(lang_opt); mv.add_child(lang_hb)
		mv.add_child(HSeparator.new())
		
		var hb = HBoxContainer.new(); hb.size_flags_vertical = Control.SIZE_EXPAND_FILL; mv.add_child(hb)
		
		# Ignore Box
		var lb = VBoxContainer.new(); lb.size_flags_horizontal = Control.SIZE_EXPAND_FILL; hb.add_child(lb)
		ignore_lbl = Label.new(); ignore_lbl.text = I18N.T("ignore_folders"); ignore_lbl.add_theme_color_override("font_color", Color.SALMON); lb.add_child(ignore_lbl)
		ignore_list = ItemList.new(); ignore_list.size_flags_vertical = Control.SIZE_EXPAND_FILL; lb.add_child(ignore_list)
		var lb_btn = HBoxContainer.new(); lb.add_child(lb_btn)
		btn_add_ig = Button.new(); btn_add_ig.text = I18N.T("add"); lb_btn.add_child(btn_add_ig)
		btn_del_ig = Button.new(); btn_del_ig.text = I18N.T("delete"); lb_btn.add_child(btn_del_ig)
		
		# Include Box
		var rb = VBoxContainer.new(); rb.size_flags_horizontal = Control.SIZE_EXPAND_FILL; hb.add_child(rb)
		include_lbl = Label.new(); include_lbl.text = I18N.T("include_folders"); include_lbl.add_theme_color_override("font_color", Color.LIGHT_GREEN); rb.add_child(include_lbl)
		include_list = ItemList.new(); include_list.size_flags_vertical = Control.SIZE_EXPAND_FILL; rb.add_child(include_list)
		var rb_btn = HBoxContainer.new(); rb.add_child(rb_btn)
		btn_add_in = Button.new(); btn_add_in.text = I18N.T("add"); rb_btn.add_child(btn_add_in)
		btn_del_in = Button.new(); btn_del_in.text = I18N.T("delete"); rb_btn.add_child(btn_del_in)
		
		dir_dialog = EditorFileDialog.new(); dir_dialog.file_mode = EditorFileDialog.FILE_MODE_OPEN_DIR; add_child(dir_dialog)
		dir_dialog.dir_selected.connect(_on_dir_picked)
		
		btn_add_ig.pressed.connect(func(): is_adding_ignore = true; dir_dialog.popup_file_dialog())
		btn_del_ig.pressed.connect(func(): if ignore_list.is_anything_selected(): config.ignore_dirs.erase(ignore_list.get_item_text(ignore_list.get_selected_items()[0])); _refresh(); config.save_config(); settings_changed.emit())
		btn_add_in.pressed.connect(func(): is_adding_ignore = false; dir_dialog.popup_file_dialog())
		btn_del_in.pressed.connect(func(): if include_list.is_anything_selected(): config.include_dirs.erase(include_list.get_item_text(include_list.get_selected_items()[0])); _refresh(); config.save_config(); settings_changed.emit())

	func _on_lang_changed(idx: int):
		if idx == 0: config.language = "auto"
		elif idx == 1: config.language = "zh_TW"
		elif idx == 2: config.language = "en"
		config.save_config()
		settings_changed.emit() # 觸發主介面的熱更新！
		
	# 提供給主介面呼叫的局部重新整理函式
	func _refresh_texts():
		lang_lbl.text = I18N.T("language_setting")
		lang_opt.set_item_text(0, I18N.T("lang_auto"))
		ignore_lbl.text = I18N.T("ignore_folders")
		include_lbl.text = I18N.T("include_folders")
		btn_add_ig.text = I18N.T("add"); btn_del_ig.text = I18N.T("delete")
		btn_add_in.text = I18N.T("add"); btn_del_in.text = I18N.T("delete")

	func open_dialog(): _refresh(); popup_centered()
	func _refresh():
		ignore_list.clear(); include_list.clear()
		for p in config.ignore_dirs: ignore_list.add_item(p)
		for p in config.include_dirs: include_list.add_item(p)
	func _on_dir_picked(dir: String):
		if not dir.ends_with("/"): dir += "/"
		if is_adding_ignore: config.ignore_dirs.append(dir) 
		else: config.include_dirs.append(dir)
		_refresh(); config.save_config(); settings_changed.emit()

# ==============================================================================
# 🧩 內部類別 4: 陣列編輯器元件 (ArrayEditorUI)
# ==============================================================================
class ArrayEditorUI extends AcceptDialog:
	signal data_changed
	var vbox: VBoxContainer
	var target_res: Resource
	var prop_dict: Dictionary
	
	func _init():
		title = I18N.T("edit_array_title"); min_size = Vector2(400, 500)
		var sc = ScrollContainer.new(); sc.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED; sc.size_flags_vertical = Control.SIZE_EXPAND_FILL; add_child(sc)
		var mv = VBoxContainer.new(); mv.size_flags_horizontal = Control.SIZE_EXPAND_FILL; sc.add_child(mv)
		vbox = VBoxContainer.new(); vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL; mv.add_child(vbox)
		var add_btn = Button.new(); add_btn.text = I18N.T("add_new_element"); add_btn.add_theme_color_override("font_color", Color.GREEN); mv.add_child(add_btn)
		add_btn.pressed.connect(func(): _add_row(vbox.get_child_count(), null))
		confirmed.connect(_on_save)

	func open_editor(plugin: EditorPlugin, res: Resource, prop: Dictionary):
		target_res = res; prop_dict = prop; title = I18N.T("editing_prefix") + prop.name.capitalize()
		for c in vbox.get_children(): c.queue_free()
		var arr = target_res.get(prop.name)
		if arr == null: arr = []
		for i in range(arr.size()): _add_row(i, arr[i])
		popup_centered()

	func _add_row(idx: int, val: Variant):
		var row = HBoxContainer.new(); vbox.add_child(row)
		var lbl = Label.new(); lbl.text = str(idx) + ":"; lbl.custom_minimum_size = Vector2(30, 0); row.add_child(lbl)
		var hint = prop_dict.hint_string
		if hint.find("17:") != -1:
			var p = EditorResourcePicker.new(); p.base_type = hint.split("17:")[1] if hint.split("17:").size()>1 else "Resource"
			if val is Resource: p.edited_resource = val
			p.size_flags_horizontal = Control.SIZE_EXPAND_FILL; row.add_child(p)
		else:
			var ip = LineEdit.new(); ip.text = str(val) if val != null else ""; ip.size_flags_horizontal = Control.SIZE_EXPAND_FILL; row.add_child(ip)
		var del = Button.new(); del.text = "X"; del.pressed.connect(func(): row.queue_free()); row.add_child(del)

	func _on_save():
		var is_res = prop_dict.hint_string.find("17:") != -1; var res_arr = []
		for row in vbox.get_children():
			var nd = row.get_child(1)
			if is_res and nd is EditorResourcePicker: res_arr.append(nd.edited_resource)
			elif nd is LineEdit: res_arr.append(nd.text)
		target_res.set(prop_dict.name, res_arr)
		ResourceSaver.save(target_res, target_res.resource_path)
		data_changed.emit()

# ==============================================================================
# 🧩 內部類別 5: 範本注入精靈元件 (TemplateWizardUI)
# ==============================================================================
class TemplateWizardUI extends AcceptDialog:
	signal script_modified
	var ex_list: ItemList
	var grp_opt: OptionButton; var new_grp_in: LineEdit
	var insert_pos_opt: OptionButton
	var nm_in: LineEdit; var dsp_in: LineEdit; var typ_opt: OptionButton
	var active_class: String; var available_types: Dictionary; var plugin: EditorPlugin
	var parsed_props: Array = []
	
	func _init():
		title = I18N.T("template_wizard_title"); min_size = Vector2(550, 600)
		var mv = VBoxContainer.new(); add_child(mv)
		ex_list = ItemList.new(); ex_list.custom_minimum_size = Vector2(0, 150)
		var lbl_vars = Label.new(); lbl_vars.text = I18N.T("existing_vars"); mv.add_child(lbl_vars)
		mv.add_child(ex_list)
		mv.add_child(HSeparator.new())
		
		var gd = GridContainer.new(); gd.columns = 2; mv.add_child(gd)
		
		var lbl_grp = Label.new(); lbl_grp.text = I18N.T("belong_group"); gd.add_child(lbl_grp)
		var grp_box = HBoxContainer.new(); grp_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL; gd.add_child(grp_box)
		grp_opt = OptionButton.new(); grp_opt.size_flags_horizontal = Control.SIZE_EXPAND_FILL; grp_box.add_child(grp_opt)
		new_grp_in = LineEdit.new(); new_grp_in.placeholder_text = I18N.T("input_new_group"); new_grp_in.size_flags_horizontal = Control.SIZE_EXPAND_FILL; new_grp_in.hide(); grp_box.add_child(new_grp_in)
		
		var lbl_pos = Label.new(); lbl_pos.text = I18N.T("insert_pos"); lbl_pos.add_theme_color_override("font_color", Color.CYAN); gd.add_child(lbl_pos)
		insert_pos_opt = OptionButton.new(); insert_pos_opt.size_flags_horizontal = Control.SIZE_EXPAND_FILL; gd.add_child(insert_pos_opt)
		
		var lbl_nm = Label.new(); lbl_nm.text = I18N.T("new_var_name"); gd.add_child(lbl_nm)
		nm_in = LineEdit.new(); nm_in.size_flags_horizontal = Control.SIZE_EXPAND_FILL; gd.add_child(nm_in)
		
		var lbl_dsp = Label.new(); lbl_dsp.text = I18N.T("var_doc"); gd.add_child(lbl_dsp)
		dsp_in = LineEdit.new(); dsp_in.size_flags_horizontal = Control.SIZE_EXPAND_FILL; gd.add_child(dsp_in)
		
		var lbl_typ = Label.new(); lbl_typ.text = I18N.T("var_type"); gd.add_child(lbl_typ)
		typ_opt = OptionButton.new(); typ_opt.size_flags_horizontal = Control.SIZE_EXPAND_FILL; gd.add_child(typ_opt)
		for t in ["int", "float", "bool", "String", "Multiline", "Resource", "Texture2D", "Array[String]", "Array[Resource]", "FilePath"]: typ_opt.add_item(t)
		
		var inject = Button.new(); inject.text = I18N.T("inject_code"); inject.add_theme_color_override("font_color", Color.YELLOW); inject.pressed.connect(_inject); mv.add_child(inject)
		var btn_only_grp = Button.new(); btn_only_grp.text = I18N.T("create_group_only"); btn_only_grp.pressed.connect(_create_grp); mv.add_child(btn_only_grp)
		
		grp_opt.item_selected.connect(_on_grp_selected)
		new_grp_in.text_changed.connect(_update_insert_options)

	func open_wizard(pl: EditorPlugin, a_cls: String, a_types: Dictionary, scanner: DBScanner):
		plugin = pl; active_class = a_cls; available_types = a_types
		if a_cls == "" or not a_types.has(a_cls): return
		var script = a_types[a_cls]; title = I18N.T("modify_template_prefix") + a_cls; ex_list.clear()
		parsed_props = scanner.get_properties_with_docs(script)
		
		for i in parsed_props:
			var text = I18N.T("group_prefix") + i.name if i.is_group else ("["+i.group+"] " if i.group != "" else "") + i.display_name + " ("+i.name+")"
			ex_list.add_item(text)
			if not i.is_group and i.tooltip != "": ex_list.set_item_tooltip(ex_list.get_item_count() - 1, i.tooltip)
			
		grp_opt.clear()
		grp_opt.add_item(I18N.T("no_group")); grp_opt.set_item_metadata(0, "")
		var grp_idx = 1
		for p in parsed_props:
			if p.is_group:
				grp_opt.add_item("📦 " + p.name)
				grp_opt.set_item_metadata(grp_idx, p.name)
				grp_idx += 1
		grp_opt.add_item(I18N.T("new_group_opt")); grp_opt.set_item_metadata(grp_idx, "__NEW__")
		
		new_grp_in.text = ""; nm_in.text = ""; dsp_in.text = ""
		grp_opt.selected = 0
		_on_grp_selected(0)
		popup_centered()

	func _on_grp_selected(idx: int):
		var meta = grp_opt.get_item_metadata(idx)
		if typeof(meta) == TYPE_STRING and meta == "__NEW__":
			new_grp_in.show()
			_update_insert_options(new_grp_in.text.strip_edges())
		else:
			new_grp_in.hide()
			_update_insert_options(meta as String)

	func _update_insert_options(target_group: String):
		insert_pos_opt.clear()
		var group_exists = false
		for p in parsed_props:
			if p.is_group and p.name == target_group: group_exists = true; break
				
		if group_exists:
			insert_pos_opt.add_item(I18N.T("at_group_end")); insert_pos_opt.set_item_metadata(0, {"type": "group_end", "group": target_group})
			var idx = 1
			for p in parsed_props:
				if not p.is_group and p.group == target_group and p.line != -1:
					insert_pos_opt.add_item(I18N.T("after_var_prefix") + p.display_name + " (" + p.name + ")")
					insert_pos_opt.set_item_metadata(idx, {"type": "after_var", "line": p.line})
					idx += 1
		else:
			insert_pos_opt.add_item(I18N.T("at_file_end")); insert_pos_opt.set_item_metadata(0, {"type": "file_end"})
			var idx = 1
			for p in parsed_props:
				if p.is_group:
					insert_pos_opt.add_item(I18N.T("after_group_prefix") + p.name)
					insert_pos_opt.set_item_metadata(idx, {"type": "after_group", "group": p.name})
					idx += 1

	func _find_insert_line_idx(meta: Dictionary) -> int:
		if meta.type == "file_end": return -1
		if meta.type == "after_var": return meta.line
		if meta.type == "group_end" or meta.type == "after_group":
			var max_line = -1; var group_line = -1
			for p in parsed_props:
				if p.is_group and p.name == meta.group: group_line = p.line
				elif not p.is_group and p.group == meta.group:
					if p.line > max_line: max_line = p.line
			if max_line != -1: return max_line
			if group_line != -1: return group_line
		return -1

	func _get_logical_next_line(lines: Array, start_line: int) -> int:
		if start_line < 0 or start_line >= lines.size(): return lines.size()
		var idx = start_line + 1
		while idx < lines.size():
			var l = lines[idx].strip_edges()
			if l == "" or l.begins_with("@") or l.begins_with("var ") or l.begins_with("func ") or l.begins_with("class ") or l.begins_with("##") or l.begins_with("#"):
				break
			idx += 1
		return idx

	func _execute_injection(snippet: String):
		var script = available_types.get(active_class); if not script: return
		var meta = insert_pos_opt.get_item_metadata(insert_pos_opt.selected)
		if meta == null: return
		var insert_line = _find_insert_line_idx(meta)
		var lines = Array(script.source_code.split("\n"))
		
		if insert_line == -1:
			if lines.size() > 0 and lines.back().strip_edges() == "": lines.pop_back()
			lines.append(snippet)
		else:
			var target_idx = _get_logical_next_line(lines, insert_line)
			lines.insert(target_idx, snippet)
			
		script.source_code = "\n".join(lines)
		ResourceSaver.save(script, script.resource_path); script.reload()
		hide(); script_modified.emit()

	func _inject():
		var vn = nm_in.text.strip_edges(); if vn == "": return
		var snippet = ""
		
		var target_group = ""
		var meta = grp_opt.get_item_metadata(grp_opt.selected)
		var is_new_group = false
		
		if typeof(meta) == TYPE_STRING and meta == "__NEW__":
			target_group = new_grp_in.text.strip_edges()
			if target_group != "": is_new_group = true
		else:
			target_group = meta as String
		
		if is_new_group: snippet += '\n@export_group("%s")\n' % target_group
		if dsp_in.text != "": snippet += '## %s\n' % dsp_in.text
		
		match typ_opt.selected:
			0: snippet += '@export var %s: int = 0' % vn
			1: snippet += '@export var %s: float = 0.0' % vn
			2: snippet += '@export var %s: bool = false' % vn
			3: snippet += '@export var %s: String = ""' % vn
			4: snippet += '@export_multiline var %s: String = ""' % vn
			5: snippet += '@export var %s: Resource' % vn
			6: snippet += '@export var %s: Texture2D' % vn
			7: snippet += '@export var %s: Array[String] = []' % vn
			8: snippet += '@export var %s: Array[Resource] = []' % vn
			_: snippet += '@export_file("*.*") var %s: String = ""' % vn
			
		_execute_injection(snippet)

	func _create_grp():
		var meta = grp_opt.get_item_metadata(grp_opt.selected)
		if typeof(meta) != TYPE_STRING or meta != "__NEW__": return 
		var g = new_grp_in.text.strip_edges()
		if g == "": return
		var snippet = '\n@export_group("%s")' % g
		_execute_injection(snippet)

# ==============================================================================
# 🧩 內部類別 6: 進階實例產生器元件 (AdvancedCreatorUI)
# ==============================================================================
class AdvancedCreatorUI extends ConfirmationDialog:
	signal instance_created(file_path: String)
	var vbox: VBoxContainer; var name_in: LineEdit; var ctrls: Dictionary = {}
	var active_class: String; var available_types: Dictionary; var target_folder: String
	
	func _init():
		title = I18N.T("creator_title"); min_size = Vector2(450, 600)
		var mv = VBoxContainer.new(); add_child(mv)
		var th = HBoxContainer.new()
		var lbl_fn = Label.new(); lbl_fn.text = I18N.T("file_name_no_ext"); th.add_child(lbl_fn)
		name_in = LineEdit.new(); name_in.size_flags_horizontal = Control.SIZE_EXPAND_FILL; th.add_child(name_in); mv.add_child(th)
		
		mv.add_child(HSeparator.new())
		var lbl_cfg = Label.new(); lbl_cfg.text = I18N.T("init_prop_config"); mv.add_child(lbl_cfg)
		
		var sc = ScrollContainer.new(); sc.size_flags_vertical = Control.SIZE_EXPAND_FILL; sc.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED; mv.add_child(sc)
		vbox = VBoxContainer.new(); vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL; sc.add_child(vbox)
		confirmed.connect(_on_confirm)

	func open_creator(a_cls: String, a_types: Dictionary, scanner: DBScanner, t_folder: String):
		active_class = a_cls; available_types = a_types; target_folder = t_folder
		if a_cls == "" or not a_types.has(a_cls): return
		name_in.text = ""; for c in vbox.get_children(): c.queue_free(); ctrls.clear()
		
		var grouped = {}; var cur_grp = ""
		for p in scanner.get_properties_with_docs(a_types[a_cls]):
			if p.is_group: 
				cur_grp = p.name
				if not grouped.has(cur_grp): grouped[cur_grp] = []
				continue
				
			var tg = p.group if p.group != "" else cur_grp
			if not grouped.has(tg): grouped[tg] = []
			grouped[tg].append(p)
		
		var keys = grouped.keys(); keys.sort()
		for k in keys:
			if grouped[k].size() == 0: continue
			if k != "": 
				var gl = Label.new(); gl.text = "── " + k + " ──"; gl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
				gl.add_theme_color_override("font_color", Color(0.4, 0.8, 1.0)); vbox.add_child(gl)
				
			for p in grouped[k]:
				var hb = HBoxContainer.new(); vbox.add_child(hb)
				var lbl = Label.new()
				lbl.text = p.display_name + ":"
				lbl.custom_minimum_size = Vector2(140, 0)
				lbl.tooltip_text = p.tooltip 
				lbl.mouse_filter = Control.MOUSE_FILTER_PASS 
				hb.add_child(lbl)
				
				var ctrl = null
				if p.type == TYPE_BOOL: 
					ctrl = CheckBox.new()
				elif p.type in [TYPE_INT, TYPE_FLOAT]: 
					ctrl = SpinBox.new()
					ctrl.min_value = -9999999; ctrl.max_value = 9999999
					ctrl.step = 0.01 if p.type == TYPE_FLOAT else 1
					
					var le = ctrl.get_line_edit()
					le.text_changed.connect(func(t: String):
						var filtered = ""
						for char in t:
							if char in ["0","1","2","3","4","5","6","7","8","9","-","."]:
								filtered += char
						if t != filtered:
							le.text = filtered
							le.caret_column = filtered.length()
					)
					
				elif p.type in [TYPE_VECTOR2, TYPE_VECTOR2I]:
					var step = 1.0 if p.type == TYPE_VECTOR2I else 0.01
					var sb_x = SpinBox.new(); sb_x.min_value = -9999999; sb_x.max_value = 9999999; sb_x.step = step; sb_x.prefix = "X:"
					var sb_y = SpinBox.new(); sb_y.min_value = -9999999; sb_y.max_value = 9999999; sb_y.step = step; sb_y.prefix = "Y:"
					sb_x.size_flags_horizontal = Control.SIZE_EXPAND_FILL
					sb_y.size_flags_horizontal = Control.SIZE_EXPAND_FILL
					hb.add_child(sb_x); hb.add_child(sb_y)
					ctrls[p.name] = {"ctrl_x": sb_x, "ctrl_y": sb_y, "type": p.type}
				elif p.type == TYPE_ARRAY:
					var col_box = VBoxContainer.new(); col_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
					var rows_box = VBoxContainer.new(); col_box.add_child(rows_box)
					var add_btn = Button.new(); add_btn.text = I18N.T("add_new_element")
					var hs = p.hint_string
					add_btn.pressed.connect(func(): _add_array_row(rows_box, null, hs))
					col_box.add_child(add_btn)
					hb.add_child(col_box)
					ctrls[p.name] = {"rows_box": rows_box, "type": TYPE_ARRAY, "hint_string": p.hint_string}
				elif p.type == TYPE_STRING and (p.hint == PROPERTY_HINT_FILE or p.hint == PROPERTY_HINT_DIR): 
					ctrl = Label.new(); ctrl.text = I18N.T("path_edit_later")
				elif p.type == TYPE_STRING or p.type == TYPE_NIL: 
					ctrl = LineEdit.new()
					if p.type == TYPE_NIL: ctrl.placeholder_text = I18N.T("uninferred_type")
				else: 
					ctrl = EditorResourcePicker.new(); ctrl.base_type = "Resource"
				
				if ctrl: 
					ctrl.size_flags_horizontal = Control.SIZE_EXPAND_FILL; hb.add_child(ctrl)
					ctrls[p.name] = {"ctrl": ctrl, "type": p.type}
		popup_centered()
		name_in.grab_focus()

	func _add_array_row(rows_box: VBoxContainer, val: Variant, hint_string: String) -> void:
		var row = HBoxContainer.new(); rows_box.add_child(row)
		var lbl = Label.new(); lbl.text = str(rows_box.get_child_count() - 1) + ":"; lbl.custom_minimum_size = Vector2(30, 0); row.add_child(lbl)
		if hint_string.find("17:") != -1:
			var base = hint_string.split("17:")[1] if hint_string.split("17:").size() > 1 else "Resource"
			var picker = EditorResourcePicker.new(); picker.base_type = base
			if val is Resource: picker.edited_resource = val
			picker.size_flags_horizontal = Control.SIZE_EXPAND_FILL; row.add_child(picker)
		else:
			var ip = LineEdit.new(); ip.text = str(val) if val != null else ""; ip.size_flags_horizontal = Control.SIZE_EXPAND_FILL; row.add_child(ip)
		var del = Button.new(); del.text = "X"; del.pressed.connect(func(): row.queue_free()); row.add_child(del)

	func _on_confirm():
		var fn = name_in.text.strip_edges(); if fn.is_empty(): return
		if not fn.ends_with(".tres"): fn += ".tres"
		if not DirAccess.dir_exists_absolute(target_folder): DirAccess.make_dir_recursive_absolute(target_folder)
		var t_path = target_folder.path_join(fn)
		var script = available_types.get(active_class); if not script: return
		var res = script.new()
		for pn in ctrls:
			var meta = ctrls[pn]; var v = null
			if meta.has("ctrl_x"):
				var vx = meta.ctrl_x.value; var vy = meta.ctrl_y.value
				v = Vector2i(vx, vy) if meta.type == TYPE_VECTOR2I else Vector2(vx, vy)
			elif meta.has("rows_box"):
				var rows_box = meta.rows_box as VBoxContainer
				var is_res = (meta.hint_string as String).find("17:") != -1
				var arr = []
				for row in rows_box.get_children():
					var nd = row.get_child(1)
					if is_res and nd is EditorResourcePicker: arr.append(nd.edited_resource)
					elif nd is LineEdit: arr.append(nd.text)
				v = arr
			else:
				var c = meta.ctrl
				if c is CheckBox: v = c.button_pressed
				elif c is SpinBox: v = c.value
				elif c is LineEdit: v = c.text
				elif c is EditorResourcePicker: v = c.edited_resource
			if v != null: res.set(pn, v)
		if ResourceSaver.save(res, t_path) == OK: instance_created.emit(t_path)

# ==============================================================================
# 🧩 內部類別 7: 大文字多行編輯器元件 (TextEditorUI)
# ==============================================================================
class TextEditorUI extends ConfirmationDialog:
	signal text_saved
	var text_edit: TextEdit
	var current_res: Resource
	var current_prop: String

	func _init():
		title = I18N.T("text_editor_title")
		min_size = Vector2(500, 400)
		
		text_edit = TextEdit.new()
		text_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		text_edit.size_flags_vertical = Control.SIZE_EXPAND_FILL
		text_edit.wrap_mode = TextEdit.LINE_WRAPPING_BOUNDARY
		add_child(text_edit)
		
		confirmed.connect(_on_save)

	func open_editor(res: Resource, prop_name: String):
		current_res = res
		current_prop = prop_name
		title = I18N.T("editing_long_text") + prop_name
		
		var val = res.get(prop_name)
		text_edit.text = str(val) if val != null else ""
		popup_centered()

	func _on_save():
		current_res.set(current_prop, text_edit.text)
		ResourceSaver.save(current_res, current_res.resource_path)
		text_saved.emit()
