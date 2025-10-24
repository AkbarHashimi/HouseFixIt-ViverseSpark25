extends Area2D

# custom methods

var b_isDriving: bool = false

func becomeHuman():
	$playerSprite.visible = true
	$CarSprite.visible = false
	
	b_isDriving = false

func becomeCar():
	$playerSprite.visible = false
	$CarSprite.visible = true
	
	b_isDriving = true

func isDriving():
	return b_isDriving
