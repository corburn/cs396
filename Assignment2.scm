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
                (1 5 9) (3 5 7)))

;(define (turn player)
;    (print player " plays:")
;    (let ((n (read)))
;    (move n))
;    )

(define (test board)
    (for-each (lambda (row) (print (car row) "|" (cadr row) "|" (caddr row) "\n_|_|_")) board))
    
(define (win? board)
    (cond
    ; Base - no win condition found
    [(null? board) #f]
    ; Win condition - 3 elements in a row
    [(for-all (lambda (e) (eq? e (caar board))) (car board)) #t]
    ; Check the reset of the board
    [else (win? (cdr board))]))
    
(define (catsgame? board)
    (cond
    ; Base
    [(null? board) #t]
    ; Does a row exist that does not contain an X and an O?
    []
    [else (catsgame? (cdr board))]
    )

(let ((x (car l)))
)

; Return a board with all occurences of position 'n' replaced with the 'player'
(define (move n player board)
    (if (null? board) '()
    (cons (map (lambda (e) (if (eq? e n) player e)) (car board)) (move n player (cdr board)))))
    
;(map and (lambda (l) (for-each (lambda (e) (eq? (car l) e)) l)) start) 

;(move 1 'X start)
    
;(define (catsgame? board)
;    )

;(define (same l)
;    (apply = l))

;(define (tic-tac-toe players board)
;    (if (win? board) (print (cadr players) " wins!")
;    (turn (car players) board)
;    (print board)
;    (tic-tac-toe (cons (cadr players) (list (car players))) board)
;    ))

;(tic-tac-toe '(X O) start)

