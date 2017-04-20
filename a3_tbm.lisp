(defun tbm (cnt i a b)
	(defvar c)
	(defvar d)
	(defvar e)
	(defvar f)
	(defvar sum)
	(defvar cnt)

	(sb-thread:make-thread(lambda()
		(setq c (* a (logand b (expt 2 i))))
	))
	(sb-thread:make-thread(lambda()
		(setq d (* a (logand b (expt 2 (+ i 1)))))
	))
	(sb-thread:make-thread(lambda()
		(setq e (* a (logand b (expt 2 (+ i 2)))))
	))
	(sb-thread:make-thread(lambda()
		(setq f (* a (logand b (expt 2 (+ i 3)))))
	))
	
	(setq sum(+ c d e f))
	(setf cnt(- cnt 1))
	
	(if (<= cnt 0)
		(return-from tbm sum)
		(tbm cnt (+ i 4) a b))
)

(defun mult (a b)
	(defvar i)
	(setf i 0)
	(defvar fsum)
	(setf fsum 0)
	
	(setq cnt (/ (integer-length b ) 4))
	(setf fsum (tbm cnt i a b))
	
	(write fsum :base 2)
	(print fsum)

)

(defvar a)
(write-line "Enter Number:")
(setf a (read))

(defvar b)
(write-line "Enter Number:")
(setf b (read))
(mult a b)

