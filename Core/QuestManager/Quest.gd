class_name Quest
extends Resource


enum Status {
	NOT_STARTED,
	IN_PROGRESS,
	COMPLETED,
	FAILED
}


@export var name: String
@export var description: String
@export var status: Status = Status.NOT_STARTED
