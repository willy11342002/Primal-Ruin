class_name SaveData extends Resource


@export_group("File Info")
@export var title: String = ""
@export var file_name: String = ""
@export var modified_time: int = 0


func save_to_disk():
	ResourceSaver.save(self, self.file_name)
