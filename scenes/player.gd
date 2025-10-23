extends Area2D

# custom methods

func becomeHuman():
	$playerSprite.visible = true
	$CarSprite.visible = false
	
func becomeCar():
	$playerSprite.visible = false
	$CarSprite.visible = true
