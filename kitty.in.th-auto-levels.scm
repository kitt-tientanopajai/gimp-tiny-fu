;; kitty.in.th-auto-levels.scm
;; v. 0.06
;; Author Kitt Tientanopajai <kitty@kitty.in.th>
;; Copyright (C) 2005-2007 Kitt Tientanopajai"
;;
;; This is a free software and can be redistributed under GNU GPL version 2.
;; 
;; This script scans for min/max of RGB then span the channels to the maximum.
;;

(define (kitty.in.th-auto-levels image drawable thold step)
	(let* (
		(image-layer (car (gimp-layer-new-from-drawable drawable image)))
		(image-width (car (gimp-image-width image)))
		(image-height (car (gimp-image-height image)))
		(count 0)
		(rb 0)
		(rw 255)
		(gb 0)
		(gw 255)
		(bb 0)
		(bw 255))	

		(gimp-image-undo-group-start image)

		(gimp-layer-set-name image-layer "kitty.in.th - auto levels")
		(gimp-image-add-layer image image-layer -1)

		;; find lowest red
		(set! count (caddr (cddr (gimp-histogram image-layer 1 0 rb))))
		(while (< count thold) 
			(set! rb (+ rb step))
			(set! count (caddr (cddr (gimp-histogram image-layer 1 0 rb)))))

		;; find highest red
		(set! count (caddr (cddr (gimp-histogram image-layer 1 rw 255))))
		(while (< count thold) 
			(set! rw (- rw step))
			(set! count (caddr (cddr (gimp-histogram image-layer 1 rw 255)))))

		(gimp-levels image-layer 1 rb rw 1.0 0 255)

		;; find lowest green
		(set! count (caddr (cddr (gimp-histogram image-layer 2 0 gb))))
		(while (< count thold) 
			(set! gb (+ gb step))
			(set! count (caddr (cddr (gimp-histogram image-layer 2 0 gb)))))
		
		;; find highest green
		(set! count (caddr (cddr (gimp-histogram image-layer 2 gw 255))))
		(while (< count thold) 
			(set! gw (- gw step))
			(set! count (caddr (cddr (gimp-histogram image-layer 2 gw 255)))))

		(gimp-levels image-layer 2 gb gw 1.0 0 255)

		;; find lowest blue
		(set! count (caddr (cddr (gimp-histogram image-layer 3 0 bb))))
		(while (< count thold) 
			(set! bb (+ bb step))
			(set! count (caddr (cddr (gimp-histogram image-layer 3 0 bb)))))
		
		;; find highest blue
		(set! count (caddr (cddr (gimp-histogram image-layer 3 bw 255))))
		(while (< count thold) 
			(set! bw (- bw step))
			(set! count (caddr (cddr (gimp-histogram image-layer 3 bw 255)))))

		(gimp-levels image-layer 3 bb bw 1.0 0 255)

		(gimp-displays-flush)
		(gimp-image-undo-group-end image)))

(script-fu-register
	"kitty.in.th-auto-levels"
	"<Image>/Script-Fu/kitty.in.th/Auto Levels..."
	"kitty.in.th auto levels v.0.06"
	"Kitt Tientanopajai"
	"Copyright (C) 2005-2007 Kitt Tientanopajai"
	"November 14, 2007"
	"RGB RGBA GRAY GRAYA"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0
	SF-ADJUSTMENT "Threshold" '(0 0 255 1 5 0 0)
	SF-ADJUSTMENT "Step" '(5 1 255 1 5 0 0))
