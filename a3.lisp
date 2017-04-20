(defvar A)
(defvar B)
(defvar ans)

(defun add(A B)
	(+ A B)
)

(defun sub(A B)
	(- A B)
)

(defun mul(A B)
	(* A B)
)

(defun div(A B)
	(/ A B)
)

(write-line "Enter Values: ")
(setf A(read))
(setf B(read))

(write-line "")

(sb-thread:make-thread(lambda()
	(princ "Addition is: ")
	(write(add A B))
	(write-line "")
)
)

(sb-thread:make-thread(lambda()
	(princ "Subtraction is: ")
	(write(sub A B))
	(write-line "")
)
)

(sb-thread:make-thread(lambda()
	(princ "Multiplication is: ")
	(write(mul A B))
	(write-line "")
)
)

(sb-thread:make-thread(lambda()
	(princ "Division is: ")
	(write(div A B))
	(write-line "")
)
)
