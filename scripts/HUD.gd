extends CanvasLayer


func change_score(value: int):
	$GridContainer/Score.text = str(value)
	
func change_fuel(value: int):
	$GridContainer/FuelCount.text = str(value)

func change_days(value: int):
	$GridContainer/Days.text = str(value)
	
func change_time(value: int):
	$GridContainer/Time.text = str(value)
