import Adafruit_BBIO.GPIO as dsp
import time

dsp.setup("P8_11",dsp.OUT)	#RED
dsp.setup("P8_12",dsp.OUT)	#YELLOW
dsp.setup("P8_13",dsp.OUT)	#GREEN

while True:
	print "Red Light ON!"
	dsp.output("P8_11",dsp.HIGH)
	dsp.output("P8_12",dsp.LOW)
	dsp.output("P8_13",dsp.LOW)
	
	time.sleep(4)
	
	print "GO GO GO!!"
	dsp.output("P8_11",dsp.LOW)
	dsp.output("P8_13",dsp.HIGH)
	dsp,output("P8_12",dsp.LOW)
	
	time.sleep(2)
	
	print "SLOW DOWN BITCHES!!!"
	dsp.output("P8_13",dsp.LOW)
	dsp.output("P8_12",dsp.HIGH)
	dsp.output("P8_11",dsp.LOW)
	
	time.sleep(1)
