extends Node2D

func update_health():
	$"0_hearts".hide()
	$"0_5_hearts".hide()
	$"3_hearts".hide()
	$"2_5_hearts".hide()
	$"2_hearts".hide()
	$"1_5_hearts".hide()
	$"1_hearts".hide()
	match PlayerHealth.health_tracker:
		0.0:
			$"0_hearts".show()
		0.5:
			$"0_5_hearts".show()
		1.0:
			$"1_hearts".show()
		1.5:
			$"1_5_hearts".show()
		2.0:
			$"2_hearts".show()
		2.5:
			$"2_5_hearts".show()
		3.0:
			$"3_hearts".show()		
