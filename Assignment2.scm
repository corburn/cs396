(define (circulate n l)
    (if (zero? n) l
    (circulate (- n 1) (append (cdr l) (list (car l))))))

; not a number
(define (nan? x)
    (not (= x x)))

; [(-b) +/- sqrt(b^2 - 4ac)]/(2a)
;(define (halfquad plusminus l)
;    (/ (plusminus (- (cadr l)) (sqrt (- (expt (cadr l) 2) (* 4 (* (car l) (caddr l)))))) (* (car l) 2)))
       
; [(-b) +/- sqrt(b^2 - 4ac)]/(2a)
;(define (halfquad plusminus abc)
;    (let ((a (car abc)) (b (cadr abc)) (c (caddr abc)))
;    (/ (plusminus (- b) (sqrt (- (expt b 2) (* 4 (* a c))))) (* a 2))))

; [(-b) +/- sqrt(b^2 - 4ac)]/(2a)
(define (halfquad plusminus l)
    (let ((result (/ (plusminus (- (cadr l)) (sqrt (- (expt (cadr l) 2) (* 4 (* (car l) (caddr l)))))) (* (car l) 2))))
    (if (nan? result) '() (list result))))
    
;(define (solution abc)
;    (if (null? (list (halfquad - abc) (halfquad + abc))) '(none)
;    (append (list (halfquad - abc)) (list (halfquad + abc)))))
    
(define (solution abc)
    (let ((result (append (halfquad - abc) (halfquad + abc))))
    (cond
    [(null? result) '(none)]
    [(= (car result) (cadr result)) (list (car result))]
    [else result])))
    
;(solution '(1 -5 4))
;(solution '(1 4 4))
;(solution '(1 -1 4))

(define start '((1 2 3) (4 5 6) (7 8 9) 
                (1 4 7) (2 5 8) (3 6 9) 
                (1 5 9) (3 5 7))')
    
(define (print-row x l)
; Takes in a row of numbers and the list l
(let ((row (car l))) ;Row is the current about to be printed row
    (cond ((eq? x 0) (print "\n")) ;if we are pointing to the end of the row, new line
    ((eq? x 1) (print (car row) "|" (cadr row) "|" (caddr row) "\n | | "))
    ;If we are about to print the last row, change the formatting so no _'s are printed
        (else(and (print (car row) "|" (cadr row) "|" (caddr row) "\n_|_|_") (print-row (- x 1) (cdr l))))))) ; for all other rows print _|_|_ and call recursively
    
(define (win? board)
    (cond
    ; Base - no win condition found
    [(null? board) #f]
    ; Win condition - 3 elements in a row
    [(for-all (lambda (e) (eq? e (caar board))) (car board)) #t]
    ; Check the reset of the board
    [else (win? (cdr board))]))

; Return a board with all occurences of position 'n' replaced with the 'player'
(define (move n player board)
    (if (null? board) '()
    (cons (map (lambda (e) (if (eq? e n) player e)) (car board)) (move n player (cdr board)))'))
    
(define (tic-tac-toe board players turns) ;The main game function to excecute all funtions/portions of the game
    (cond
    [(eq? turns 0) (print "Catsgame!")]
    [(win? board) (print (cadr players) " wins!")]
    [else (and (print (car players) " Enter a Position Number:") (let ((winning-squares (move (read) (car players) board)))
    (and (print-row 3 winning-squares)
    (tic-tac-toe winning-squares (cons (cadr players) (list (car players))) (- turns 1))
    )))]))

(tic-tac-toe start '(X O) 8') ;Turns is 8 which is the max # of moves before a cat's game

