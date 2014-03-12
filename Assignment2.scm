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
(solution '(1 -1 4))