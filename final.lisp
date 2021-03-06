(defvar a)
(defvar b)
(defvar c)
(defvar ans)
(defvar ans1)
(defvar cnt)
(defvar product)

(write-line "Enter First Number[with #b]:")
(setq a(read))
(write-line "Enter Second Number[with #b]:")
(setq b(read))

(write-line "Your Numbers:")
(format t "~b" a)
(write-line "")
(format t "~d" a)
(write-line "")
(format t "~b" b)
(write-line "")
(format t "~d" b)
(write-line "")

(sb-thread:make-thread(lambda()
	(progn (sleep 0)
		(write-line "Addition:")
		(setq c(+ a b))
		(format t "~b" c)
		(write-line "")
		(print c)
		(write-line "")
	)
))

(sb-thread:make-thread(lambda()
	(progn (sleep 0)
		(write-line "Subtraction:")
		(setq c(- a b))
		(format t "~b" c)
		(write-line "")
		(print c)
		(write-line "")
	)
))

(sb-thread:make-thread(lambda()
	(progn (sleep 0)
		(write-line "Division:")
		(setq c(/ a b))
		(format t "~b" c)
		(write-line "")
		(print c)
		(write-line "")
	)
))

(sb-thread:make-thread(lambda()
	(progn
		(setq ans 0)
		(setq ans1 0)
		(setq cnt(integer-length b))
		(if(= 1 (logand b 1))
			(setq ans(+ ans a))
		)
		(loop for i from 2 to cnt do
			(setq a(ash a 1))
			(setq b(ash b -1))
			(if(= 1 (logand b 1) )
				(setq ans1(+ ans1 a ))
			)
		)
		
		(setq product(+ ans ans1))
		(write-line "Multiplication:")
		(format t "~b" product)
		(write-line "")
		(print product)
		(write-line "")
	)
))
