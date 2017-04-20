import Adafruit_BBIO.GPIO as dsp
import time

dsp.setup("P8_11",dsp.IN)
dsp.setup("P8_13",dsp.IN)
dsp.setup("P8_15",dsp.IN)
dsp.setupt("P8_12",dsp.OUT)
dsp.setupt("P8_14",dsp.OUT)
dsp.setupt("P8_16",dsp.OUT)

a=["P8_12","P8_14","P8_16"]
i=0	#dest flag
j=0	#src flag
str="P8_12"

dsp.output("P8_12",dsp.HIGH)	#shows starting current floor

while True:
	if(dsp.input("P8_11")==1):
		i=0
	elif(dsp.input("P8_13")==1):
		i=1
	elif(dsp.input("P8_15")==1):
		i=2
		
	j=a.index(str)		#to find current floor which is changed during simulations
	
	if((i-j)>0):		#going upwards/dest>src
		dsp.output(str,dsp.LOW)		#current floor LED OFF
		
		for blink in range(j,i+1):		#to blink LEDs of intermeadiate floors
			dsp.output(a[blink],dsp.HIGH)
			time.sleep(3)
			dsp.output(a[blink],dsp.LOW)
			str=a[blink]
			print str
			
	dsp.output(str,dsp.HIGH)	#dest reached/dest LED ON
	
	if((i-j)<0):		#going downwards/dest<src
		dsp.output(str,dsp.LOW)		#current floor LED OFF
		
		for blink in range(j,i-1,-1):		#to blink LEDs of intermeadiate floors
			dsp.output(a[blink],dsp.LOW)
			time.sleep(3)
			dsp.output(a[blink],dsp.HIGH)
			str=a[blink]
			print str
			
	dsp.output(str,dsp.HIGH)		#dest reached/dest LED ON
