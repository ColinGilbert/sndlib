;;; from VOIDAT.SAI[220,JDC] and GLSVOI.SAI[220,JDC], then (30 years later) jcvoi.ins

(provide 'snd-jcvoi.scm)
(require snd-env.scm)

(define fnc #f)  ;; fnc[sex,vowel,formant number,formant freq,amp or fm index]
(define vibfreqfun #f)
(define i3fun1 #f)
(define i3fun2 #f)

(define (flipxy data)			; SEG functions expected data in (y x) pairs.
  (let ((unseg ())
	(len (length data)))
    (do ((i 0 (+ i 2)))
	((>= i len)
	 (reverse unseg))
      (let ((x (data (+ 1 i)))
	    (y (data i)))
	(set! unseg (cons y (cons x unseg)))))))

(define (addenv env1 sc1 off1 env2 sc2 off2)
  (add-envelopes (scale-envelope env1 sc1 off1)
		 (scale-envelope env2 sc2 off2)))

(define (checkpt att dur)
  (if (not (positive? att))
      (* 100 (/ .01 dur))
      (if (< att dur)
	  (* 100 (/ att dur))
	  100)))

(define (setf-aref vect a b c d val)
  (set! (vect (+ a (* 3 b) (* 18 c) (* 72 d))) val))
  
(define (aref vect a b c d)
  (vect (+ a (* 3 b) (* 18 c) (* 72 d))))
  
(define (fillfnc)
  (unless fnc
    (set! fnc (make-vector 288 ())) ; 288 = (* 3 6 4 4)
    (set! vibfreqfun (make-vector 3 ()))
    (set! i3fun1 (make-vector 3 ()))
    (set! i3fun2 (make-vector 3 ()))
    
    (setf-aref fnc 1 1 1 1 (flipxy '(350  130.8 524  261.6 392  392 523 523.2 784 784 1046 1064 1568 1568)))
    (setf-aref fnc 1 1 1 2 (flipxy '(.3   130.8   .8 261.6   .9 392  .9 523.2  .7 784   .86 1064 .86  1568)))
    (setf-aref fnc 1 1 1 3 (flipxy '(1.4  130.8  1.4 261.6  1.0 392  .8 523.2  .5 784   .3 1064 .2 1568)))
    (setf-aref fnc 1 1 2 1 (flipxy '(1100 130.8 1100 261.6 1100 392 1200 523.2 1500 784 1800 1064 2200 1568)))
    (setf-aref fnc 1 1 2 2 (flipxy '(.1   130.8   .2 261.6   .3 392   .3 523.2   .1 784  .05 1064 .05  1568)))
    (setf-aref fnc 1 1 2 3 (flipxy '(1.0  130.8  1.0 261.6   .4 392   .4 523.2   .2 784   .2 1064 .1 1568)))
    (setf-aref fnc 1 1 3 1 (flipxy '(3450 130.8 3400 261.6 3400 392 3600 523.2 4500 784 5000 1064 5800 1568)))
    (setf-aref fnc 1 1 3 2 (flipxy '(.04  130.8  .04 261.6  .04 392 .045 523.2  .03 784  .02 1064 .02  1568)))
    (setf-aref fnc 1 1 3 3 (flipxy '(3.5  130.8  2.0 261.6  1.5 392  1.2 523.2   .8 784   .8 1064 1.0  1568)))
    (setf-aref fnc 1 2 1 1 (flipxy '(175  130.8 262  261.6 392  392 523 523.2 784 784 1046 1064 1568 1568)))
    (setf-aref fnc 1 2 1 2 (flipxy '(.25  130.8   .6 261.6   .6 392  .6 523.2  .7 784   .86 1064 .86  1568)))
    (setf-aref fnc 1 2 1 3 (flipxy '(0.5  130.8  0.3 261.6  0.1 392 .05 523.2 .04 784  .03 1064 .02 1568)))
    (setf-aref fnc 1 2 2 1 (flipxy '(2900 130.8 2700 261.6 2600 392 2400 523.2 2300 784 2200 1064 2100 1568)))
    (setf-aref fnc 1 2 2 2 (flipxy '(.01  130.8  .05 261.6  .08 392   .1 523.2   .1 784  .1  1064 .05  1568)))
    (setf-aref fnc 1 2 2 3 (flipxy '(1.5  130.8  1.0 261.6  1.0 392  1.0 523.2  1.0 784  1.0 1064 .5 1568)))
    (setf-aref fnc 1 2 3 1 (flipxy '(4200 130.8 3900 261.6 3900 392 3900 523.2 3800 784 3700 1064 3600 1568)))
    (setf-aref fnc 1 2 3 2 (flipxy '(.01  130.8  .04 261.6  .03 392 .03  523.2  .03 784  .03 1064 .02  1568)))
    (setf-aref fnc 1 2 3 3 (flipxy '(1.2  130.8   .8 261.6   .8 392   .8 523.2   .8 784   .8 1064 .5  1568)))
    (setf-aref fnc 1 3 1 1 (flipxy '(175  130.8 262  261.6 392  392 523 523.2 784 784 1046 1064 1568 1568)))
    (setf-aref fnc 1 3 1 2 (flipxy '(.3   130.8   .7 261.6   .8 392  .6 523.2  .7 784   .86 1064 .86  1568)))
    (setf-aref fnc 1 3 1 3 (flipxy '(0.4  130.8  0.2 261.6  0.4 392 .4  523.2 .7  784  .5  1064 .2  1568)))
    (setf-aref fnc 1 3 2 1 (flipxy '(1000 130.8 1000 261.6 1100 392 1200 523.2 1400 784 1800 1064 2200 1568)))
    (setf-aref fnc 1 3 2 2 (flipxy '(.055 130.8  .1  261.6  .15 392  .13 523.2   .1 784  .1  1064 .05  1568)))
    (setf-aref fnc 1 3 2 3 (flipxy '(0.3  130.8  0.4 261.6  0.4 392  0.4 523.2  0.3 784  0.2 1064 0.1  1568)))
    (setf-aref fnc 1 3 3 1 (flipxy '(2600 130.8 2600 261.6 3000 392 3400 523.2 4500 784 5000 1064 5800 1568)))
    (setf-aref fnc 1 3 3 2 (flipxy '(.005 130.8  .03 261.6  .04 392  .04 523.2  .02 784  .02 1064 .02  1568)))
    (setf-aref fnc 1 3 3 3 (flipxy '(1.1  130.8  1.0 261.6  1.2 392 1.2  523.2  0.8 784  0.8 1064 1.0  1568)))
    (setf-aref fnc 1 4 1 1 (flipxy '(353  130.8 530  261.6 530  392 523 523.2 784 784 1046 1064 1568 1568)))
    (setf-aref fnc 1 4 1 2 (flipxy '(.5   130.8   .8 261.6   .8 392  .6 523.2  .7 784   .86 1064 .86  1568)))
    (setf-aref fnc 1 4 1 3 (flipxy '(0.6  130.8  0.7 261.6  1.0 392 0.8 523.2  .7 784  .5  1064 .2  1568)))
    (setf-aref fnc 1 4 2 1 (flipxy '(1040 130.8 1040 261.6 1040 392 1200 523.2 1400 784 1800 1064 2200 1568)))
    (setf-aref fnc 1 4 2 2 (flipxy '(.050 130.8  .05 261.6  .1  392  .2  523.2   .1 784  .1  1064 .05  1568)))
    (setf-aref fnc 1 4 2 3 (flipxy '(0.1  130.8  0.1 261.6  0.1 392  0.4 523.2  0.3 784  0.2 1064 0.1  1568)))
    (setf-aref fnc 1 4 3 1 (flipxy '(2695 130.8 2695 261.6 2695 392 3400 523.2 4500 784 5000 1064 5800 1568)))
    (setf-aref fnc 1 4 3 2 (flipxy '( .05 130.8  .05 261.6  .04 392  .04 523.2  .02 784  .02 1064 .02  1568)))
    (setf-aref fnc 1 4 3 3 (flipxy '(1.2  130.8  1.2 261.6  1.2 392 1.2  523.2  0.8 784  0.8 1064 1.0  1568)))
    (setf-aref fnc 1 5 1 1 (flipxy '(175  130.8 262  261.6 392  392 523 523.2 784 784 1046 1064 1568 1568)))
    (setf-aref fnc 1 5 1 2 (flipxy '(.4   130.8   .4 261.6   .8 392  .8 523.2  .8 784   .8 1064 .8   1568)))
    (setf-aref fnc 1 5 1 3 (flipxy '(0.1  130.8  0.1 261.6  0.1 392 0.1 523.2  .0 784  .0  1064 .0  1568)))
    (setf-aref fnc 1 5 2 1 (flipxy '( 350 130.8  524 261.6  784 392  950 523.2 1568 784 2092 1064 3136 1568)))
    (setf-aref fnc 1 5 2 2 (flipxy '(.8   130.8  .8  261.6  .4  392  .2  523.2   .1 784  .1  1064 .0   1568)))
    (setf-aref fnc 1 5 2 3 (flipxy '(0.5  130.8  0.1 261.6  0.1 392  0.1 523.2  0.0 784  0.0 1064 0.0  1568)))
    (setf-aref fnc 1 5 3 1 (flipxy '(2700 130.8 2700 261.6 2500 392 2450 523.2 2400 784 2350 1064 4500 1568)))
    (setf-aref fnc 1 5 3 2 (flipxy '( .1  130.8  .15 261.6  .15 392  .15 523.2  .15 784  .1  1064 .1   1568)))
    (setf-aref fnc 1 5 3 3 (flipxy '(2.0  130.8  1.6 261.6  1.6 392 1.6  523.2  1.6 784  1.6 1064 1.0  1568)))
    (setf-aref fnc 2 1 1 1 (flipxy '( 33   16.5  33   24.5  33 32.7  49  49.0  65 65.41    98   98 131 130.8)))
    (setf-aref fnc 2 1 1 2 (flipxy '( .3   16.5  .5   24.5  .6 32.7  .5  49.0  .47 65.41   .135 98 .2  130.8)))
    (setf-aref fnc 2 1 1 3 (flipxy '(2.4   16.5  2.0  24.5 1.8 32.7 1.6  49.0  1.5 65.41    1.2 98 .8  130.8)))
    (setf-aref fnc 2 1 2 1 (flipxy '(400   16.5  400  24.5 400 32.7  400 49.0 400 65.41    400  98 400 130.8)))
    (setf-aref fnc 2 1 2 2 (flipxy '( .2   16.5  .2   24.5 .35 32.7  .37 49.0  .4  65.41   .6   98 .8  130.8)))
    (setf-aref fnc 2 1 2 3 (flipxy '(6.0   16.5  5.0  24.5 4.0 32.7 3.0  49.0  2.7 65.41    2.2 98 1.8  130.8)))
    (setf-aref fnc 2 1 3 1 (flipxy '(2142  16.5  2142 24.5 2142 32.7 2142 49.0 2142 65.41 2142 98 2142 130.8)))
    (setf-aref fnc 2 1 3 2 (flipxy '(.02   16.5  .025 24.5 .05  32.7  .09 49.0  .13 65.41  .29 98 .4  130.8)))
    (setf-aref fnc 2 1 3 3 (flipxy '(9.0   16.5  8.0  24.5 7.2  32.7 5.5  49.0  3.9 65.41   3.0 98 1.8  130.8)))
    (setf-aref fnc 2 2 1 1 (flipxy '( 33   16.5  33   24.5  33 32.7  49  49.0  65  65.41    98  98 131 130.8)))
    (setf-aref fnc 2 2 1 2 (flipxy '( .75  16.5  .83  24.5 .91 32.7 .91  49.0  .91 65.41   .79  98 .67 130.8)))
    (setf-aref fnc 2 2 1 3 (flipxy '(2.5   16.5  2.5  24.5 2.5 32.7 2.1  49.0  1.8 65.41    1.4 98 1.0  130.8)))
    (setf-aref fnc 2 2 2 1 (flipxy '(1500  16.5 1500 24.5 1500 32.7 1500 49.0 1500 65.41   1500 98 1500 130.8)))
    (setf-aref fnc 2 2 2 2 (flipxy '( .01  16.5  .02  24.5 .02 32.7  .02 49.0  .02 65.41   .08  98 .08 130.8)))
    (setf-aref fnc 2 2 2 3 (flipxy '(1.5   16.5  1.37 24.5 1.25 32.7 1.07 49.0 0.9 65.41    0.7 98 0.5  130.8)))
    (setf-aref fnc 2 2 3 1 (flipxy '(2300  16.5  2300 24.5 2300 32.7 2325 49.0 2350 65.41 2375 98 2400 130.8)))
    (setf-aref fnc 2 2 3 2 (flipxy '(.05   16.5  .065 24.5 .70  32.7  .07 49.0  .07 65.41  .16 98 .2  130.8)))
    (setf-aref fnc 2 2 3 3 (flipxy '(11.0  16.5  10.0 24.5 10.0 32.7 7.7  49.0  5.4 65.41   3.7 98 2.0  130.8)))
    (setf-aref fnc 2 3 1 1 (flipxy '( 33   16.5  33   24.5  33 32.7  49  49.0  65  65.41    98  98 131 130.8)))
    (setf-aref fnc 2 3 1 2 (flipxy '( .75  16.5  .83  24.5 .87 32.7 .88  49.0  .90 65.41   .87  98 .85 130.8)))
    (setf-aref fnc 2 3 1 3 (flipxy '(1.4   16.5  1.4  24.5 1.4 32.7 1.4  49.0  1.4 65.41    1.4 98 1.4  130.8)))
    (setf-aref fnc 2 3 2 1 (flipxy '( 450  16.5  450 24.5  450 32.7  450 49.0  450 65.41    450 98 450 130.8)))
    (setf-aref fnc 2 3 2 2 (flipxy '( .01  16.5  .02  24.5 .08 32.7 .065 49.0  .05 65.41   .05  98 .05 130.8)))
    (setf-aref fnc 2 3 2 3 (flipxy '(3.0   16.5  2.6  24.5 2.1  32.7 1.75 49.0 1.4 65.41   1.05 98 0.7  130.8)))
    (setf-aref fnc 2 3 3 1 (flipxy '(2100  16.5  2100 24.5 2100 32.7 2125 49.0 2150 65.41 2175 98 2100 130.8)))
    (setf-aref fnc 2 3 3 2 (flipxy '(.05   16.5  .05  24.5 .05  32.7  .05 49.0  .05 65.41 .075 98 .1  130.8)))
    (setf-aref fnc 2 3 3 3 (flipxy '( 9.0  16.5   8.0 24.5  7.0 32.7 4.5  49.0  2.1 65.41  1.75 98 1.4  130.8)))
    (setf-aref fnc 2 4 1 1 (flipxy '( 33   16.5  33   24.5  33 32.7  49  49.0  65  65.41    98  98 131 130.8)))
    (setf-aref fnc 2 4 1 2 (flipxy '( .35  16.5  .40  24.5 .43 32.7 .47  49.0  .50 65.41   .57  98 .45 130.8)))
    (setf-aref fnc 2 4 1 3 (flipxy '(1.4   16.5  1.4  24.5 1.0 32.7 1.0  49.0  1.0 65.41    1.1 98 1.0  130.8)))
    (setf-aref fnc 2 4 2 1 (flipxy '( 300  16.5  300 24.5  300 32.7  300 49.0  300 65.41    300 98 300 130.8)))
    (setf-aref fnc 2 4 2 2 (flipxy '( .75  16.5  .80  24.5 .85 32.7 .90  49.0  .95 65.41   .99  98 .99 130.8)))
    (setf-aref fnc 2 4 2 3 (flipxy '(3.0   16.5  2.5  24.5 2.0  32.7 1.9  49.0 1.8 65.41   1.65 98 0.25 130.8)))
    (setf-aref fnc 2 4 3 1 (flipxy '(2200  16.5  2200 24.5 2200 32.7 2225 49.0 2250 65.41 2275 98 2300 130.8)))
    (setf-aref fnc 2 4 3 2 (flipxy '(.02   16.5  .02  24.5 .02  32.7 .035 49.0  .05 65.41 .07  98 .05  130.8)))
    (setf-aref fnc 2 4 3 3 (flipxy '( 5.0  16.5   4.0 24.5  3.0 32.7 2.8  49.0  2.6 65.41  1.9  98 1.2  130.8)))
    
    ;;   (sef-(aref fnc 2 5 1 1 (flipxy '(175   16.5  262  24.5 392 32.7  523 49.0  784 65.41  1046  98 1568 130.8)))
    (setf-aref fnc 2 5 1 1 (flipxy '( 33   16.5  33   24.5  33 32.7  49 49.0  65  65.41    98  98 131 130.8))) 
    
    (setf-aref fnc 2 5 1 2 (flipxy '( .40  16.5  .40  24.5 .80 32.7 .80  49.0  .80 65.41   .80  98 .80 130.8)))
    (setf-aref fnc 2 5 1 3 (flipxy '(0.1   16.5  0.1  24.5 0.1 32.7 0.1  49.0  0.0 65.41    0.0 98 0.0  130.8)))
    (setf-aref fnc 2 5 2 1 (flipxy '( 350  16.5  524 24.5  784 32.7  950 49.0 1568 65.41   2092 98 3136 130.8)))
    (setf-aref fnc 2 5 2 2 (flipxy '( .80  16.5  .80  24.5 .40 32.7 .20  49.0  .10 65.41   .10  98 .00 130.8)))
    (setf-aref fnc 2 5 2 3 (flipxy '(0.5   16.5  0.1  24.5 0.1  32.7 0.1  49.0 0.0 65.41   0.0  98 0.0  130.8)))
    (setf-aref fnc 2 5 3 1 (flipxy '(2700  16.5  2700 24.5 2500 32.7 2450 49.0 2400 65.41 2350 98 4500 130.8)))
    (setf-aref fnc 2 5 3 2 (flipxy '(.10   16.5  .15  24.5 .15  32.7 .15  49.0  .15 65.41 .10  98 .10  130.8)))
    (setf-aref fnc 2 5 3 3 (flipxy '( 2.0  16.5   1.6 24.5  1.6 32.7 1.6  49.0  1.6 65.41  1.5  98 1.0  130.8)))
    
    ;; these are vibrato frequencies functions (pitch dependent);
    
    (set! (vibfreqfun 1) (flipxy '(4.5 138.8 5 1568)))
    (set! (vibfreqfun 2) (flipxy '(4.5  16.5 5 130.8)))
    
    ;; these are index functions for cascade modulater (pitch dependent);
    
    (set! (i3fun1 1) (flipxy '(4 138.8 4 784 1 1568)))
    (set! (i3fun1 2) (flipxy '(4  16.5 4 65.41 1 130.8)))
    
    (set! (i3fun2 1) (flipxy '(.4 138.8 .1 1568)))
    (set! (i3fun2 2) (flipxy '(.4  16.5 .1 130.8)))))

(define (fncval ptr pitch)
  (envelope-interp pitch ptr))

(definstrument (fm-voice beg dur pitch amp vowel-1 sex-1 ampfun1 ampfun2 ampfun3 indxfun skewfun vibfun ranfun
			 dis pcrev deg vibscl pcran skewscl glissfun glissamt)
  (fillfnc)
  (let ((c 261.62)
	(vowel (floor vowel-1))
	(sex (floor sex-1))
	(ampref (expt amp .8))
	(deg (- deg 45))
	(ranfreq 20)
	(fm2 3)
	(mscale 1)
	(mconst 0)
	(indx1 1))
    (let ((vibfreq (fncval (vibfreqfun sex) pitch))
	  (vibpc (* .01 (log pitch 2) (+ .15 (sqrt amp)) vibscl))
	  (ranpc (* .002 (log pitch 2) (- 2 (expt amp .25)) pcran))
	  (skewpc (* skewscl (sqrt (+ .1 (* .05 ampref (if (= sex 1) (- 1568 130.8) (- 130.8 16.5)))))))
	  (form1 (/ (fncval (aref fnc sex vowel 1 1) pitch) pitch))
	  (form2 (/ (fncval (aref fnc sex vowel 2 1) pitch) pitch))
	  (form3 (/ (fncval (aref fnc sex vowel 3 1) pitch) pitch)))
      (let ((fmntfreq1 (round form1))
	    (fmntfreq2 (round form2))
	    (fmntfreq3 (round form3))
	    (mfq (+ (* pitch mscale) mconst)))
	(let ((amp1 (sqrt amp))
	      (amp2 (expt amp 1.5))
	      (amp3 (* amp amp))
	      (formscl1 (abs (- form1 fmntfreq1)))
	      (formscl2 (abs (- form2 fmntfreq2)))
	      (formscl3 (abs (- form3 fmntfreq3)))
	      (i3 (fncval ((if (< pitch (/ c 2)) i3fun1 i3fun2) sex) pitch))
	      (indx0 (if (memv vowel '(3 4)) 0 1.5)))
	  (let ((caramp1sc (* (fncval (aref fnc sex vowel 1 2) pitch) (- 1 formscl1) amp1))
		(caramp2sc (* (fncval (aref fnc sex vowel 2 2) pitch) (- 1 formscl2) amp2))
		(caramp3sc (* (fncval (aref fnc sex vowel 3 2) pitch) (- 1 formscl3) amp3))
		(scdev1 (fncval (aref fnc sex vowel 1 3) pitch))
		(scdev2 (fncval (aref fnc sex vowel 2 3) pitch))
		(scdev3 (fncval (aref fnc sex vowel 3 3) pitch))
		(dev (hz->radians (* i3 mfq)))
		(dev0 (hz->radians (* indx0 mfq)))
		(dev1 (hz->radians (* (- indx1 indx0) mfq))))
	    (let ((gens1 (make-oscil 0))
		  (gens2 (make-oscil 0 (/ pi 2.0)))
		  (gens2ampenv (make-env indxfun  :duration dur
					 :scaler (* scdev1 dev1)
					 :offset (* scdev1 dev0)))
		  (gens3 (make-oscil 0 (/ pi 2.0)))
		  (gens3ampenv (make-env indxfun  :duration dur
					 :scaler (* scdev2 dev1)
					 :offset (* scdev2 dev0)))
		  (gens4 (make-oscil 0 (/ pi 2.0)))
		  (gens4ampenv (make-env indxfun  :duration dur
					 :scaler (* scdev3 dev1)
					 :offset (* scdev3 dev0)))
		  (gens5 (make-oscil 0))
		  (gens5ampenv (make-env ampfun1 :duration dur
					 :scaler (* amp caramp1sc .75)))
		  (gens6 (make-oscil 0))
		  (gens6ampenv (make-env ampfun2 :duration dur
					 :scaler (* amp caramp2sc .75)))
		  (gens7 (make-oscil 0))
		  (gens7ampenv (make-env ampfun3 :duration dur
					 :scaler (* amp caramp3sc .75)))
		  (freqenv (make-env (addenv glissfun (* glissamt pitch) 0 skewfun (* skewpc pitch) pitch) :duration dur
				     :scaler (hz->radians 1.0)))
		  (pervenv (make-env vibfun :duration dur
				     :scaler vibpc))
		  (ranvenv (make-env :envelope ranfun :duration dur
				     :scaler ranpc))
		  (per-vib (make-triangle-wave :frequency vibfreq
					       :amplitude (hz->radians pitch)))
		  (ran-vib (make-rand-interp :frequency ranfreq
					     :amplitude (hz->radians pitch)))
		  (loc (make-locsig :degree deg :distance dis :reverb pcrev))
		  (start (floor (* *clm-srate* beg)))
		  (end (floor (* *clm-srate* (+ beg dur)))))
	      (do ((i start (+ i 1)))
		  ((= i end))
		(let* ((vib (+ (env freqenv) 
			       (* (env pervenv) 
				  (triangle-wave per-vib)) 
			       (* (env ranvenv) 
				  (rand-interp ran-vib))))
		       (cascadeout (* dev (oscil gens1 (* vib fm2)))))
		  (locsig loc i (+ (* (env gens5ampenv) 
				      (oscil gens5 (+ (* vib fmntfreq1)
						      (* (env gens2ampenv) 
							 (oscil gens2 (+ cascadeout (* vib mscale)))))))
				   (* (env gens6ampenv) 
				      (oscil gens6 (+ (* vib fmntfreq2)
						      (* (env gens3ampenv) 
							 (oscil gens3 (+ cascadeout (* vib mscale)))))))
				   (* (env gens7ampenv) 
				      (oscil gens7 (+ (* vib fmntfreq3)
						      (* (env gens4ampenv) 
							 (oscil gens4 (+ cascadeout (* vib mscale))))))))))))))))))

#|
(let ((ampf '(0 0 1 1 2 1 3 0))) 
  (with-sound (:play #t) (fm-voice 0 1 300 .8 3 1 ampf ampf ampf ampf ampf ampf ampf 1 0 0 .25 .01 0 ampf .01)))

(definstrument (fm-voice beg dur pitch amp vowel-1 sex-1 ampfun1 ampfun2 ampfun3 indxfun skewfun vibfun ranfun
			 dis pcrev deg vibscl pcran skewscl glissfun glissamt)

(define-macro (voi beg dur pitch amp vowel-1 sex-1 ampfun1 ampfun2 ampfun3 indxfun skewfun vibfun ranfun
		   dis pcrev deg vibscl skewscl)
  `(fm-voice ,beg ,dur ,pitch ,amp ,vowel-1 ,sex-1 ,ampfun1 ,ampfun2 ,ampfun3 ,indxfun ,skewfun ,vibfun ,ranfun
	     ,dis ,pcrev ,deg ,vibscl 0 ,skewscl '(0 0 100 0)))
|#
